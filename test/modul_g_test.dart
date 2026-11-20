import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zettask/l10n/app_localizations.dart';
import 'package:zettask/main.dart';
import 'package:zettask/models/calendar_event_model.dart';
import 'package:zettask/models/note_model.dart';
import 'package:zettask/models/project_model.dart';
import 'package:zettask/models/repeating_task_model.dart';
import 'package:zettask/models/stats_model.dart';
import 'package:zettask/models/tag_model.dart';
import 'package:zettask/models/task_model.dart';
import 'package:zettask/models/task_template_model.dart';
import 'package:zettask/providers/locale_provider.dart';
import 'package:zettask/services/auth_service.dart';
import 'package:zettask/services/calendar_service.dart';
import 'package:zettask/services/database_service.dart';
import 'package:zettask/services/home_widget_service.dart';
import 'package:zettask/services/notification_service.dart';

class _MockHomeWidgetSyncService implements HomeWidgetSyncService {
  final StreamController<Uri?> _clickController =
      StreamController<Uri?>.broadcast();

  String? lastWidgetTitle;
  String? lastWidgetEmptyText;
  int labelUpdateCount = 0;

  @override
  Future<void> updateTodayTasks(
    List<TaskModel> todayTasks, {
    String? widgetTitle,
    String? widgetEmptyText,
  }) async {
    if (widgetTitle != null) lastWidgetTitle = widgetTitle;
    if (widgetEmptyText != null) lastWidgetEmptyText = widgetEmptyText;
  }

  @override
  Future<void> updateWidgetLabels({
    required String widgetTitle,
    required String widgetEmptyText,
  }) async {
    labelUpdateCount++;
    lastWidgetTitle = widgetTitle;
    lastWidgetEmptyText = widgetEmptyText;
  }

  @override
  Future<Uri?> getInitiallyLaunchedUri() async => null;

  @override
  Stream<Uri?> get widgetClicked => _clickController.stream;

  void dispose() {
    _clickController.close();
  }
}

class _StubNotificationService implements TaskNotificationService {
  @override
  Future<void> init() async {}

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<void> scheduleTaskReminder(TaskModel task) async {}

  @override
  Future<void> cancelTaskReminder(int taskId) async {}
}

class _StubCalendarService implements DeviceCalendarService {
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

class _StubDatabaseService implements DatabaseService {
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
  Future<List<TaskModel>> getAllTasks() async => const [];

  @override
  Future<int> toggleTaskComplete(
    int id,
    bool isCompleted, {
    DateTime? completedAt,
  }) async =>
      1;

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
  Future<int> updateTask(TaskModel task) async => 1;

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

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting();
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('16 bahasa terdaftar lengkap dan cocok dengan supportedLocales gen-l10n',
      () {
    expect(LocaleProvider.supportedLanguages.length, 16);
    expect(AppLocalizations.supportedLocales.length, 16);

    for (final option in LocaleProvider.supportedLanguages) {
      final l10n = lookupAppLocalizations(option.locale);
      expect(l10n.appName, 'Zettask');
      expect(l10n.languageTitle.trim(), isNotEmpty);
      expect(l10n.widgetTitle.trim(), isNotEmpty);
      expect(l10n.widgetEmptyText.trim(), isNotEmpty);
    }

    expect(
      LocaleProvider.supportedLanguages.map((e) => e.label).toList(),
      const [
        'عربي (Arabic)',
        'Deutsch (German)',
        'English (English)',
        'Español (Spanish)',
        'Français (French)',
        'עברית (Hebrew)',
        'Bahasa Indonesia (Indonesian)',
        'Italiano (Italian)',
        '日本語 (Japanese)',
        '조선말, 한국어 (Korean)',
        'Português (Portuguese)',
        'Português do Brasil (Brazilian Portuguese)',
        'Русский (Russian)',
        'Українська (Ukrainian)',
        'Tiếng Việt Nam (Vietnamese)',
        '简化字 (Simplified Chinese)',
      ],
    );
  });

  test('LocaleProvider menyimpan preferensi & fallback ke en jika tidak didukung',
      () async {
    final provider = LocaleProvider();
    expect(provider.currentLocale, isNull);
    expect(provider.currentLocaleCode, 'system');

    // Unsupported device locale -> fallback English
    expect(
      LocaleProvider.resolveEffectiveLocale(null, const Locale('th', 'TH')),
      const Locale('en'),
    );
    // Brazilian Portuguese preserved distinctly from Portuguese
    expect(
      LocaleProvider.resolveEffectiveLocale(null, const Locale('pt', 'BR')),
      const Locale('pt', 'BR'),
    );
    expect(
      LocaleProvider.resolveEffectiveLocale(null, const Locale('pt', 'PT')),
      const Locale('pt'),
    );

    // Persist explicit locale pt_BR
    await provider.setLocale(const Locale('pt', 'BR'));
    expect(provider.currentLocale, const Locale('pt', 'BR'));

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(prefLocaleKey), 'pt_BR');

    // Restore from SharedPreferences
    final restored = LocaleProvider();
    await restored.loadSavedLocale();
    expect(restored.currentLocale, const Locale('pt', 'BR'));

    // Reset back to device language (null -> 'system')
    await restored.setLocale(null);
    expect(restored.currentLocale, isNull);
    expect(prefs.getString(prefLocaleKey), 'system');
  });

  test('Terjemahan pesan error Firebase Auth tersedia per bahasa', () {
    final l10nEn = lookupAppLocalizations(const Locale('en'));
    final l10nId = lookupAppLocalizations(const Locale('id'));
    final l10nAr = lookupAppLocalizations(const Locale('ar'));

    expect(
      localizeFirebaseAuthError('wrong-password', l10nEn),
      'Incorrect password.',
    );
    expect(
      localizeFirebaseAuthError('wrong-password', l10nId),
      'Kata sandi tidak sesuai.',
    );
    expect(
      localizeFirebaseAuthError('wrong-password', l10nAr),
      'كلمة المرور غير صحيحة.',
    );
    expect(
      localizeFirebaseAuthError('network-request-failed', l10nEn),
      'Network issue. Please check your internet connection.',
    );
  });

  testWidgets(
      'Pemilih Bahasa mengganti UI secara live tanpa restart dan menyinkronkan label widget',
      (WidgetTester tester) async {
    final fakeWidgetService = _MockHomeWidgetSyncService();
    addTearDown(fakeWidgetService.dispose);

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: _StubDatabaseService(),
        notificationService: _StubNotificationService(),
        calendarService: _StubCalendarService(),
        homeWidgetService: fakeWidgetService,
        initialLocale: const Locale('id'),
        initialDate: DateTime(2026, 11, 20),
        nowProvider: () => DateTime(2026, 11, 20, 9, 0),
      ),
    );
    await tester.pumpAndSettle();

    // Awalnya berbahasa Indonesia
    expect(find.text('Hari Ini'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
    expect(fakeWidgetService.lastWidgetTitle, 'Zettask · Hari Ini');

    // Buka tab More (Workspace) -> gulir ke menu Bahasa
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Bahasa'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Bahasa'), findsOneWidget);

    await tester.tap(find.text('Bahasa'));
    await tester.pumpAndSettle();

    // Opsi paling atas dengan ikon smartphone + 16 bahasa
    expect(find.byIcon(Icons.smartphone_rounded), findsOneWidget);
    expect(find.text('Bahasa perangkat (jika didukung)'), findsOneWidget);
    expect(find.text('English (English)'), findsOneWidget);

    // Pilih English -> UI langsung berubah ke Inggris
    await tester.ensureVisible(find.text('English (English)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('English (English)'));
    await tester.pumpAndSettle();

    expect(find.text('Language'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
    expect(fakeWidgetService.lastWidgetTitle, 'Zettask · Today');
    expect(
      fakeWidgetService.lastWidgetEmptyText,
      'All tasks for today are done.',
    );

    // Pastikan tersimpan di SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(prefLocaleKey), 'en');
  });

  testWidgets(
      'Bahasa Arab (ar) dan Ibrani (he) otomatis mengaktifkan Directionality RTL',
      (WidgetTester tester) async {
    final fakeWidgetService = _MockHomeWidgetSyncService();
    addTearDown(fakeWidgetService.dispose);

    // Uji Bahasa Arab -> RTL
    await tester.pumpWidget(
      ZettaskApp(
        databaseService: _StubDatabaseService(),
        notificationService: _StubNotificationService(),
        calendarService: _StubCalendarService(),
        homeWidgetService: fakeWidgetService,
        initialLocale: const Locale('ar'),
        initialDate: DateTime(2026, 11, 20),
        nowProvider: () => DateTime(2026, 11, 20, 9, 0),
      ),
    );
    await tester.pumpAndSettle();

    final arContext = tester.element(find.byType(Scaffold).first);
    expect(Directionality.of(arContext), TextDirection.rtl);
    expect(find.text('اليوم'), findsOneWidget);

    // Ganti ke Ibrani (he) melalui LanguagePickerSheet -> tetap RTL
    await tester.tap(find.text('المزيد'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('اللغة'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('اللغة'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('עברית (Hebrew)'),
      150,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.ensureVisible(find.text('עברית (Hebrew)'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('עברית (Hebrew)'));
    await tester.pumpAndSettle();

    final heContext = tester.element(find.byType(Scaffold).first);
    expect(Directionality.of(heContext), TextDirection.rtl);
    expect(find.text('שפה'), findsOneWidget);
  });
}
