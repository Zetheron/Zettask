import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zettask/main.dart';
import 'package:zettask/models/auth_user_model.dart';
import 'package:zettask/models/calendar_event_model.dart';
import 'package:zettask/models/note_model.dart';
import 'package:zettask/models/project_model.dart';
import 'package:zettask/models/repeating_task_model.dart';
import 'package:zettask/models/stats_model.dart';
import 'package:zettask/models/subscription_model.dart';
import 'package:zettask/models/tag_model.dart';
import 'package:zettask/models/task_model.dart';
import 'package:zettask/models/task_template_model.dart';
import 'package:zettask/providers/app_lock_provider.dart';
import 'package:zettask/providers/auth_provider.dart';
import 'package:zettask/providers/calendar_provider.dart';
import 'package:zettask/providers/subscription_provider.dart';
import 'package:zettask/screens/pro_paywall_screen.dart';
import 'package:zettask/screens/project_detail_screen.dart';
import 'package:zettask/services/app_lock_service.dart';
import 'package:zettask/services/auth_service.dart';
import 'package:zettask/services/calendar_service.dart';
import 'package:zettask/services/cloud_sync_service.dart';
import 'package:zettask/services/database_service.dart';
import 'package:zettask/services/export_service.dart';
import 'package:zettask/services/home_widget_service.dart';
import 'package:zettask/services/notification_service.dart';
import 'package:zettask/services/subscription_service.dart';
import 'package:zettask/widgets/account_sheet.dart';
import 'package:zettask/widgets/calendar_sync_sheet.dart';

class _GatingFakeDb implements DatabaseService {
  _GatingFakeDb({
    List<ProjectModel>? projects,
    List<TaskModel>? tasks,
  }) {
    if (projects != null) {
      for (final p in projects) {
        final id = p.id ?? _nextProjectId++;
        if (id >= _nextProjectId) _nextProjectId = id + 1;
        _projects[id] = p.copyWith(id: id);
      }
    }
    if (tasks != null) {
      for (final t in tasks) {
        final id = t.id ?? _nextTaskId++;
        if (id >= _nextTaskId) _nextTaskId = id + 1;
        _tasks[id] = t.copyWith(id: id);
      }
    }
  }

  final Map<int, ProjectModel> _projects = {};
  final Map<int, TaskModel> _tasks = {};
  int _nextProjectId = 1;
  int _nextTaskId = 1;

  @override
  Future<Database> get database => throw UnimplementedError();

  @override
  Future<int> insertTask(TaskModel task) async {
    final id = task.id ?? _nextTaskId++;
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
  ) async =>
      const [];

  @override
  Future<List<TaskModel>> getUnplannedTasks() async =>
      _tasks.values.where((t) => t.date == null).toList();

  @override
  Future<List<TaskModel>> getOverdueTasks(DateTime today) async => const [];

  @override
  Future<Set<String>> getDatesWithTasks(DateTime start, DateTime end) async =>
      const {};

  @override
  Future<List<TaskModel>> searchTasks(String query) async => const [];

  @override
  Future<int> updateTask(TaskModel task) async {
    if (task.id != null) _tasks[task.id!] = task;
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
  Future<int> insertProject(ProjectModel project) async {
    final id = project.id ?? _nextProjectId++;
    _projects[id] = project.copyWith(id: id);
    return id;
  }

  @override
  Future<List<ProjectModel>> getProjects() async => _projects.values.toList();

  @override
  Future<int> updateProject(ProjectModel project) async {
    if (project.id != null) _projects[project.id!] = project;
    return 1;
  }

  @override
  Future<int> deleteProject(int id) async {
    _projects.remove(id);
    for (final entry in _tasks.entries.toList()) {
      if (entry.value.projectId == id) {
        _tasks[entry.key] = entry.value.copyWith(clearProject: true);
      }
    }
    return 1;
  }

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
  Future<List<TaskModel>> getTasksByTag(int tagId) async => const [];

  @override
  Future<Map<int, ProjectProgress>> getProjectTaskCounts() async {
    final result = <int, ProjectProgress>{};
    for (final p in _projects.values) {
      if (p.id == null) continue;
      final list = _tasks.values.where((t) => t.projectId == p.id).toList();
      result[p.id!] = ProjectProgress(
        completedCount: list.where((t) => t.isCompleted).length,
        totalCount: list.length,
      );
    }
    return result;
  }

  @override
  Future<Map<int, int>> getTagTaskCounts() async => const {};

  @override
  Future<void> close() async {}
}

class _NoopNotif implements TaskNotificationService {
  @override
  Future<void> init() async {}

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<void> scheduleTaskReminder(TaskModel task) async {}

  @override
  Future<void> cancelTaskReminder(int taskId) async {}
}

class _FakeCalendar implements DeviceCalendarService {
  _FakeCalendar({this.granted = true});

  bool granted;

  @override
  Future<bool> hasPermissions() async => granted;

  @override
  Future<bool> requestPermissions() async {
    granted = true;
    return true;
  }

  @override
  Future<bool> isPermissionPermanentlyDenied() async => false;

  @override
  Future<bool> openSettings() async => true;

  @override
  Future<List<DeviceCalendarInfo>> getCalendars() async => const [
        DeviceCalendarInfo(
          id: 'cal_1',
          name: 'Kalender Utama',
          colorHex: '#2563EB',
          isPrimary: true,
        ),
      ];

  @override
  Future<List<CalendarEventModel>> getEventsForDate(
    DateTime date,
    Set<String> selectedCalendarIds,
  ) async {
    if (!selectedCalendarIds.contains('cal_1')) return const [];
    return [
      CalendarEventModel(
        id: 'ev_1',
        calendarId: 'cal_1',
        calendarName: 'Kalender Utama',
        title: 'Hari Libur Nasional',
        start: DateTime(date.year, date.month, date.day),
        end: DateTime(date.year, date.month, date.day + 1),
        isAllDay: true,
      ),
    ];
  }
}

class _FakeAppLock implements AppLockService {
  int authCalls = 0;

  @override
  Future<bool> isDeviceSupported() async => true;

  @override
  Future<bool> authenticate({required String reason}) async {
    authCalls++;
    return true;
  }
}

class _FakePrivacy implements ScreenPrivacyService {
  final List<bool> calls = [];

  @override
  Future<void> setSecureScreen(bool enabled) async {
    calls.add(enabled);
  }
}

class _FakeWidgetService implements HomeWidgetSyncService {
  final StreamController<Uri?> _clicks = StreamController<Uri?>.broadcast();

  @override
  Future<void> updateTodayTasks(
    List<TaskModel> todayTasks, {
    String? widgetTitle,
    String? widgetEmptyText,
  }) async {}

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

class _FakeExport implements DataExportService {
  int callCount = 0;

  @override
  Future<ExportResult> exportData({
    required ExportTarget target,
    required List<TaskModel> tasks,
    required List<NoteModel> notes,
    required List<ProjectModel> projects,
    required List<TagModel> tags,
    DateTime? timestamp,
  }) async {
    callCount++;
    return const ExportResult(
      success: true,
      fileCount: 1,
      message: 'Berhasil ekspor CSV.',
    );
  }
}

class _FakeAuth implements AuthService {
  _FakeAuth({AuthUser? initialUser}) : _current = initialUser;

  final StreamController<AuthUser?> _controller =
      StreamController<AuthUser?>.broadcast();
  AuthUser? _current;
  int signOutCalls = 0;
  int deleteCalls = 0;

  @override
  Stream<AuthUser?> get authStateChanges => _controller.stream;

  @override
  AuthUser? get currentUser => _current;

  @override
  Future<AuthUser> signInWithEmail(String email, String password) async {
    _current = AuthUser(uid: 'u1', email: email, providerId: 'password');
    _controller.add(_current);
    return _current!;
  }

  @override
  Future<AuthUser> signUpWithEmail(String email, String password) async {
    _current = AuthUser(uid: 'u1', email: email, providerId: 'password');
    _controller.add(_current);
    return _current!;
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    _current = const AuthUser(
      uid: 'u1',
      email: 'pro@zettask.app',
      providerId: 'google.com',
    );
    _controller.add(_current);
    return _current;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {}

  @override
  Future<void> signOut() async {
    signOutCalls++;
    _current = null;
    _controller.add(null);
  }

  @override
  Future<void> deleteAccount() async {
    deleteCalls++;
    _current = null;
    _controller.add(null);
  }

  void dispose() => _controller.close();
}

class _FakeCloudSync implements CloudSyncService {
  int syncCalls = 0;
  int deleteUserDataCalls = 0;

  @override
  Future<SyncSummary> syncAll(
    String uid,
    DatabaseService db, {
    DateTime? lastSyncedAt,
  }) async {
    syncCalls++;
    return SyncSummary(
      uploadedCount: 0,
      downloadedCount: 0,
      syncedAt: DateTime(2026, 11, 20, 12, 0),
    );
  }

  @override
  Future<void> deleteAllUserData(String uid) async {
    deleteUserDataCalls++;
  }
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

  testWidgets(
    'Pengguna Gratis dapat membuat 3 proyek dan diarahkan ke Paywall pada proyek ke-4',
    (WidgetTester tester) async {
      final today = DateTime(2026, 11, 20);
      final fakeDb = _GatingFakeDb();
      final fakeWidget = _FakeWidgetService();
      addTearDown(fakeWidget.dispose);

      await tester.pumpWidget(
        ZettaskApp(
          databaseService: fakeDb,
          notificationService: _NoopNotif(),
          calendarService: _FakeCalendar(),
          homeWidgetService: fakeWidget,
          initialDate: today,
          nowProvider: () => today,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Board'));
      await tester.pumpAndSettle();

      // Buat proyek 1, 2, dan 3 -> berhasil semua
      for (var i = 1; i <= 3; i++) {
        await tester.tap(find.byTooltip('Buat Proyek'));
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextFormField).first, 'Proyek $i');
        await tester.tap(find.widgetWithText(FilledButton, 'Buat Proyek'));
        await tester.pumpAndSettle();
        expect(find.text('Proyek $i'), findsWidgets);
      }

      // Indikator 3/3 tampil untuk pengguna Gratis
      expect(
        find.byKey(const ValueKey('board_project_limit_indicator')),
        findsOneWidget,
      );
      expect(find.text('3/3'), findsOneWidget);

      // Proyek ke-4 -> diarahkan ke ProPaywallScreen dengan banner kontekstual
      await tester.tap(find.byTooltip('Buat Proyek'));
      await tester.pumpAndSettle();

      expect(find.byType(ProPaywallScreen), findsOneWidget);
      expect(
        find.byKey(const ValueKey('paywall_context_banner')),
        findsOneWidget,
      );
      expect(
        find.textContaining('3 proyek'),
        findsOneWidget,
      );
    },
  );

  testWidgets(
    'Downgrade (No Data Loss): pengguna dengan 5 proyek tetap bisa membuka & menghapus proyek lama, hanya diblokir membuat proyek ke-6',
    (WidgetTester tester) async {
      final today = DateTime(2026, 11, 20);
      final fakeDb = _GatingFakeDb(
        projects: List.generate(
          5,
          (i) => ProjectModel(id: i + 1, name: 'Proyek Lama ${i + 1}'),
        ),
        tasks: [
          TaskModel(
            id: 1,
            title: 'Tugas penting di Proyek 1',
            date: today,
            projectId: 1,
          ),
        ],
      );
      final fakeWidget = _FakeWidgetService();
      addTearDown(fakeWidget.dispose);

      // Pengguna kini Gratis (Pro berakhir) tetapi sudah punya 5 proyek di SQLite
      await tester.pumpWidget(
        ZettaskApp(
          databaseService: fakeDb,
          notificationService: _NoopNotif(),
          calendarService: _FakeCalendar(),
          homeWidgetService: fakeWidget,
          initialDate: today,
          nowProvider: () => today,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Board'));
      await tester.pumpAndSettle();

      // 1. Tetap bisa membuka proyek lama & membaca tugas di dalamnya
      expect(find.text('Proyek Lama 1'), findsWidgets);
      await tester.tap(find.text('Proyek Lama 1').last);
      await tester.pumpAndSettle();
      expect(find.byType(ProjectDetailScreen), findsOneWidget);
      expect(find.text('Tugas penting di Proyek 1'), findsOneWidget);

      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // 2. Mencoba membuat proyek ke-6 -> diarahkan ke Paywall
      await tester.tap(find.byTooltip('Buat Proyek'));
      await tester.pumpAndSettle();
      expect(find.byType(ProPaywallScreen), findsOneWidget);
      await tester.tap(find.byTooltip('Tutup'));
      await tester.pumpAndSettle();

      // 3. Tetap bisa menghapus proyek lama tanpa terhalang paywall (tersisa 4 proyek)
      await tester.tap(find.byTooltip('Opsi proyek').first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hapus proyek'));
      await tester.pumpAndSettle();

      final remainingProjects = await fakeDb.getProjects();
      expect(remainingProjects.length, 4);
      // Tugas lokal tetap aman di SQLite (tidak pernah dihapus saat downgrade)
      final remainingTasks = await fakeDb.getAllTasks();
      expect(remainingTasks.length, 1);
    },
  );

  testWidgets(
    'Downgrade (No Lockout): App Lock, FLAG_SECURE, dan Calendar Sync otomatis nonaktif aman saat Pro berakhir',
    (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({
        prefProIsActiveKey: true,
        prefProActivePlanKey: 'yearly',
        prefAppLockEnabledKey: true,
        CalendarProvider.prefSyncEnabled: true,
      });

      final today = DateTime(2026, 11, 20);
      final fakeLock = _FakeAppLock();
      final fakePrivacy = _FakePrivacy();
      final fakeCal = _FakeCalendar(granted: true);
      final fakeWidget = _FakeWidgetService();
      addTearDown(fakeWidget.dispose);

      await tester.pumpWidget(
        ZettaskApp(
          databaseService: _GatingFakeDb(),
          notificationService: _NoopNotif(),
          calendarService: fakeCal,
          appLockService: fakeLock,
          privacyService: fakePrivacy,
          homeWidgetService: fakeWidget,
          initialDate: today,
          nowProvider: () => today,
        ),
      );
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(Scaffold).first);
      final appLockProvider = context.read<AppLockProvider>();
      final calendarProvider = context.read<CalendarProvider>();
      final subscriptionProvider = context.read<SubscriptionProvider>();

      // Saat Pro aktif: App Lock & Calendar Sync aktif
      expect(subscriptionProvider.isPro, isTrue);
      expect(appLockProvider.isEnabled, isTrue);
      expect(appLockProvider.isLocked, isTrue);
      expect(calendarProvider.isSyncEnabled, isTrue);
      expect(calendarProvider.allDayEvents, isNotEmpty);

      // Status Pro berakhir -> otomatis nonaktifkan App Lock (NO LOCKOUT), FLAG_SECURE false, & matikan Calendar Sync
      await subscriptionProvider.debugSetProStatus(false);
      await tester.pumpAndSettle();

      expect(appLockProvider.isEnabled, isFalse);
      expect(appLockProvider.isLocked, isFalse);
      expect(appLockProvider.isPrivacyShieldVisible, isFalse);
      expect(fakePrivacy.calls.last, isFalse);
      expect(calendarProvider.isSyncEnabled, isFalse);
      expect(calendarProvider.allDayEvents, isEmpty);
      expect(calendarProvider.events, isEmpty);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(prefAppLockEnabledKey), isFalse);
      expect(prefs.getBool(CalendarProvider.prefSyncEnabled), isFalse);
    },
  );

  testWidgets(
    'Pengguna Gratis mengetuk Calendar Sync, App Lock, CSV Export, dan Cloud Sync diarahkan ke Paywall; saat Pro semua berjalan normal',
    (WidgetTester tester) async {
      final today = DateTime(2026, 11, 20);
      final fakeLock = _FakeAppLock();
      final fakeExport = _FakeExport();
      final fakeCal = _FakeCalendar(granted: true);
      final fakeAuth = _FakeAuth();
      final fakeWidget = _FakeWidgetService();
      addTearDown(fakeAuth.dispose);
      addTearDown(fakeWidget.dispose);

      await tester.pumpWidget(
        ZettaskApp(
          databaseService: _GatingFakeDb(),
          notificationService: _NoopNotif(),
          calendarService: fakeCal,
          appLockService: fakeLock,
          exportService: fakeExport,
          authService: fakeAuth,
          cloudSyncService: _FakeCloudSync(),
          homeWidgetService: fakeWidget,
          initialDate: today,
          nowProvider: () => today,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('More'));
      await tester.pumpAndSettle();

      final listScroll = find.byType(Scrollable).last;

      // 1. Cloud Sync (belum login) -> buka Paywall
      await tester.tap(find.byKey(const ValueKey('workspace_account_card')));
      await tester.pumpAndSettle();
      expect(find.byType(ProPaywallScreen), findsOneWidget);
      await tester.tap(find.byTooltip('Tutup'));
      await tester.pumpAndSettle();

      // 2. Calendar Sync -> buka Paywall
      final calendarTile = find.byKey(
        const ValueKey('workspace_calendar_sync_tile'),
      );
      await tester.scrollUntilVisible(
        calendarTile,
        200,
        scrollable: listScroll,
      );
      await tester.ensureVisible(calendarTile);
      await tester.pumpAndSettle();
      await tester.tap(calendarTile);
      await tester.pumpAndSettle();
      expect(find.byType(ProPaywallScreen), findsOneWidget);
      await tester.tap(find.byTooltip('Tutup'));
      await tester.pumpAndSettle();

      // 3. CSV Export -> buka Paywall
      final csvTile = find.byKey(const ValueKey('workspace_export_csv_tile'));
      await tester.scrollUntilVisible(
        csvTile,
        200,
        scrollable: listScroll,
      );
      await tester.ensureVisible(csvTile);
      await tester.pumpAndSettle();
      await tester.tap(csvTile);
      await tester.pumpAndSettle();
      expect(find.byType(ProPaywallScreen), findsOneWidget);
      expect(fakeExport.callCount, 0);
      await tester.tap(find.byTooltip('Tutup'));
      await tester.pumpAndSettle();

      // 4. App Lock -> buka Paywall (tidak memanggil autentikasi biometrik)
      final appLockTile = find.byKey(
        const ValueKey('workspace_app_lock_switch'),
      );
      await tester.scrollUntilVisible(
        appLockTile,
        200,
        scrollable: listScroll,
      );
      await tester.ensureVisible(appLockTile);
      await tester.pumpAndSettle();
      await tester.tap(appLockTile);
      await tester.pumpAndSettle();
      expect(find.byType(ProPaywallScreen), findsOneWidget);
      expect(fakeLock.authCalls, 0);
      await tester.tap(find.byTooltip('Tutup'));
      await tester.pumpAndSettle();

      // Aktifkan Pro -> seluruh fitur berjalan normal tanpa halangan paywall
      final context = tester.element(find.byType(Scaffold).first);
      await context.read<SubscriptionProvider>().debugSetProStatus(
            true,
            plan: ProPlanType.yearly,
          );
      await tester.pumpAndSettle();

      // App Lock kini berhasil mengaktifkan verifikasi
      await tester.ensureVisible(appLockTile);
      await tester.pumpAndSettle();
      await tester.tap(appLockTile);
      await tester.pumpAndSettle();
      expect(find.byType(ProPaywallScreen), findsNothing);
      expect(fakeLock.authCalls, 1);

      // Calendar Sync kini membuka CalendarSyncSheet
      await tester.scrollUntilVisible(
        calendarTile,
        -200,
        scrollable: listScroll,
      );
      await tester.ensureVisible(calendarTile);
      await tester.pumpAndSettle();
      await tester.tap(calendarTile);
      await tester.pumpAndSettle();
      expect(find.byType(CalendarSyncSheet), findsOneWidget);
      await tester.tap(find.byTooltip('Tutup'));
      await tester.pumpAndSettle();

      // CSV Export kini membuka sheet ekspor CSV
      await tester.scrollUntilVisible(
        csvTile,
        200,
        scrollable: listScroll,
      );
      await tester.ensureVisible(csvTile);
      await tester.pumpAndSettle();
      await tester.tap(csvTile);
      await tester.pumpAndSettle();
      expect(find.text('Ekspor Data CSV'), findsOneWidget);
    },
  );

  testWidgets(
    'Kepatuhan Google Play: Pengguna yang sudah login tetap dapat mengakses Keluar & Hapus Akun saat status Pro false sementara sync cloud dijeda',
    (WidgetTester tester) async {
      final today = DateTime(2026, 11, 20);
      final fakeAuth = _FakeAuth(
        initialUser: const AuthUser(
          uid: 'uid_prev_pro',
          email: 'mantan.pro@zettask.app',
          displayName: 'Budi',
          providerId: 'password',
        ),
      );
      final fakeSync = _FakeCloudSync();
      final fakeWidget = _FakeWidgetService();
      addTearDown(fakeAuth.dispose);
      addTearDown(fakeWidget.dispose);

      // Status Pro = false (Gratis / Kedaluwarsa), tetapi user sudah login
      await tester.pumpWidget(
        ZettaskApp(
          databaseService: _GatingFakeDb(),
          notificationService: _NoopNotif(),
          calendarService: _FakeCalendar(),
          authService: fakeAuth,
          cloudSyncService: fakeSync,
          homeWidgetService: fakeWidget,
          initialDate: today,
          nowProvider: () => today,
        ),
      );
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(Scaffold).first);
      final authProvider = context.read<AuthProvider>();
      expect(authProvider.isCloudSyncPaused, isTrue);
      // syncNow tidak berjalan saat dijeda
      expect(await authProvider.syncNow(), isFalse);
      expect(fakeSync.syncCalls, 0);

      await tester.tap(find.text('More'));
      await tester.pumpAndSettle();

      // Kartu akun menampilkan status sinkronisasi dijeda dan tetap membuka AccountSheet (bukan Paywall)
      expect(find.text('Sinkronisasi dijeda · Data lokal aman'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('workspace_account_card')));
      await tester.pumpAndSettle();

      expect(find.byType(AccountSheet), findsOneWidget);
      expect(find.byType(ProPaywallScreen), findsNothing);
      expect(find.text('Sinkronisasi Cloud dijeda'), findsOneWidget);
      expect(find.text('Keluar'), findsOneWidget);
      expect(find.text('Hapus Akun'), findsOneWidget);

      // Verifikasi Hapus Akun tetap berfungsi penuh tanpa terhalang paywall
      await tester.tap(find.text('Hapus Akun'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Lanjutkan'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Ya, Hapus Permanen'));
      await tester.pumpAndSettle();

      expect(fakeSync.deleteUserDataCalls, 1);
      expect(fakeAuth.deleteCalls, 1);
      expect(authProvider.isSignedIn, isFalse);
    },
  );
}
