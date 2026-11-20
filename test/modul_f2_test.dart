import 'dart:async';
import 'dart:convert';

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
import 'package:zettask/providers/task_provider.dart';
import 'package:zettask/screens/lock_screen.dart';
import 'package:zettask/services/app_lock_service.dart';
import 'package:zettask/services/calendar_service.dart';
import 'package:zettask/services/database_service.dart';
import 'package:zettask/services/home_widget_service.dart';
import 'package:zettask/services/notification_service.dart';
import 'package:zettask/services/subscription_service.dart';
import 'package:zettask/widgets/app_lock_gate.dart';
import 'package:zettask/widgets/quick_add_task_sheet.dart';

class FakeAppLockService implements AppLockService {
  FakeAppLockService({
    this.supported = true,
    this.nextAuthResult = true,
  });

  bool supported;
  bool nextAuthResult;
  int authenticateCallCount = 0;
  String? lastReason;

  @override
  Future<bool> isDeviceSupported() async => supported;

  @override
  Future<bool> authenticate({required String reason}) async {
    authenticateCallCount++;
    lastReason = reason;
    return nextAuthResult;
  }
}

class FakeHomeWidgetSyncService implements HomeWidgetSyncService {
  FakeHomeWidgetSyncService({this.initialUri});

  final StreamController<Uri?> _clickController =
      StreamController<Uri?>.broadcast();

  Uri? initialUri;
  int updateCallCount = 0;
  int labelUpdateCallCount = 0;
  List<TaskModel> lastTodayTasks = const [];
  String? lastWidgetTitle;
  String? lastWidgetEmptyText;

  void emitWidgetClick(Uri uri) {
    _clickController.add(uri);
  }

  @override
  Future<void> updateTodayTasks(
    List<TaskModel> todayTasks, {
    String? widgetTitle,
    String? widgetEmptyText,
  }) async {
    updateCallCount++;
    lastTodayTasks = List<TaskModel>.from(todayTasks);
    if (widgetTitle != null) lastWidgetTitle = widgetTitle;
    if (widgetEmptyText != null) lastWidgetEmptyText = widgetEmptyText;
  }

  @override
  Future<void> updateWidgetLabels({
    required String widgetTitle,
    required String widgetEmptyText,
  }) async {
    labelUpdateCallCount++;
    lastWidgetTitle = widgetTitle;
    lastWidgetEmptyText = widgetEmptyText;
  }

  @override
  Future<Uri?> getInitiallyLaunchedUri() async => initialUri;

  @override
  Stream<Uri?> get widgetClicked => _clickController.stream;

  void dispose() {
    _clickController.close();
  }
}

class _NoopNotificationService implements TaskNotificationService {
  @override
  Future<void> init() async {}

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<void> scheduleTaskReminder(TaskModel task) async {}

  @override
  Future<void> cancelTaskReminder(int taskId) async {}
}

class _NoopCalendarService implements DeviceCalendarService {
  @override
  Future<bool> hasPermissions() async => false;

  @override
  Future<bool> requestPermissions() async => false;

  @override
  Future<bool> isPermissionPermanentlyDenied() async => false;

  @override
  Future<bool> openSettings() async => false;

  @override
  Future<List<DeviceCalendarInfo>> getCalendars() async => const [];

  @override
  Future<List<CalendarEventModel>> getEventsForDate(
    DateTime date,
    Set<String> selectedCalendarIds,
  ) async =>
      const [];
}

class _InMemoryDatabaseService implements DatabaseService {
  _InMemoryDatabaseService([List<TaskModel>? seed]) {
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
    if (id >= _nextId) _nextId = id + 1;
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
              t.date != null &&
              TaskModel.formatDateKey(t.date!).compareTo(todayKey) < 0,
        )
        .toList();
  }

  @override
  Future<Set<String>> getDatesWithTasks(DateTime start, DateTime end) async {
    final tasks = await getTasksInDateRange(start, end);
    return tasks
        .where((t) => t.date != null)
        .map((t) => TaskModel.formatDateKey(t.date!))
        .toSet();
  }

  @override
  Future<List<TaskModel>> searchTasks(String query) async => const [];

  @override
  Future<int> updateTask(TaskModel task) async {
    final id = task.id;
    if (id == null) throw ArgumentError('Task id null');
    _tasks[id] = task;
    return 1;
  }

  @override
  Future<int> toggleTaskComplete(
    int id,
    bool isCompleted, {
    DateTime? completedAt,
  }) async {
    final current = _tasks[id];
    if (current == null) return 0;
    _tasks[id] = current.copyWith(
      isCompleted: isCompleted,
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
      WorkspaceStats.empty(today: today).last7Days;

  @override
  Future<List<DailyCompletionStat>> getLast30DaysCompletionStats(
    DateTime today,
  ) async =>
      WorkspaceStats.empty(today: today).last30Days;

  @override
  Future<int> deleteTask(int id) async => _tasks.remove(id) != null ? 1 : 0;

  @override
  Future<int> insertRepeatingRule(RepeatingTaskRule rule) async => 1;

  @override
  Future<List<RepeatingTaskRule>> getRepeatingRules({
    bool activeOnly = false,
  }) async =>
      const [];

  @override
  Future<RepeatingTaskRule?> getRepeatingRuleById(int id) async => null;

  @override
  Future<int> updateRepeatingRule(RepeatingTaskRule rule) async => 0;

  @override
  Future<int> deleteRepeatingRule(int id) async => 0;

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
  Future<int> updateProject(ProjectModel project) async => 0;

  @override
  Future<int> deleteProject(int id) async => 0;

  @override
  Future<int> insertTag(TagModel tag) async => 1;

  @override
  Future<List<TagModel>> getTags() async => const [];

  @override
  Future<int> updateTag(TagModel tag) async => 0;

  @override
  Future<int> deleteTag(int id) async => 0;

  @override
  Future<int> insertNote(NoteModel note) async => 1;

  @override
  Future<List<NoteModel>> getNotes() async => const [];

  @override
  Future<int> updateNote(NoteModel note) async => 0;

  @override
  Future<int> deleteNote(int id) async => 0;

  @override
  Future<int> insertTemplate(TaskTemplateModel template) async => 1;

  @override
  Future<List<TaskTemplateModel>> getTemplates() async => const [];

  @override
  Future<int> updateTemplate(TaskTemplateModel template) async => 0;

  @override
  Future<int> deleteTemplate(int id) async => 0;

  @override
  Future<List<TaskModel>> getTasksByProject(int projectId) async => const [];

  @override
  Future<List<TaskModel>> getTasksByTag(int tagId) async => const [];

  @override
  Future<Map<int, ProjectProgress>> getProjectTaskCounts() async => const {};

  @override
  Future<Map<int, int>> getTagTaskCounts() async => const {};

  @override
  Future<void> close() async {}
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting('id_ID');
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    final dispatcher = TestWidgetsFlutterBinding.instance.platformDispatcher;
    dispatcher.localeTestValue = const Locale('id', 'ID');
    dispatcher.localesTestValue = const [Locale('id', 'ID')];
  });

  tearDown(() {
    final dispatcher = TestWidgetsFlutterBinding.instance.platformDispatcher;
    dispatcher.clearLocaleTestValue();
    dispatcher.clearLocalesTestValue();
  });

  test(
      'AppLockProvider mengelola aktivasi, grace period, suspendLockTemporarily, dan siklus kunci-buka',
      () async {
    var fakeNow = DateTime(2026, 11, 20, 8, 0, 0);
    final fakeLock = FakeAppLockService(supported: true, nextAuthResult: true);

    final provider = AppLockProvider(
      appLockService: fakeLock,
      nowProvider: () => fakeNow,
      gracePeriod: const Duration(seconds: 3),
    );
    await provider.initialize();
    expect(provider.isEnabled, isFalse);
    expect(provider.isLocked, isFalse);

    // Gagal verifikasi -> tidak aktif
    fakeLock.nextAuthResult = false;
    final enableFailed = await provider.setEnabled(true);
    expect(enableFailed, isFalse);
    expect(provider.isEnabled, isFalse);

    // Berhasil verifikasi -> aktif & tersimpan ke SharedPreferences
    fakeLock.nextAuthResult = true;
    final enableOk = await provider.setEnabled(true);
    expect(enableOk, isTrue);
    expect(provider.isEnabled, isTrue);
    expect(provider.isLocked, isFalse);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool(prefAppLockEnabledKey), isTrue);

    // Pause singkat (2 detik < grace period 3 detik) -> tidak terkunci
    provider.handleLifecycleStateChanged(AppLifecycleState.paused);
    fakeNow = fakeNow.add(const Duration(seconds: 2));
    provider.handleLifecycleStateChanged(AppLifecycleState.resumed);
    expect(provider.isLocked, isFalse);

    // suspendLockTemporarily -> tidak terkunci meski pause 5 detik
    provider.suspendLockTemporarily(duration: const Duration(seconds: 10));
    provider.handleLifecycleStateChanged(AppLifecycleState.paused);
    fakeNow = fakeNow.add(const Duration(seconds: 5));
    provider.handleLifecycleStateChanged(AppLifecycleState.resumed);
    expect(provider.isLocked, isFalse);

    // Lewat masa suspend + pause 5 detik >= grace period -> terkunci
    fakeNow = fakeNow.add(const Duration(seconds: 10));
    provider.handleLifecycleStateChanged(AppLifecycleState.paused);
    fakeNow = fakeNow.add(const Duration(seconds: 5));
    provider.handleLifecycleStateChanged(AppLifecycleState.resumed);
    expect(provider.isLocked, isTrue);

    // Buka kunci gagal lalu berhasil
    fakeLock.nextAuthResult = false;
    expect(await provider.unlock(), isFalse);
    expect(provider.isLocked, isTrue);
    expect(provider.errorMessage, isNotNull);

    fakeLock.nextAuthResult = true;
    expect(await provider.unlock(), isTrue);
    expect(provider.isLocked, isFalse);

    // Cold launch instance baru saat preferensi aktif -> langsung terkunci
    final coldLaunchProvider = AppLockProvider(
      appLockService: fakeLock,
      nowProvider: () => fakeNow,
    );
    await coldLaunchProvider.initialize();
    expect(coldLaunchProvider.isEnabled, isTrue);
    expect(coldLaunchProvider.isLocked, isTrue);

    // Nonaktifkan kunci aplikasi dengan verifikasi
    expect(await provider.setEnabled(false), isTrue);
    expect(provider.isEnabled, isFalse);
    expect(prefs.getBool(prefAppLockEnabledKey), isFalse);
  });

  testWidgets('AppLockGate menampilkan LockScreen saat terkunci dan membuka konten saat terverifikasi',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({prefAppLockEnabledKey: true});
    final fakeLock = FakeAppLockService(supported: true, nextAuthResult: false);
    final provider = AppLockProvider(appLockService: fakeLock);
    await provider.initialize();

    await tester.pumpWidget(
      ChangeNotifierProvider<AppLockProvider>.value(
        value: provider,
        child: const MaterialApp(
          locale: Locale('id'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: zettaskLocalizationsDelegates,
          home: AppLockGate(
            child: Scaffold(
              body: Center(child: Text('Konten Rahasia Zettask')),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(LockScreen), findsOneWidget);
    expect(find.text('Zettask Terkunci'), findsOneWidget);
    expect(find.text('Buka Kunci'), findsOneWidget);

    // Coba buka kunci namun gagal -> tetap terkunci & tampil pesan
    await tester.tap(find.byKey(const ValueKey('lock_screen_unlock_button')));
    await tester.pumpAndSettle();
    expect(find.byType(LockScreen), findsOneWidget);
    expect(find.textContaining('Autentikasi dibatalkan'), findsOneWidget);

    // Buka kunci berhasil -> LockScreen hilang
    fakeLock.nextAuthResult = true;
    await tester.tap(find.byKey(const ValueKey('lock_screen_unlock_button')));
    await tester.pumpAndSettle();
    expect(find.byType(LockScreen), findsNothing);
    expect(find.text('Konten Rahasia Zettask'), findsOneWidget);
  });

  testWidgets('Toggle Kunci Aplikasi di WorkspaceScreen memicu verifikasi dan menyimpan preferensi',
      (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      prefProIsActiveKey: true,
      prefProActivePlanKey: 'yearly',
    });
    final today = DateTime(2026, 11, 20);
    final fakeLock = FakeAppLockService(supported: true, nextAuthResult: true);
    final fakeWidget = FakeHomeWidgetSyncService();

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: _InMemoryDatabaseService(),
        notificationService: _NoopNotificationService(),
        calendarService: _NoopCalendarService(),
        appLockService: fakeLock,
        homeWidgetService: fakeWidget,
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    final workspaceScrollable = find.byType(Scrollable).last;
    await tester.scrollUntilVisible(
      find.text('Kunci Aplikasi'),
      250,
      scrollable: workspaceScrollable,
    );
    await tester.ensureVisible(find.text('Kunci Aplikasi'));
    await tester.pumpAndSettle();

    expect(find.text('Sidik jari, wajah, atau PIN perangkat'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('workspace_app_lock_switch')));
    await tester.pumpAndSettle();

    expect(fakeLock.authenticateCallCount, 1);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool(prefAppLockEnabledKey), isTrue);

    fakeWidget.dispose();
  });

  test(
      'HomeWidgetSyncService.updateTodayTasks dipanggil saat tugas hari ini dimuat, ditambah, dan dicentang',
      () async {
    final today = DateTime(2026, 11, 20);
    final fakeDb = _InMemoryDatabaseService([
      TaskModel(
        id: 1,
        title: 'Standup pagi',
        date: today,
        startTime: '09:00',
      ),
      TaskModel(
        id: 2,
        title: 'Sudah selesai',
        date: today,
        isCompleted: true,
      ),
    ]);
    final fakeWidget = FakeHomeWidgetSyncService();

    final taskProvider = TaskProvider(
      databaseService: fakeDb,
      notificationService: _NoopNotificationService(),
      homeWidgetService: fakeWidget,
      initialDate: today,
      nowProvider: () => today,
    );

    await taskProvider.initialize();
    expect(fakeWidget.updateCallCount, 1);

    var payload = AndroidHomeWidgetService.buildPayload(fakeWidget.lastTodayTasks);
    expect(payload.activeCount, 1);
    final decoded1 = jsonDecode(payload.tasksJson) as List<dynamic>;
    expect(decoded1.length, 1);
    expect((decoded1.first as Map)['title'], 'Standup pagi');
    expect((decoded1.first as Map)['time'], '09:00');

    // Tambah tugas baru hari ini -> widget ter-update (2 aktif)
    await taskProvider.addTask(
      TaskModel(title: 'Kirim laporan', date: today),
    );
    expect(fakeWidget.updateCallCount, 2);
    payload = AndroidHomeWidgetService.buildPayload(fakeWidget.lastTodayTasks);
    expect(payload.activeCount, 2);

    // Centang selesai 1 tugas -> widget ter-update (1 aktif tersisa)
    final standup = taskProvider.tasks.firstWhere((t) => t.title == 'Standup pagi');
    await taskProvider.toggleTaskComplete(standup);
    expect(fakeWidget.updateCallCount, 3);
    payload = AndroidHomeWidgetService.buildPayload(fakeWidget.lastTodayTasks);
    expect(payload.activeCount, 1);

    // Uji batas maksimal 5 item di payload widget meski ada 7 tugas aktif
    final sevenActive = List.generate(
      7,
      (i) => TaskModel(id: 100 + i, title: 'Tugas #$i', date: today),
    );
    final capped = AndroidHomeWidgetService.buildPayload(sevenActive);
    expect(capped.activeCount, 7);
    expect((jsonDecode(capped.tasksJson) as List).length, 5);

    fakeWidget.dispose();
  });

  testWidgets(
      'Klik tombol + pada Home Screen Widget (zettask://quick-add) langsung membuka QuickAddTaskSheet',
      (WidgetTester tester) async {
    final today = DateTime(2026, 11, 20);
    final fakeWidget = FakeHomeWidgetSyncService();

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: _InMemoryDatabaseService(),
        notificationService: _NoopNotificationService(),
        calendarService: _NoopCalendarService(),
        appLockService: FakeAppLockService(),
        homeWidgetService: fakeWidget,
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    fakeWidget.emitWidgetClick(Uri.parse('zettask://quick-add'));
    await tester.pumpAndSettle();

    expect(find.byType(QuickAddTaskSheet), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('quick_add_title_field')),
      'Tugas dari Widget',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('quick_add_save_button')));
    await tester.pumpAndSettle();

    expect(find.text('Tugas dari Widget'), findsOneWidget);
    fakeWidget.dispose();
  });
}
