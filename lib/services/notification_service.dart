import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../models/task_model.dart';

abstract class TaskNotificationService {
  Future<void> init();
  Future<bool> requestPermissions();
  Future<void> scheduleTaskReminder(TaskModel task);
  Future<void> cancelTaskReminder(int taskId);
}

class NotificationService implements TaskNotificationService {
  NotificationService({
    FlutterLocalNotificationsPlugin? plugin,
    DateTime Function()? nowProvider,
  })  : _plugin = plugin ?? FlutterLocalNotificationsPlugin(),
        _nowProvider = nowProvider ?? DateTime.now;

  static final NotificationService instance = NotificationService();

  static const String _androidChannelId = 'zettask_task_reminders';
  static const String _androidChannelName = 'Pengingat Tugas';
  static const String _androidChannelDescription =
      'Notifikasi pengingat untuk tugas terjadwal di Zettask.';

  final FlutterLocalNotificationsPlugin _plugin;
  final DateTime Function() _nowProvider;

  bool _isInitialized = false;
  bool _isTimezoneInitialized = false;

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
      await _plugin.initialize(settings: settings);
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

    await init();
    if (!_isInitialized) return;

    final scheduledTzDate = tz.TZDateTime(
      tz.local,
      reminderTime.year,
      reminderTime.month,
      reminderTime.day,
      reminderTime.hour,
      reminderTime.minute,
    );

    if (!scheduledTzDate.isAfter(tz.TZDateTime.now(tz.local))) {
      await cancelTaskReminder(taskId);
      return;
    }

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannelId,
        _androidChannelName,
        channelDescription: _androidChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
      ),
    );

    final body = _buildNotificationBody(task);
    final scheduleMode = await _resolveAndroidScheduleMode();

    try {
      await _plugin.zonedSchedule(
        id: taskId,
        title: task.title,
        body: body,
        scheduledDate: scheduledTzDate,
        notificationDetails: details,
        androidScheduleMode: scheduleMode,
        payload: taskId.toString(),
      );
    } on PlatformException {
      // Android 14+ can revoke exact alarms at runtime; fall back to inexact scheduling instead of crashing.
      if (scheduleMode == AndroidScheduleMode.exactAllowWhileIdle) {
        try {
          await _plugin.zonedSchedule(
            id: taskId,
            title: task.title,
            body: body,
            scheduledDate: scheduledTzDate,
            notificationDetails: details,
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            payload: taskId.toString(),
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

  static String _buildNotificationBody(TaskModel task) {
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
