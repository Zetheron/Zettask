import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zettask/l10n/app_localizations.dart';
import 'package:zettask/l10n/l10n_helpers.dart';
import 'package:zettask/main.dart';
import 'package:zettask/models/calendar_event_model.dart';
import 'package:zettask/models/note_model.dart';
import 'package:zettask/models/project_model.dart';
import 'package:zettask/models/repeating_task_model.dart';
import 'package:zettask/models/stats_model.dart';
import 'package:zettask/models/tag_model.dart';
import 'package:zettask/models/task_model.dart';
import 'package:zettask/models/task_template_model.dart';
import 'package:zettask/providers/app_lock_provider.dart';
import 'package:zettask/providers/calendar_provider.dart';
import 'package:zettask/providers/task_provider.dart';
import 'package:zettask/services/app_lock_service.dart';
import 'package:zettask/services/calendar_service.dart';
import 'package:zettask/services/cloud_sync_service.dart';
import 'package:zettask/services/database_service.dart';
import 'package:zettask/services/export_service.dart';
import 'package:zettask/services/home_widget_service.dart';
import 'package:zettask/services/notification_service.dart';
import 'package:zettask/widgets/app_lock_gate.dart';
import 'package:zettask/widgets/calendar_sync_sheet.dart';
import 'package:zettask/widgets/timeline_task_item.dart';

class _PatchFakeDatabase implements DatabaseService {
  _PatchFakeDatabase([List<TaskModel>? seed]) {
    if (seed != null) {
      for (final task in seed) {
        final id = task.id ?? _nextId++;
        if (id >= _nextId) _nextId = id + 1;
        _tasks[id] = task.copyWith(id: id);
      }
    }
  }

  final Map<int, TaskModel> _tasks = {};
  int _nextId = 1;

  @override
  Future<Database> get database => throw UnimplementedError();

  @override
  Future<int> insertTask(TaskModel task) async {
    final id = task.id ?? _nextId++;
    _tasks[id] = task.copyWith(id: id);
    return id;
  }

  @override
  Future<List<TaskModel>> getTasksByDate(DateTime date) async {
    final key = TaskModel.formatDateKey(date);
    return _tasks.values
        .where((t) => t.date != null && TaskModel.formatDateKey(t.date!) == key)
        .toList();
  }

  @override
  Future<List<TaskModel>> getTasksInDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final startKey = TaskModel.formatDateKey(start);
    final endKey = TaskModel.formatDateKey(end);
    return _tasks.values.where((t) {
      if (t.date == null) return false;
      final key = TaskModel.formatDateKey(t.date!);
      return key.compareTo(startKey) >= 0 && key.compareTo(endKey) <= 0;
    }).toList();
  }

  @override
  Future<List<TaskModel>> getUnplannedTasks() async =>
      _tasks.values.where((t) => t.date == null).toList();

  @override
  Future<List<TaskModel>> getOverdueTasks(DateTime today) async {
    final todayKey = TaskModel.formatDateKey(today);
    return _tasks.values
        .where(
          (t) =>
              !t.isCompleted &&
              !t.isCancelled &&
              t.date != null &&
              TaskModel.formatDateKey(t.date!).compareTo(todayKey) < 0,
        )
        .toList();
  }

  @override
  Future<Set<String>> getDatesWithTasks(DateTime start, DateTime end) async {
    final list = await getTasksInDateRange(start, end);
    return list
        .where((t) => t.date != null)
        .map((t) => TaskModel.formatDateKey(t.date!))
        .toSet();
  }

  @override
  Future<List<TaskModel>> searchTasks(String query) async => const [];

  @override
  Future<int> updateTask(TaskModel task) async {
    if (task.id == null) throw ArgumentError('Task id null');
    _tasks[task.id!] = task;
    return 1;
  }

  @override
  Future<int> toggleTaskComplete(
    int id,
    bool isCompleted, {
    DateTime? completedAt,
  }) async {
    final existing = _tasks[id];
    if (existing == null) return 0;
    _tasks[id] = existing.copyWith(
      isCompleted: isCompleted,
      isCancelled: false,
      completedAt: isCompleted ? (completedAt ?? DateTime.now()) : null,
      clearCompletedAt: !isCompleted,
    );
    return 1;
  }

  @override
  Future<List<TaskModel>> getAllTasks() async => _tasks.values.toList();

  @override
  Future<List<DailyCompletionStat>> getLast7DaysCompletionStats(
    DateTime today,
  ) async =>
      WorkspaceStats.compute(
        tasks: _tasks.values.toList(),
        projects: const [],
        today: today,
      ).last7Days;

  @override
  Future<List<DailyCompletionStat>> getLast30DaysCompletionStats(
    DateTime today,
  ) async =>
      WorkspaceStats.compute(
        tasks: _tasks.values.toList(),
        projects: const [],
        today: today,
      ).last30Days;

  @override
  Future<int> deleteTask(int id) async {
    _tasks.remove(id);
    return 1;
  }

  @override
  Future<int> insertRepeatingRule(RepeatingTaskRule rule) async => 1;

  @override
  Future<List<RepeatingTaskRule>> getRepeatingRules({
    bool activeOnly = true,
  }) async =>
      const [];

  @override
  Future<RepeatingTaskRule?> getRepeatingRuleById(int id) async => null;

  @override
  Future<int> updateRepeatingRule(RepeatingTaskRule rule) async => 1;

  @override
  Future<int> deleteRepeatingRule(int id) async => 1;

  @override
  Future<bool> hasTaskForRepeatingRuleOnDate(
    int ruleId,
    DateTime date,
  ) async =>
      false;

  @override
  Future<List<TaskModel>> getIncompleteFutureTasksForRule(
    int ruleId,
    DateTime fromDate,
  ) async =>
      const [];

  @override
  Future<int> deleteIncompleteFutureTasksForRule(
    int ruleId,
    DateTime fromDate,
  ) async =>
      0;

  @override
  Future<int> getCompletedCountForRule(int ruleId) async => 0;

  @override
  Future<Set<String>> getCompletedDatesForRuleInRange(
    int ruleId,
    DateTime start,
    DateTime end,
  ) async =>
      const {};

  @override
  Future<int> insertProject(ProjectModel project) async => 1;

  @override
  Future<List<ProjectModel>> getProjects() async => const [];

  @override
  Future<int> updateProject(ProjectModel project) async => 1;

  @override
  Future<int> deleteProject(int id) async => 1;

  @override
  Future<int> insertTag(TagModel tag) async => 1;

  @override
  Future<List<TagModel>> getTags() async => const [];

  @override
  Future<int> updateTag(TagModel tag) async => 1;

  @override
  Future<int> deleteTag(int id) async => 1;

  @override
  Future<int> insertNote(NoteModel note) async => 1;

  @override
  Future<List<NoteModel>> getNotes() async => const [];

  @override
  Future<int> updateNote(NoteModel note) async => 1;

  @override
  Future<int> deleteNote(int id) async => 1;

  @override
  Future<int> insertTemplate(TaskTemplateModel template) async => 1;

  @override
  Future<List<TaskTemplateModel>> getTemplates() async => const [];

  @override
  Future<int> updateTemplate(TaskTemplateModel template) async => 1;

  @override
  Future<int> deleteTemplate(int id) async => 1;

  @override
  Future<List<TaskModel>> getTasksByProject(int projectId) async =>
      _tasks.values.where((t) => t.projectId == projectId).toList();

  @override
  Future<List<TaskModel>> getTasksByTag(int tagId) async =>
      _tasks.values.where((t) => t.tagId == tagId).toList();

  @override
  Future<Map<int, ProjectProgress>> getProjectTaskCounts() async => const {};

  @override
  Future<Map<int, int>> getTagTaskCounts() async => const {};

  @override
  Future<void> close() async {}
}

class _PatchFakeNotificationService implements TaskNotificationService {
  final List<int> cancelledIds = [];

  @override
  Future<void> init() async {}

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<void> scheduleTaskReminder(TaskModel task) async {}

  @override
  Future<void> cancelTaskReminder(int taskId) async {
    cancelledIds.add(taskId);
  }
}

class _PatchFakeHomeWidgetService implements HomeWidgetSyncService {
  final StreamController<Uri?> _clicks = StreamController<Uri?>.broadcast();
  List<TaskModel> lastSyncedTasks = const [];

  @override
  Future<void> updateTodayTasks(
    List<TaskModel> todayTasks, {
    String? widgetTitle,
    String? widgetEmptyText,
  }) async {
    lastSyncedTasks = List<TaskModel>.from(todayTasks);
  }

  @override
  Future<void> updateWidgetLabels({
    required String widgetTitle,
    required String widgetEmptyText,
  }) async {}

  @override
  Future<Uri?> getInitiallyLaunchedUri() async => null;

  @override
  Stream<Uri?> get widgetClicked => _clicks.stream;

  void dispose() => _clicks.close();
}

class _PatchFakeAppLockService implements AppLockService {
  _PatchFakeAppLockService({
    this.supported = true,
    this.nextAuthResult = true,
  });

  bool supported;
  bool nextAuthResult;

  @override
  Future<bool> isDeviceSupported() async => supported;

  @override
  Future<bool> authenticate({required String reason}) async => nextAuthResult;
}

class _PatchFakePrivacyService implements ScreenPrivacyService {
  final List<bool> calls = [];

  @override
  Future<void> setSecureScreen(bool enabled) async {
    calls.add(enabled);
  }
}

class _PatchFakeCalendarService implements DeviceCalendarService {
  _PatchFakeCalendarService({
    this.granted = false,
    this.permanentlyDenied = false,
    this.grantOnRequest = false,
  });

  bool granted;
  bool permanentlyDenied;
  bool grantOnRequest;
  int requestCount = 0;
  int openSettingsCount = 0;

  @override
  Future<bool> hasPermissions() async => granted;

  @override
  Future<bool> requestPermissions() async {
    requestCount++;
    if (grantOnRequest) {
      granted = true;
      permanentlyDenied = false;
    }
    return granted;
  }

  @override
  Future<bool> isPermissionPermanentlyDenied() async =>
      !granted && permanentlyDenied;

  @override
  Future<bool> openSettings() async {
    openSettingsCount++;
    return true;
  }

  @override
  Future<List<DeviceCalendarInfo>> getCalendars() async => const [
        DeviceCalendarInfo(
          id: 'cal_work',
          name: 'Kerja',
          colorHex: '#2563EB',
          isPrimary: true,
        ),
      ];

  @override
  Future<List<CalendarEventModel>> getEventsForDate(
    DateTime date,
    Set<String> selectedCalendarIds,
  ) async =>
      const [];
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting();
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
      'TaskModel serialisasi is_cancelled, eksklusi dari Overdue, Stats, HomeWidget, CSV, dan CloudSyncMerger',
      () async {
    final today = DateTime(2026, 11, 20);
    final yesterday = DateTime(2026, 11, 19);

    final cancelled = TaskModel(
      id: 10,
      title: 'Rapat yang batal',
      date: yesterday,
      startTime: '09:00',
      isCompleted: false,
      isCancelled: true,
      reminderMinutesBefore: 10,
      projectId: 1,
      tagId: 2,
    );

    final map = cancelled.toMap();
    expect(map['is_cancelled'], 1);
    expect(cancelled.shouldScheduleReminder, isFalse);

    final restored = TaskModel.fromMap(map);
    expect(restored.isCancelled, isTrue);
    expect(restored.isCompleted, isFalse);

    // Eksklusi dari Overdue & Stats
    final activeToday = TaskModel(
      id: 11,
      title: 'Kerjakan patch',
      date: today,
      isCompleted: false,
      projectId: 1,
      tagId: 2,
    );
    final doneToday = TaskModel(
      id: 12,
      title: 'Review PR',
      date: today,
      isCompleted: true,
      completedAt: DateTime(2026, 11, 20, 10, 0),
      projectId: 1,
      tagId: 2,
    );

    final fakeDb = _PatchFakeDatabase([cancelled, activeToday, doneToday]);
    final fakeNotif = _PatchFakeNotificationService();
    final fakeWidget = _PatchFakeHomeWidgetService();
    addTearDown(fakeWidget.dispose);

    final provider = TaskProvider(
      databaseService: fakeDb,
      notificationService: fakeNotif,
      homeWidgetService: fakeWidget,
      initialDate: today,
      nowProvider: () => today,
    );
    await provider.initialize();

    expect(provider.overdueCount, 0);
    expect(provider.activeTaskCount, 1);

    // Stats tidak menghitung tugas batal sebagai selesai maupun total aktif
    final project = ProjectModel(id: 1, name: 'Zettask', colorHex: '#0D9488');
    final tag = TagModel(id: 2, name: 'Dev', colorHex: '#2563EB');
    final stats = WorkspaceStats.compute(
      tasks: [cancelled, activeToday, doneToday],
      projects: [project],
      tags: [tag],
      today: today,
    );
    expect(stats.allTimeCompletedTasks, 1);
    expect(stats.totalTasks, 2);
    expect(stats.breakdownByProject.first.completedCount, 1);
    expect(stats.breakdownByProject.first.totalCount, 2);
    expect(stats.breakdownByTag.first.completedCount, 1);
    expect(stats.breakdownByTag.first.totalCount, 2);

    // Home Screen Widget payload mengecualikan tugas batal
    final payload = AndroidHomeWidgetService.buildPayload([
      cancelled.copyWith(date: today),
      activeToday,
      doneToday,
    ]);
    expect(payload.activeCount, 1);
    expect(payload.tasksJson, contains('Kerjakan patch'));
    expect(payload.tasksJson, isNot(contains('Rapat yang batal')));

    // CSV menuliskan status Dibatalkan
    final csv = CsvExportService.buildTasksCsv(
      tasks: [cancelled],
      projectNames: const {1: 'Zettask'},
      tagNames: const {2: 'Dev'},
    );
    expect(csv, contains('Dibatalkan'));

    // CloudSyncMerger mempertahankan status isCancelled
    final mergePlan = CloudSyncMerger.merge(
      local: SyncDataset(tasks: [cancelled]),
      cloud: SyncDataset(tasks: [cancelled.copyWith(isCancelled: false)]),
      lastSyncedAt: DateTime(2026, 11, 19),
    );
    expect(mergePlan.merged.tasks.first.isCancelled, isTrue);
  });

  testWidgets(
      'Opsi A pada TimelineTaskItem: ketuk 1x = Selesai (✓), tekan tahan = Dibatalkan (✕) + Undo, ketuk lagi = Aktif (○)',
      (WidgetTester tester) async {
    final today = DateTime(2026, 11, 20);
    final fakeDb = _PatchFakeDatabase([
      TaskModel(
        id: 1,
        title: 'Kirim dokumen rilis',
        date: today,
        startTime: '09:30',
        priority: TaskPriority.high,
      ),
    ]);
    final fakeWidget = _PatchFakeHomeWidgetService();
    addTearDown(fakeWidget.dispose);

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: fakeDb,
        notificationService: _PatchFakeNotificationService(),
        calendarService: _PatchFakeCalendarService(),
        homeWidgetService: fakeWidget,
        initialLocale: const Locale('id'),
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    final circleFinder = find.byKey(const ValueKey('task_status_circle'));
    expect(circleFinder, findsOneWidget);

    // 1. Ketuk 1x -> Selesai (✓)
    await tester.tap(circleFinder);
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: circleFinder,
        matching: find.byIcon(Icons.check_rounded),
      ),
      findsOneWidget,
    );

    // 2. Tekan tahan (long-press) -> Dibatalkan (✕) + SnackBar Undo
    await tester.longPress(circleFinder);
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: circleFinder,
        matching: find.byIcon(Icons.close_rounded),
      ),
      findsOneWidget,
    );
    expect(find.text('Tugas ditandai dibatalkan'), findsOneWidget);
    expect(find.text('Urungkan'), findsOneWidget);

    // Pastikan warna teks judul menjadi redup + strikethrough
    final titleWidget = tester.widget<Text>(find.text('Kirim dokumen rilis'));
    expect(titleWidget.style?.decoration, TextDecoration.lineThrough);

    // 3. Ketuk 1x saat status Dibatalkan (✕) -> kembali Aktif (○)
    await tester.tap(circleFinder);
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: circleFinder,
        matching: find.byIcon(Icons.close_rounded),
      ),
      findsNothing,
    );
    expect(
      find.descendant(
        of: circleFinder,
        matching: find.byIcon(Icons.check_rounded),
      ),
      findsNothing,
    );

    // Verifikasi TimelineTaskItem widget itu sendiri tetap ter-render
    expect(find.byType(TimelineTaskItem), findsOneWidget);
  });

  testWidgets(
      'AppLockProvider memanggil setSecureScreen dan AppLockGate menampilkan privacy overlay saat inactive',
      (WidgetTester tester) async {
    final privacy = _PatchFakePrivacyService();
    final lockService = _PatchFakeAppLockService(
      supported: true,
      nextAuthResult: true,
    );
    var now = DateTime(2026, 11, 20, 9, 0);

    final provider = AppLockProvider(
      appLockService: lockService,
      privacyService: privacy,
      nowProvider: () => now,
      gracePeriod: const Duration(seconds: 5),
    );
    await provider.initialize();
    expect(privacy.calls, [false]);

    // Aktifkan App Lock -> setSecureScreen(true)
    final enabled = await provider.setEnabled(true);
    expect(enabled, isTrue);
    expect(privacy.calls, [false, true]);

    await tester.pumpWidget(
      ChangeNotifierProvider<AppLockProvider>.value(
        value: provider,
        child: const MaterialApp(
          locale: Locale('id'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: zettaskLocalizationsDelegates,
          home: AppLockGate(
            child: Scaffold(
              body: Center(child: Text('Daftar Tugas Pribadi')),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('app_lock_privacy_overlay')), findsNothing);

    // Masuk inactive (Recent Apps) -> privacy overlay langsung muncul
    provider.handleLifecycleStateChanged(AppLifecycleState.inactive);
    await tester.pump();
    expect(
      find.byKey(const ValueKey('app_lock_privacy_overlay')),
      findsOneWidget,
    );

    // Kembali resumed sebelum grace period -> overlay hilang
    now = now.add(const Duration(seconds: 1));
    provider.handleLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(find.byKey(const ValueKey('app_lock_privacy_overlay')), findsNothing);

    // Nonaktifkan App Lock -> setSecureScreen(false)
    await provider.setEnabled(false);
    expect(privacy.calls, [false, true, false]);
  });

  test('PlatformScreenPrivacyService mengirim MethodChannel setSecureScreen',
      () async {
    final received = <MethodCall>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      PlatformScreenPrivacyService.channel,
      (call) async {
        received.add(call);
        return null;
      },
    );
    addTearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(PlatformScreenPrivacyService.channel, null);
    });

    final service = PlatformScreenPrivacyService(enforceAndroidOnly: false);
    await service.setSecureScreen(true);
    await service.setSecureScreen(false);

    expect(received.length, 2);
    expect(received[0].method, 'setSecureScreen');
    expect(received[0].arguments, {'enabled': true});
    expect(received[1].arguments, {'enabled': false});
  });

  testWidgets(
      'CalendarSyncSheet meminta izin runtime, menangguhkan AppLock, menampilkan fallback Pengaturan Aplikasi, dan menyegarkan saat resumed',
      (WidgetTester tester) async {
    final calendarService = _PatchFakeCalendarService(
      granted: false,
      permanentlyDenied: false,
      grantOnRequest: false,
    );
    final calendarProvider = CalendarProvider(
      calendarService: calendarService,
      initialDate: DateTime(2026, 11, 20),
    );
    await calendarProvider.initialize();

    final lockProvider = AppLockProvider(
      appLockService: _PatchFakeAppLockService(),
      privacyService: _PatchFakePrivacyService(),
    );
    await lockProvider.initialize();
    await lockProvider.setEnabled(true);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CalendarProvider>.value(
            value: calendarProvider,
          ),
          ChangeNotifierProvider<AppLockProvider>.value(value: lockProvider),
        ],
        child: const MaterialApp(
          locale: Locale('id'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: zettaskLocalizationsDelegates,
          home: Scaffold(body: CalendarSyncSheet()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Ketuk Berikan Izin Kalender -> panggil requestPermissions
    await tester.tap(find.text('Berikan Izin Kalender'));
    await tester.pumpAndSettle();
    expect(calendarService.requestCount, 1);

    // Karena tidak diberikan, tombol fallback Buka Pengaturan langsung tampil
    expect(find.text('Buka Pengaturan'), findsOneWidget);

    // Ketuk Buka Pengaturan -> panggil openSettings
    await tester.tap(find.text('Buka Pengaturan'));
    await tester.pumpAndSettle();
    expect(calendarService.openSettingsCount, 1);

    // Simulasikan pengguna mengaktifkan izin di Pengaturan Android lalu kembali (resumed)
    calendarService.granted = true;
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(calendarProvider.hasPermission, isTrue);
    expect(calendarProvider.isSyncEnabled, isTrue);
    expect(find.text('Kerja'), findsOneWidget);
  });
}
