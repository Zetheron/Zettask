import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../l10n/app_localizations.dart';
import '../models/task_model.dart';
import 'database_service.dart';

abstract class TaskNotificationService {
  Future<void> init();
  Future<bool> requestPermissions();
  Future<void> scheduleTaskReminder(TaskModel task);
  Future<void> cancelTaskReminder(int taskId);
}

abstract class InteractiveNotificationService implements TaskNotificationService {
  Stream<NotificationResponse> get notificationResponses;
  Future<NotificationResponse?> getInitialNotificationResponse();
  Future<void> snoozeTaskReminder(
    TaskModel task, {
    Duration delay = NotificationService.defaultSnoozeDuration,
  });
  void updateLocalization(AppLocalizations l10n);
}

class NotificationStrings {
  const NotificationStrings({
    required this.actionComplete,
    required this.actionSnooze,
    required this.actionDismiss,
    required this.moreSubtasks,
    required this.subtasksSummary,
  });

  final String actionComplete;
  final String actionSnooze;
  final String actionDismiss;
  final String Function(int count) moreSubtasks;
  final String Function(int completed, int total) subtasksSummary;

  static final NotificationStrings indonesian = NotificationStrings(
    actionComplete: 'Selesai',
    actionSnooze: 'Tunda',
    actionDismiss: 'Tutup',
    moreSubtasks: (count) => '+$count lainnya',
    subtasksSummary: (completed, total) => '$completed/$total selesai',
  );

  factory NotificationStrings.fromLocalizations(AppLocalizations l10n) {
    return NotificationStrings(
      actionComplete: l10n.notificationActionComplete,
      actionSnooze: l10n.notificationActionSnooze,
      actionDismiss: l10n.notificationActionDismiss,
      moreSubtasks: l10n.notificationSubtasksMore,
      subtasksSummary: l10n.notificationSubtasksSummary,
    );
  }
}

class TaskReminderNotificationContent {
  const TaskReminderNotificationContent({
    required this.title,
    required this.body,
    required this.payload,
    required this.inboxLines,
    required this.summaryText,
    required this.androidDetails,
    required this.notificationDetails,
  });

  final String title;
  final String body;
  final String payload;
  final List<String> inboxLines;
  final String? summaryText;
  final AndroidNotificationDetails androidDetails;
  final NotificationDetails notificationDetails;
}

@pragma('vm:entry-point')
Future<void> zettaskNotificationBackgroundHandler(
  NotificationResponse response,
) async {
  final taskId = int.tryParse(response.payload ?? '');
  if (taskId == null) return;

  final actionId = response.actionId;
  if (actionId == NotificationService.actionCompleteId) {
    await DatabaseService.instance.toggleTaskComplete(taskId, true);
    await NotificationService.instance.cancelTaskReminder(taskId);
  } else if (actionId == NotificationService.actionSnoozeId) {
    final allTasks = await DatabaseService.instance.getAllTasks();
    for (final task in allTasks) {
      if (task.id == taskId && task.isActive) {
        await NotificationService.instance.snoozeTaskReminder(task);
        break;
      }
    }
  } else if (actionId == NotificationService.actionDismissId) {
    await NotificationService.instance.cancelTaskReminder(taskId);
  }
}

class NotificationService implements InteractiveNotificationService {
  NotificationService({
    FlutterLocalNotificationsPlugin? plugin,
    DateTime Function()? nowProvider,
    NotificationStrings? strings,
  })  : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
        _nowProvider = nowProvider ?? DateTime.now,
        _strings = strings ?? NotificationStrings.indonesian;

  static final NotificationService instance = NotificationService();

  static const String _androidChannelId = 'zettask_task_reminders';
  static const String _androidChannelName = 'Pengingat Tugas';
  static const String _androidChannelDescription =
      'Notifikasi pengingat untuk tugas terjadwal di Zettask.';

  static const String actionCompleteId = 'zettask_action_complete';
  static const String actionSnoozeId = 'zettask_action_snooze';
  static const String actionDismissId = 'zettask_action_dismiss';
  static const int maxSubtaskLines = 5;
  static const Duration defaultSnoozeDuration = Duration(minutes: 10);

  final FlutterLocalNotificationsPlugin _plugin;
  final DateTime Function() _nowProvider;
  final StreamController<NotificationResponse> _responseController =
      StreamController<NotificationResponse>.broadcast();

  NotificationStrings _strings;
  bool _isInitialized = false;
  bool _isTimezoneInitialized = false;
  bool _initialResponseConsumed = false;

  @override
  Stream<NotificationResponse> get notificationResponses =>
      _responseController.stream;

  @override
  void updateLocalization(AppLocalizations l10n) {
    _strings = NotificationStrings.fromLocalizations(l10n);
  }

  void _handleNotificationResponse(NotificationResponse response) {
    if (!_responseController.isClosed) {
      _responseController.add(response);
    }
  }

  @override
  Future<NotificationResponse?> getInitialNotificationResponse() async {
    if (_initialResponseConsumed) return null;
    _initialResponseConsumed = true;

    try {
      final details = await _plugin.getNotificationAppLaunchDetails();
      if (details != null && details.didNotificationLaunchApp) {
        return details.notificationResponse;
      }
    } on MissingPluginException {
      return null;
    } catch (e) {
      debugPrint(
        'NotificationService.getInitialNotificationResponse gagal: $e',
      );
    }
    return null;
  }

  @override
  Future<void> init() async {
    if (_isInitialized) return;

    await _initTimezone();

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
      macOS: darwinSettings,
    );

    try {
      await _plugin.initialize(
        settings: settings,
        onDidReceiveNotificationResponse: _handleNotificationResponse,
        onDidReceiveBackgroundNotificationResponse:
            zettaskNotificationBackgroundHandler,
      );
      _isInitialized = true;
    } on MissingPluginException {
      // Allow headless/test environments without native notification channels to continue safely.
    } catch (e) {
      debugPrint('NotificationService.init gagal: $e');
    }
  }

  Future<void> _initTimezone() async {
    if (_isTimezoneInitialized) return;

    tz_data.initializeTimeZones();
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }
    _isTimezoneInitialized = true;
  }

  @override
  Future<bool> requestPermissions() async {
    await init();

    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        if (androidPlugin == null) return false;

        final alreadyEnabled =
            await androidPlugin.areNotificationsEnabled() ?? false;
        if (alreadyEnabled) return true;

        return await androidPlugin.requestNotificationsPermission() ?? false;
      }

      if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
        return await iosPlugin?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
            false;
      }

      if (defaultTargetPlatform == TargetPlatform.macOS) {
        final macPlugin = _plugin.resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>();
        return await macPlugin?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
            false;
      }
    } on MissingPluginException {
      return false;
    } catch (e) {
      debugPrint('NotificationService.requestPermissions gagal: $e');
      return false;
    }

    return true;
  }

  static TaskReminderNotificationContent buildReminderContent(
    TaskModel task, {
    NotificationStrings? strings,
  }) {
    final resolvedStrings = strings ?? NotificationStrings.indonesian;
    final activeSubtasks = task.activeChecklistItems;
    final timeHint = _buildTimeReminderBody(task);
    final payload = (task.id ?? '').toString();

    final List<String> inboxLines;
    final String? summaryText;
    final String body;
    final StyleInformation? styleInformation;

    if (activeSubtasks.isNotEmpty) {
      final completedCount =
          activeSubtasks.where((item) => item.isDone).length;
      final totalCount = activeSubtasks.length;
      final resolvedSummary =
          resolvedStrings.subtasksSummary(completedCount, totalCount);
      final visibleCount = activeSubtasks.length > maxSubtaskLines
          ? maxSubtaskLines
          : activeSubtasks.length;
      final lines = <String>[
        for (var i = 0; i < visibleCount; i++)
          '${activeSubtasks[i].isDone ? '✓' : '○'} ${activeSubtasks[i].title.trim()}',
        if (activeSubtasks.length > maxSubtaskLines)
          resolvedStrings.moreSubtasks(activeSubtasks.length - maxSubtaskLines),
      ];
      inboxLines = List<String>.unmodifiable(lines);
      summaryText = resolvedSummary;
      body = '$resolvedSummary · ${lines.first}';
      styleInformation = InboxStyleInformation(
        lines,
        contentTitle: task.title,
        summaryText: resolvedSummary,
      );
    } else {
      inboxLines = const [];
      final note = task.description.trim();
      if (note.isNotEmpty) {
        summaryText = timeHint;
        body = note;
        styleInformation = BigTextStyleInformation(
          note,
          contentTitle: task.title,
          summaryText: timeHint,
        );
      } else {
        summaryText = null;
        body = timeHint;
        styleInformation = null;
      }
    }

    final androidDetails = AndroidNotificationDetails(
      _androidChannelId,
      _androidChannelName,
      channelDescription: _androidChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
      visibility: NotificationVisibility.public,
      category: AndroidNotificationCategory.reminder,
      styleInformation: styleInformation,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          actionCompleteId,
          resolvedStrings.actionComplete,
          cancelNotification: true,
          showsUserInterface: false,
        ),
        AndroidNotificationAction(
          actionSnoozeId,
          resolvedStrings.actionSnooze,
          cancelNotification: true,
          showsUserInterface: false,
        ),
        AndroidNotificationAction(
          actionDismissId,
          resolvedStrings.actionDismiss,
          cancelNotification: true,
          showsUserInterface: false,
        ),
      ],
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
      ),
    );

    return TaskReminderNotificationContent(
      title: task.title,
      body: body,
      payload: payload,
      inboxLines: inboxLines,
      summaryText: summaryText,
      androidDetails: androidDetails,
      notificationDetails: notificationDetails,
    );
  }

  @override
  Future<void> scheduleTaskReminder(TaskModel task) async {
    final taskId = task.id;
    if (taskId == null) return;

    if (!task.shouldScheduleReminder) {
      await cancelTaskReminder(taskId);
      return;
    }

    final reminderTime = task.reminderDateTime;
    if (reminderTime == null || !reminderTime.isAfter(_nowProvider())) {
      await cancelTaskReminder(taskId);
      return;
    }

    await _scheduleAt(task, reminderTime);
  }

  @override
  Future<void> snoozeTaskReminder(
    TaskModel task, {
    Duration delay = defaultSnoozeDuration,
  }) async {
    final taskId = task.id;
    if (taskId == null || !task.isActive) return;

    final targetTime = _nowProvider().add(delay);
    await _scheduleAt(task, targetTime);
  }

  Future<void> _scheduleAt(TaskModel task, DateTime targetTime) async {
    final taskId = task.id;
    if (taskId == null) return;

    await init();
    if (!_isInitialized) return;

    final scheduledTzDate = tz.TZDateTime(
      tz.local,
      targetTime.year,
      targetTime.month,
      targetTime.day,
      targetTime.hour,
      targetTime.minute,
      targetTime.second,
    );

    if (!scheduledTzDate.isAfter(tz.TZDateTime.now(tz.local))) {
      await cancelTaskReminder(taskId);
      return;
    }

    final content = buildReminderContent(task, strings: _strings);
    final scheduleMode = await _resolveAndroidScheduleMode();

    try {
      await _plugin.zonedSchedule(
        id: taskId,
        title: content.title,
        body: content.body,
        scheduledDate: scheduledTzDate,
        notificationDetails: content.notificationDetails,
        androidScheduleMode: scheduleMode,
        payload: content.payload,
      );
    } on PlatformException {
      // Android 14+ can revoke exact alarms at runtime; fall back to inexact scheduling instead of crashing.
      if (scheduleMode == AndroidScheduleMode.exactAllowWhileIdle) {
        try {
          await _plugin.zonedSchedule(
            id: taskId,
            title: content.title,
            body: content.body,
            scheduledDate: scheduledTzDate,
            notificationDetails: content.notificationDetails,
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            payload: content.payload,
          );
        } catch (e) {
          debugPrint('NotificationService fallback inexact gagal: $e');
        }
      }
    } on MissingPluginException {
      // No-op in test or unsupported host environments.
    } catch (e) {
      debugPrint('NotificationService.scheduleTaskReminder gagal: $e');
    }
  }

  @override
  Future<void> cancelTaskReminder(int taskId) async {
    try {
      await _plugin.cancel(id: taskId);
    } on MissingPluginException {
      // No-op in test or unsupported host environments.
    } catch (e) {
      debugPrint('NotificationService.cancelTaskReminder gagal: $e');
    }
  }

  Future<AndroidScheduleMode> _resolveAndroidScheduleMode() async {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return AndroidScheduleMode.inexactAllowWhileIdle;
    }

    try {
      final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      final canScheduleExact =
          await androidPlugin?.canScheduleExactNotifications() ?? false;
      return canScheduleExact
          ? AndroidScheduleMode.exactAllowWhileIdle
          : AndroidScheduleMode.inexactAllowWhileIdle;
    } catch (_) {
      return AndroidScheduleMode.inexactAllowWhileIdle;
    }
  }

  static String _buildTimeReminderBody(TaskModel task) {
    final startTime = task.startTime?.trim() ?? '';
    final minutes = task.reminderMinutesBefore ?? 0;
    if (minutes == 0) {
      return startTime.isNotEmpty
          ? 'Dimulai sekarang ($startTime)'
          : 'Waktunya memulai tugas ini';
    }
    if (minutes == 60) {
      return 'Mulai dalam 1 jam ($startTime)';
    }
    return 'Mulai dalam $minutes menit ($startTime)';
  }
}
