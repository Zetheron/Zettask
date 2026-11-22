import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zettask/core/theme/app_theme.dart';
import 'package:zettask/l10n/app_localizations.dart';
import 'package:zettask/l10n/l10n_helpers.dart';
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
import 'package:zettask/providers/locale_provider.dart';
import 'package:zettask/providers/subscription_provider.dart';
import 'package:zettask/providers/task_provider.dart';
import 'package:zettask/providers/theme_provider.dart';
import 'package:zettask/providers/workspace_provider.dart';
import 'package:zettask/screens/home_screen.dart';
import 'package:zettask/screens/onboarding_screen.dart';
import 'package:zettask/screens/pro_paywall_screen.dart';
import 'package:zettask/screens/theme_settings_screen.dart';
import 'package:zettask/screens/workspace_screen.dart';
import 'package:zettask/services/calendar_service.dart';
import 'package:zettask/services/database_service.dart';
import 'package:zettask/services/notification_service.dart';
import 'package:zettask/services/subscription_service.dart';
import 'package:zettask/widgets/pro_badge.dart';
import 'package:zettask/widgets/timeline_task_item.dart';
import 'package:zettask/widgets/zettask_motion.dart';

class _MinimalDb implements DatabaseService {
  _MinimalDb({List<TaskModel>? overdueTasks})
      : _overdueTasks = overdueTasks ?? const [];

  final List<TaskModel> _overdueTasks;

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
  Future<List<TaskModel>> getOverdueTasks(DateTime today) async =>
      _overdueTasks;

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
  Future<List<TaskModel>> getAllTasks() async => _overdueTasks;

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

class _NoopCalendar implements DeviceCalendarService {
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

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting('id_ID');
  });

  setUp(() {
    SubscriptionProvider.resetEnableProPaywallOverride();
    SharedPreferences.setMockInitialValues({});
    final dispatcher = TestWidgetsFlutterBinding.instance.platformDispatcher;
    dispatcher.localeTestValue = const Locale('id', 'ID');
    dispatcher.localesTestValue = const [Locale('id', 'ID')];
  });

  tearDown(() {
    SubscriptionProvider.resetEnableProPaywallOverride();
    final dispatcher = TestWidgetsFlutterBinding.instance.platformDispatcher;
    dispatcher.clearLocaleTestValue();
    dispatcher.clearLocalesTestValue();
  });

  group('Material 3 Expressive Theme Tokens', () {
    test('Light & Dark themes menggunakan permukaan tonal, sudut ekspresif, dan bentuk pill', () {
      final light = AppTheme.lightThemeFor(
        AppThemePreset.defaultIndigo,
        accentColor: ProAccentColor.indigo,
      );
      final dark = AppTheme.darkThemeFor(
        AppThemePreset.defaultIndigo,
        accentColor: ProAccentColor.indigo,
      );

      for (final theme in [light, dark]) {
        expect(theme.useMaterial3, isTrue);

        // Tonal surface layering
        expect(theme.cardTheme.color, theme.colorScheme.surfaceContainerLow);
        expect(theme.cardTheme.elevation, 0);
        expect(
          theme.colorScheme.surfaceContainerLow,
          isNot(equals(theme.scaffoldBackgroundColor)),
        );
        expect(
          theme.colorScheme.surfaceContainerHigh,
          isNot(equals(theme.colorScheme.surfaceContainerLow)),
        );

        // Expressive card shape (20dp, tanpa border kaku pada non-AMOLED)
        final cardShape = theme.cardTheme.shape as RoundedRectangleBorder;
        expect(cardShape.borderRadius, BorderRadius.circular(20));
        expect(cardShape.side, BorderSide.none);

        // Expressive squircle FAB (20dp) dengan warna kontras primaryContainer
        final fabShape =
            theme.floatingActionButtonTheme.shape as RoundedRectangleBorder;
        expect(fabShape.borderRadius, BorderRadius.circular(20));
        expect(
          theme.floatingActionButtonTheme.backgroundColor,
          theme.colorScheme.primaryContainer,
        );
        expect(
          theme.floatingActionButtonTheme.foregroundColor,
          theme.colorScheme.onPrimaryContainer,
        );

        // Pill shapes untuk chip, tombol utama, dan indikator navigasi
        expect(theme.chipTheme.shape, isA<StadiumBorder>());
        expect(
          theme.filledButtonTheme.style?.shape?.resolve({}),
          isA<StadiumBorder>(),
        );
        expect(theme.navigationBarTheme.indicatorShape, isA<StadiumBorder>());
        expect(
          theme.navigationBarTheme.indicatorColor,
          theme.colorScheme.primaryContainer,
        );

        // Sheet & Dialog sudut 28dp
        final sheetShape =
            theme.bottomSheetTheme.shape as RoundedRectangleBorder;
        expect(
          sheetShape.borderRadius,
          const BorderRadius.vertical(top: Radius.circular(28)),
        );
        final dialogShape = theme.dialogTheme.shape as RoundedRectangleBorder;
        expect(dialogShape.borderRadius, BorderRadius.circular(28));

        // Input field tonal 18dp
        final inputBorder =
            theme.inputDecorationTheme.enabledBorder as OutlineInputBorder;
        expect(inputBorder.borderRadius, BorderRadius.circular(18));
        expect(theme.inputDecorationTheme.filled, isTrue);
        expect(
          theme.inputDecorationTheme.fillColor,
          theme.colorScheme.surfaceContainerHigh,
        );

        // Expressive bold typography
        expect(theme.textTheme.displaySmall?.fontWeight, FontWeight.w800);
        expect(theme.textTheme.headlineMedium?.fontWeight, FontWeight.w800);
        expect(theme.textTheme.headlineSmall?.fontWeight, FontWeight.w800);
        expect(theme.textTheme.titleLarge?.fontWeight, FontWeight.w700);
      }
    });

    test('AMOLED Pure Black wajib mempertahankan kanvas #000000, kartu #0A0A0A–#121212, dan border #1E1E1E', () {
      final manualAmoled = AppTheme.darkThemeFor(
        AppThemePreset.defaultIndigo,
        amoled: true,
        accentColor: ProAccentColor.sage,
      );
      final dynamicAmoled = AppTheme.darkThemeFor(
        AppThemePreset.defaultIndigo,
        amoled: true,
        dynamicColorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0077B6),
          brightness: Brightness.dark,
        ),
      );

      for (final amoled in [manualAmoled, dynamicAmoled]) {
        expect(AppTheme.isAmoled(amoled), isTrue);
        expect(amoled.scaffoldBackgroundColor, const Color(0xFF000000));
        expect(amoled.colorScheme.surface, const Color(0xFF0A0A0A));
        expect(amoled.colorScheme.surfaceContainerLow, const Color(0xFF0A0A0A));
        expect(
          amoled.colorScheme.surfaceContainerHigh,
          const Color(0xFF121212),
        );
        expect(amoled.colorScheme.outline, const Color(0xFF1E1E1E));

        final cardShape = amoled.cardTheme.shape as RoundedRectangleBorder;
        expect(cardShape.borderRadius, BorderRadius.circular(20));
        expect(cardShape.side.color, const Color(0xFF1E1E1E));
        expect(cardShape.side.width, 1);

        expect(
          amoled.navigationBarTheme.backgroundColor,
          const Color(0xFF000000),
        );
      }
    });
  });

  group('Expressive Spring Motion & Tactile Controls', () {
    test('ZettaskSpringCurve mulai di 0.0, berakhir tepat di 1.0, dan memiliki overshoot halus', () {
      const curve = ZettaskSpringCurve.expressive;
      expect(curve.transform(0.0), 0.0);
      expect(curve.transform(1.0), 1.0);

      var peak = 0.0;
      for (var i = 1; i < 100; i++) {
        final v = curve.transform(i / 100.0);
        if (v > peak) peak = v;
      }
      expect(peak, greaterThan(1.0));
      expect(peak, lessThan(1.25));
    });

    testWidgets(
      'ZettaskSpringCheckBounce dan ZettaskSpringTap settle bersih serta patuh pada disableAnimations dan textScaler besar',
      (WidgetTester tester) async {
        var completed = false;

        Widget buildHarness({
          required bool isCompleted,
          bool disableAnimations = false,
          double textScale = 1.0,
        }) {
          return MediaQuery(
            data: MediaQueryData(
              disableAnimations: disableAnimations,
              textScaler: TextScaler.linear(textScale),
            ),
            child: MaterialApp(
              locale: const Locale('id'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: zettaskLocalizationsDelegates,
              theme: AppTheme.lightTheme,
              home: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TimelineTaskItem(
                        task: TaskModel(
                          id: 99,
                          title: 'Rapat desain Material 3 Expressive',
                          description: 'Cek kontras tonal & spring physics',
                          startTime: '09:30',
                          isCompleted: isCompleted,
                          priority: TaskPriority.high,
                          colorHex: '#2563EB',
                        ),
                        isFirstInSection: true,
                        isLastInSection: true,
                        onTap: () {},
                        onToggleComplete: () => completed = !completed,
                        onDelete: () {},
                        onToggleChecklistItem: (_) {},
                      ),
                      const SizedBox(height: 12),
                      ZettaskSpringTap(
                        child: FilledButton(
                          onPressed: () {},
                          child: const Text('Aksi Ekspresif'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        await tester.pumpWidget(buildHarness(isCompleted: false));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const ValueKey('task_status_circle')));
        await tester.pumpWidget(buildHarness(isCompleted: completed));
        await tester.pumpAndSettle();
        expect(completed, isTrue);

        // Uji pada disableAnimations: true dan textScaler 1.6x tanpa overflow
        await tester.pumpWidget(
          buildHarness(
            isCompleted: true,
            disableAnimations: true,
            textScale: 1.6,
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      },
    );
  });

  group('Home Overdue Card & Onboarding Pill Buttons', () {
    Material summaryCardMaterial(WidgetTester tester, String keyName) {
      return tester.widget<Material>(
        find.descendant(
          of: find.byKey(ValueKey(keyName)),
          matching: find.byType(Material),
        ).first,
      );
    }

    testWidgets(
      'Kartu Overdue saat count 0 seragam dengan To Do & Unplanned di Light, Dark, dan AMOLED; saat > 0 memakai errorContainer',
      (WidgetTester tester) async {
        final today = DateTime(2026, 11, 22);

        Future<void> pumpHome({
          required ThemeData theme,
          List<TaskModel> overdueTasks = const [],
        }) async {
          final db = _MinimalDb(overdueTasks: overdueTasks);
          final taskProvider = TaskProvider(
            databaseService: db,
            notificationService: _NoopNotif(),
            initialDate: today,
            nowProvider: () => today,
          );
          final calendarProvider = CalendarProvider(
            calendarService: _NoopCalendar(),
            initialDate: today,
          );
          final workspaceProvider = WorkspaceProvider(
            databaseService: db,
            nowProvider: () => today,
          );
          await taskProvider.initialize();

          await tester.pumpWidget(
            MultiProvider(
              providers: [
                ChangeNotifierProvider<TaskProvider>.value(value: taskProvider),
                ChangeNotifierProvider<CalendarProvider>.value(
                  value: calendarProvider,
                ),
                ChangeNotifierProvider<WorkspaceProvider>.value(
                  value: workspaceProvider,
                ),
              ],
              child: MaterialApp(
                locale: const Locale('id'),
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: zettaskLocalizationsDelegates,
                theme: theme,
                home: const HomeScreen(autoLoad: false),
              ),
            ),
          );
          await tester.pumpAndSettle();
        }

        // 1. Light mode, overdue == 0 -> warna tonal ketiga kartu sama persis
        final lightTheme = AppTheme.lightTheme;
        await pumpHome(theme: lightTheme);
        final todoLight = summaryCardMaterial(tester, 'home_summary_todo');
        final overdueLight =
            summaryCardMaterial(tester, 'home_summary_overdue');
        final unplannedLight =
            summaryCardMaterial(tester, 'home_summary_unplanned');
        expect(overdueLight.color, equals(todoLight.color));
        expect(overdueLight.color, equals(unplannedLight.color));
        expect(overdueLight.color, equals(lightTheme.colorScheme.surfaceContainer));

        // 2. AMOLED Pure Black, overdue == 0 -> permukaan #0A0A0A seragam + border #1E1E1E
        final amoledTheme = AppTheme.darkThemeFor(
          AppThemePreset.defaultIndigo,
          amoled: true,
        );
        await pumpHome(theme: amoledTheme);
        final todoAmoled = summaryCardMaterial(tester, 'home_summary_todo');
        final overdueAmoled =
            summaryCardMaterial(tester, 'home_summary_overdue');
        final unplannedAmoled =
            summaryCardMaterial(tester, 'home_summary_unplanned');
        expect(overdueAmoled.color, equals(todoAmoled.color));
        expect(overdueAmoled.color, equals(unplannedAmoled.color));
        expect(overdueAmoled.color, equals(AppTheme.amoledSurface));
        final overdueAmoledShape =
            overdueAmoled.shape as RoundedRectangleBorder;
        expect(overdueAmoledShape.side.color, equals(AppTheme.amoledBorder));
        expect(overdueAmoledShape.side.width, 1);

        // 3. Light mode, overdue > 0 -> beralih ke penekanan tonal errorContainer
        await pumpHome(
          theme: lightTheme,
          overdueTasks: [
            TaskModel(
              id: 77,
              title: 'Tugas tertunda',
              date: today.subtract(const Duration(days: 2)),
            ),
          ],
        );
        final todoWithOverdue =
            summaryCardMaterial(tester, 'home_summary_todo');
        final overdueActive =
            summaryCardMaterial(tester, 'home_summary_overdue');
        expect(
          overdueActive.color,
          equals(lightTheme.colorScheme.errorContainer),
        );
        expect(overdueActive.color, isNot(equals(todoWithOverdue.color)));
      },
    );

    testWidgets(
      'Tombol utama dan Skip pada OnboardingScreen memakai bentuk StadiumBorder (pill) dengan ZettaskSpringTap',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            locale: const Locale('id'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: zettaskLocalizationsDelegates,
            theme: AppTheme.lightTheme,
            home: const OnboardingScreen(),
          ),
        );
        await tester.pump(const Duration(milliseconds: 200));

        final primaryFinder =
            find.byKey(const ValueKey('onboarding_primary_button'));
        final skipFinder =
            find.byKey(const ValueKey('onboarding_skip_button'));

        final primaryButton = tester.widget<FilledButton>(primaryFinder);
        final skipButton = tester.widget<TextButton>(skipFinder);

        expect(primaryButton.style?.shape?.resolve({}), isA<StadiumBorder>());
        expect(skipButton.style?.shape?.resolve({}), isA<StadiumBorder>());
        expect(
          find.ancestor(
            of: primaryFinder,
            matching: find.byType(ZettaskSpringTap),
          ),
          findsOneWidget,
        );
        expect(
          find.ancestor(
            of: skipFinder,
            matching: find.byType(ZettaskSpringTap),
          ),
          findsOneWidget,
        );
      },
    );
  });

  group('Feature Flag enableProPaywall (v1.0 Free vs Pro Gating)', () {
    testWidgets(
      'Default enableProPaywall == false: seluruh fitur Pro terbuka gratis dan banner/badge PRO tersembunyi',
      (WidgetTester tester) async {
        expect(SubscriptionProvider.enableProPaywall, isFalse);

        final today = DateTime(2026, 11, 22);
        final db = _MinimalDb();
        final subscriptionProvider = SubscriptionProvider(
          subscriptionService: SubscriptionService(
            billingService: const PlayBillingService(),
          ),
        );
        await subscriptionProvider.initialize();

        expect(subscriptionProvider.isPaywallEnabled, isFalse);
        expect(subscriptionProvider.isPro, isTrue);
        for (final feature in ProFeature.values) {
          expect(subscriptionProvider.hasAccess(feature), isTrue);
        }
        expect(subscriptionProvider.canCreateProject(50), isTrue);

        final themeProvider = ThemeProvider(initialThemeMode: ThemeMode.dark);

        // 1. WorkspaceScreen: banner Pro, debug row Pro, dan seluruh ProBadge tersembunyi
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
              ChangeNotifierProvider<LocaleProvider>(
                create: (_) => LocaleProvider(initialLocale: const Locale('id')),
              ),
              ChangeNotifierProvider<SubscriptionProvider>.value(
                value: subscriptionProvider,
              ),
              ChangeNotifierProvider<AppLockProvider>(
                create: (_) => AppLockProvider(),
              ),
              ChangeNotifierProvider<TaskProvider>(
                create: (_) => TaskProvider(
                  databaseService: db,
                  notificationService: _NoopNotif(),
                  initialDate: today,
                  nowProvider: () => today,
                ),
              ),
              ChangeNotifierProvider<CalendarProvider>(
                create: (_) => CalendarProvider(
                  calendarService: _NoopCalendar(),
                  initialDate: today,
                ),
              ),
              ChangeNotifierProvider<WorkspaceProvider>(
                create: (_) => WorkspaceProvider(
                  databaseService: db,
                  nowProvider: () => today,
                ),
              ),
              ChangeNotifierProvider<AuthProvider>(
                create: (_) => AuthProvider(databaseService: db),
              ),
            ],
            child: MaterialApp(
              locale: const Locale('id'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: zettaskLocalizationsDelegates,
              theme: AppTheme.lightTheme,
              home: const WorkspaceScreen(themeMode: ThemeMode.light),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          find.byKey(const ValueKey('workspace_pro_banner')),
          findsNothing,
        );
        expect(
          find.byKey(const ValueKey('debug_pro_simulation_switch')),
          findsNothing,
        );
        expect(find.text('PRO'), findsNothing);

        // 2. ThemeSettingsScreen: tanpa badge PRO & fitur AMOLED + aksen langsung aktif tanpa paywall
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
              ChangeNotifierProvider<SubscriptionProvider>.value(
                value: subscriptionProvider,
              ),
            ],
            child: MaterialApp(
              locale: const Locale('id'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: zettaskLocalizationsDelegates,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              home: const ThemeSettingsScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('PRO'), findsNothing);

        final listScroll = find.byType(Scrollable).first;
        final amoledSwitch = find.byKey(const ValueKey('amoled_black_switch'));
        await tester.scrollUntilVisible(
          amoledSwitch,
          200,
          scrollable: listScroll,
        );
        await tester.tap(amoledSwitch);
        await tester.pumpAndSettle();
        expect(find.byType(ProPaywallScreen), findsNothing);
        expect(themeProvider.isAmoledBlack, isTrue);

        final sageChip = find.byKey(const ValueKey('accent_chip_sage'));
        await tester.scrollUntilVisible(
          sageChip,
          200,
          scrollable: listScroll,
        );
        await tester.tap(sageChip);
        await tester.pumpAndSettle();
        expect(find.byType(ProPaywallScreen), findsNothing);
        expect(themeProvider.accentColor, ProAccentColor.sage);
      },
    );

    testWidgets(
      'Override enableProPaywall == true: banner/badge PRO tampil kembali dan fitur Pro memicu ProPaywallScreen',
      (WidgetTester tester) async {
        SubscriptionProvider.debugEnableProPaywallOverride = true;
        expect(SubscriptionProvider.enableProPaywall, isTrue);

        final subscriptionProvider = SubscriptionProvider(
          subscriptionService: SubscriptionService(
            billingService: const PlayBillingService(),
          ),
        );
        await subscriptionProvider.initialize();

        expect(subscriptionProvider.isPaywallEnabled, isTrue);
        expect(subscriptionProvider.isPro, isFalse);
        expect(subscriptionProvider.hasAccess(ProFeature.customThemes), isFalse);
        expect(subscriptionProvider.canCreateProject(3), isFalse);

        final themeProvider = ThemeProvider(initialThemeMode: ThemeMode.dark);
        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
              ChangeNotifierProvider<SubscriptionProvider>.value(
                value: subscriptionProvider,
              ),
            ],
            child: MaterialApp(
              locale: const Locale('id'),
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: zettaskLocalizationsDelegates,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              home: const ThemeSettingsScreen(),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final listScroll = find.byType(Scrollable).first;
        final amoledSwitch = find.byKey(const ValueKey('amoled_black_switch'));
        await tester.scrollUntilVisible(
          amoledSwitch,
          200,
          scrollable: listScroll,
        );
        await tester.pumpAndSettle();

        expect(find.byType(ProBadge), findsWidgets);
        expect(find.text('PRO'), findsWidgets);

        await tester.tap(amoledSwitch);
        await tester.pumpAndSettle();
        expect(find.byType(ProPaywallScreen), findsOneWidget);
        expect(themeProvider.isAmoledBlack, isFalse);

        SubscriptionProvider.resetEnableProPaywallOverride();
        expect(SubscriptionProvider.enableProPaywall, isFalse);
      },
    );
  });
}
