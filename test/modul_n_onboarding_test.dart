import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zettask/core/theme/app_theme.dart';
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
import 'package:zettask/screens/main_shell.dart';
import 'package:zettask/screens/onboarding_screen.dart';
import 'package:zettask/services/calendar_service.dart';
import 'package:zettask/services/database_service.dart';
import 'package:zettask/services/home_widget_service.dart';
import 'package:zettask/services/notification_service.dart';
import 'package:zettask/services/onboarding_service.dart';
import 'package:zettask/widgets/onboarding_illustrations.dart';

class _StubDb implements DatabaseService {
  @override
  Future<Database> get database => throw UnimplementedError();

  @override
  Future<int> insertTask(TaskModel task) async => 1;

  @override
  Future<List<TaskModel>> getTasksByDate(DateTime date) async => const [];

  @override
  Future<List<TaskModel>> getTasksInDateRange(
    DateTime start,
    DateTime end,
  ) async =>
      const [];

  @override
  Future<List<TaskModel>> getUnplannedTasks() async => const [];

  @override
  Future<List<TaskModel>> getOverdueTasks(DateTime today) async => const [];

  @override
  Future<Set<String>> getDatesWithTasks(DateTime start, DateTime end) async =>
      const {};

  @override
  Future<List<TaskModel>> searchTasks(String query) async => const [];

  @override
  Future<int> updateTask(TaskModel task) async => 1;

  @override
  Future<int> toggleTaskComplete(
    int id,
    bool isCompleted, {
    DateTime? completedAt,
  }) async =>
      1;

  @override
  Future<List<TaskModel>> getAllTasks() async => const [];

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
  Future<int> deleteTask(int id) async => 1;

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

class _StubNotif implements TaskNotificationService {
  @override
  Future<void> init() async {}

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<void> scheduleTaskReminder(TaskModel task) async {}

  @override
  Future<void> cancelTaskReminder(int taskId) async {}
}

class _StubCalendar implements DeviceCalendarService {
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

class _StubWidget implements HomeWidgetSyncService {
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
    'OnboardingService mengelola status has_seen_onboarding (default false, complete, reset)',
    () async {
      const service = OnboardingService.instance;
      expect(await service.hasSeenOnboarding(), isFalse);

      await service.markOnboardingCompleted();
      expect(await service.hasSeenOnboarding(), isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(prefHasSeenOnboardingKey), isTrue);

      await service.resetOnboarding();
      expect(await service.hasSeenOnboarding(), isFalse);
      expect(prefs.getBool(prefHasSeenOnboardingKey), isFalse);
    },
  );

  testWidgets(
    'Pengguna baru (has_seen_onboarding == false) melihat OnboardingScreen, lanjut hingga slide 3, dan Mulai Sekarang menyimpan status & masuk MainShell',
    (WidgetTester tester) async {
      final today = DateTime(2026, 11, 21);
      final stubWidget = _StubWidget();
      addTearDown(stubWidget.dispose);

      final initialSeen = await OnboardingService.instance.hasSeenOnboarding();
      expect(initialSeen, isFalse);

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: ZettaskApp(
            databaseService: _StubDb(),
            notificationService: _StubNotif(),
            calendarService: _StubCalendar(),
            homeWidgetService: stubWidget,
            initialHasSeenOnboarding: initialSeen,
            initialLocale: const Locale('id'),
            initialDate: today,
            nowProvider: () => today,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Slide 1 tampil
      expect(find.byType(OnboardingScreen), findsOneWidget);
      expect(find.byType(MainShell), findsNothing);
      expect(find.text('Catat tugas tanpa distraksi'), findsOneWidget);
      expect(find.text('Lewati'), findsOneWidget);
      expect(find.text('Lanjut'), findsOneWidget);

      // Lanjut -> Slide 2
      await tester.tap(find.byKey(const ValueKey('onboarding_primary_button')));
      await tester.pumpAndSettle();
      expect(find.text('Timeline rapi & terencana'), findsOneWidget);
      expect(find.text('Lanjut'), findsOneWidget);

      // Lanjut -> Slide 3
      await tester.tap(find.byKey(const ValueKey('onboarding_primary_button')));
      await tester.pumpAndSettle();
      expect(find.text('Cepat, offline, dan privat'), findsOneWidget);
      expect(find.text('Mulai Sekarang'), findsOneWidget);

      // Ketuk Mulai Sekarang -> simpan has_seen_onboarding == true & masuk MainShell
      await tester.tap(find.byKey(const ValueKey('onboarding_primary_button')));
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingScreen), findsNothing);
      expect(find.byType(MainShell), findsOneWidget);
      expect(await OnboardingService.instance.hasSeenOnboarding(), isTrue);
    },
  );

  testWidgets(
    'Menekan Lewati pada slide 1 langsung menyelesaikan onboarding dan menyimpan preferensi',
    (WidgetTester tester) async {
      final today = DateTime(2026, 11, 21);
      final stubWidget = _StubWidget();
      addTearDown(stubWidget.dispose);

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: ZettaskApp(
            databaseService: _StubDb(),
            notificationService: _StubNotif(),
            calendarService: _StubCalendar(),
            homeWidgetService: stubWidget,
            initialHasSeenOnboarding: false,
            initialLocale: const Locale('id'),
            initialDate: today,
            nowProvider: () => today,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingScreen), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('onboarding_skip_button')));
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingScreen), findsNothing);
      expect(find.byType(MainShell), findsOneWidget);
      expect(await OnboardingService.instance.hasSeenOnboarding(), isTrue);
    },
  );

  testWidgets(
    'Menu Panduan Aplikasi di Workspace membuka OnboardingScreen(isReplay: true) dan menutupnya kembali tanpa mereset navigasi utama',
    (WidgetTester tester) async {
      final today = DateTime(2026, 11, 21);
      final stubWidget = _StubWidget();
      addTearDown(stubWidget.dispose);

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: ZettaskApp(
            databaseService: _StubDb(),
            notificationService: _StubNotif(),
            calendarService: _StubCalendar(),
            homeWidgetService: stubWidget,
            initialHasSeenOnboarding: true,
            initialLocale: const Locale('id'),
            initialDate: today,
            nowProvider: () => today,
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('More'));
      await tester.pumpAndSettle();

      final guideTile = find.byKey(const ValueKey('workspace_app_guide_tile'));
      await tester.scrollUntilVisible(
        guideTile,
        250,
        scrollable: find.byType(Scrollable).last,
      );
      await tester.ensureVisible(guideTile);
      await tester.pumpAndSettle();

      expect(find.text('Panduan Aplikasi'), findsOneWidget);
      await tester.tap(guideTile);
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingScreen), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('onboarding_skip_button')));
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingScreen), findsNothing);
      expect(find.text('Panduan Aplikasi'), findsOneWidget);
    },
  );

  final themeCases = <(String, ThemeData)>[
    ('Light', AppTheme.lightTheme),
    ('Dark', AppTheme.darkTheme),
    (
      'AMOLED Pure Black + Indigo',
      AppTheme.darkThemeFor(
        AppThemePreset.defaultIndigo,
        amoled: true,
        accentColor: ProAccentColor.indigo,
      ),
    ),
  ];

  for (final (label, theme) in themeCases) {
    testWidgets(
      'Ketiga ilustrasi animasi ter-render aman pada tema $label, patuh disableAnimations, dan dispose bersih',
      (WidgetTester tester) async {
        // 1. Mode animasi aktif (pump beberapa frame)
        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            locale: const Locale('id'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: zettaskLocalizationsDelegates,
            home: const Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    QuickTaskIllustration(),
                    TimelineProjectIllustration(),
                    OfflinePrivacyIllustration(),
                  ],
                ),
              ),
            ),
          ),
        );

        await tester.pump(const Duration(milliseconds: 350));
        await tester.pump(const Duration(milliseconds: 700));

        expect(find.byType(QuickTaskIllustration), findsOneWidget);
        expect(find.byType(TimelineProjectIllustration), findsOneWidget);
        expect(find.byType(OfflinePrivacyIllustration), findsOneWidget);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();

        // 2. Mode disableAnimations: true -> pumpAndSettle selesai tanpa timeout
        await tester.pumpWidget(
          MediaQuery(
            data: const MediaQueryData(disableAnimations: true),
            child: MaterialApp(
              theme: theme,
              locale: const Locale('id'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: zettaskLocalizationsDelegates,
              home: const Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      QuickTaskIllustration(),
                      TimelineProjectIllustration(),
                      OfflinePrivacyIllustration(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(QuickTaskIllustration), findsOneWidget);
        expect(find.byType(TimelineProjectIllustration), findsOneWidget);
        expect(find.byType(OfflinePrivacyIllustration), findsOneWidget);

        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();
      },
    );
  }
}
