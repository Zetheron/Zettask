import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zettask/core/theme/app_theme.dart';
import 'package:zettask/main.dart';
import 'package:zettask/models/auth_user_model.dart';
import 'package:zettask/models/calendar_event_model.dart';
import 'package:zettask/models/note_model.dart';
import 'package:zettask/models/project_model.dart';
import 'package:zettask/models/repeating_task_model.dart';
import 'package:zettask/models/stats_model.dart';
import 'package:zettask/models/tag_model.dart';
import 'package:zettask/models/task_model.dart';
import 'package:zettask/models/task_template_model.dart';
import 'package:zettask/models/timeline_entry.dart';
import 'package:zettask/providers/auth_provider.dart';
import 'package:zettask/providers/calendar_provider.dart';
import 'package:zettask/providers/task_provider.dart';
import 'package:zettask/providers/theme_provider.dart';
import 'package:zettask/providers/workspace_provider.dart';
import 'package:zettask/screens/auth_welcome_screen.dart';
import 'package:zettask/screens/login_screen.dart';
import 'package:zettask/screens/signup_screen.dart';
import 'package:zettask/screens/stats_screen.dart';
import 'package:zettask/screens/theme_settings_screen.dart';
import 'package:zettask/services/auth_service.dart';
import 'package:zettask/services/calendar_service.dart';
import 'package:zettask/services/cloud_sync_service.dart';
import 'package:zettask/services/database_service.dart';
import 'package:zettask/services/export_service.dart';
import 'package:zettask/services/notification_service.dart';
import 'package:zettask/widgets/about_sheet.dart';
import 'package:zettask/widgets/account_sheet.dart';
import 'package:zettask/widgets/date_strip.dart';
import 'package:zettask/widgets/quick_add_task_sheet.dart';
import 'package:zettask/widgets/task_editor_sheet.dart';
import 'package:zettask/widgets/timeline_calendar_event_item.dart';
import 'package:zettask/widgets/timeline_task_item.dart';
import 'package:zettask/widgets/weekly_stats_card.dart';

class FakeDatabaseService implements DatabaseService {
  FakeDatabaseService([
    List<TaskModel>? seed,
    List<RepeatingTaskRule>? seedRules,
    List<ProjectModel>? seedProjects,
    List<TagModel>? seedTags,
    List<NoteModel>? seedNotes,
    List<TaskTemplateModel>? seedTemplates,
  ]) {
    if (seed != null) {
      for (final task in seed) {
        final assignedId = task.id ?? _nextId++;
        if (assignedId >= _nextId) _nextId = assignedId + 1;
        _store[assignedId] = task.copyWith(id: assignedId);
      }
    }
    if (seedRules != null) {
      for (final rule in seedRules) {
        final assignedId = rule.id ?? _nextRuleId++;
        if (assignedId >= _nextRuleId) _nextRuleId = assignedId + 1;
        _rules[assignedId] = rule.copyWith(id: assignedId);
      }
    }
    if (seedProjects != null) {
      for (final project in seedProjects) {
        final assignedId = project.id ?? _nextProjectId++;
        if (assignedId >= _nextProjectId) _nextProjectId = assignedId + 1;
        _projects[assignedId] = project.copyWith(id: assignedId);
      }
    }
    if (seedTags != null) {
      for (final tag in seedTags) {
        final assignedId = tag.id ?? _nextTagId++;
        if (assignedId >= _nextTagId) _nextTagId = assignedId + 1;
        _tags[assignedId] = tag.copyWith(id: assignedId);
      }
    }
    if (seedNotes != null) {
      for (final note in seedNotes) {
        final assignedId = note.id ?? _nextNoteId++;
        if (assignedId >= _nextNoteId) _nextNoteId = assignedId + 1;
        _notes[assignedId] = note.copyWith(id: assignedId);
      }
    }
    if (seedTemplates != null) {
      for (final template in seedTemplates) {
        final assignedId = template.id ?? _nextTemplateId++;
        if (assignedId >= _nextTemplateId) _nextTemplateId = assignedId + 1;
        _templates[assignedId] = template.copyWith(id: assignedId);
      }
    }
  }

  final Map<int, TaskModel> _store = {};
  final Map<int, RepeatingTaskRule> _rules = {};
  final Map<int, ProjectModel> _projects = {};
  final Map<int, TagModel> _tags = {};
  final Map<int, NoteModel> _notes = {};
  final Map<int, TaskTemplateModel> _templates = {};
  int _nextId = 1;
  int _nextRuleId = 1;
  int _nextProjectId = 1;
  int _nextTagId = 1;
  int _nextNoteId = 1;
  int _nextTemplateId = 1;

  @override
  Future<Database> get database =>
      throw UnimplementedError('Not needed in FakeDatabaseService');

  @override
  Future<int> insertTask(TaskModel task) async {
    final id = task.id ?? _nextId++;
    if (id >= _nextId) {
      _nextId = id + 1;
    }
    _store[id] = task.copyWith(id: id);
    return id;
  }

  @override
  Future<List<TaskModel>> getTasksByDate(DateTime date) async {
    final key = TaskModel.formatDateKey(date);
    return _store.values
        .where(
          (task) =>
              task.date != null && TaskModel.formatDateKey(task.date!) == key,
        )
        .toList();
  }

  @override
  Future<List<TaskModel>> getTasksInDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final startKey = TaskModel.formatDateKey(start);
    final endKey = TaskModel.formatDateKey(end);
    return _store.values.where((task) {
      if (task.date == null) return false;
      final key = TaskModel.formatDateKey(task.date!);
      return key.compareTo(startKey) >= 0 && key.compareTo(endKey) <= 0;
    }).toList();
  }

  @override
  Future<List<TaskModel>> getUnplannedTasks() async {
    return _store.values.where((task) => task.date == null).toList();
  }

  @override
  Future<List<TaskModel>> getOverdueTasks(DateTime today) async {
    final todayKey = TaskModel.formatDateKey(today);
    return _store.values.where((task) {
      if (task.date == null || task.isCompleted) return false;
      return TaskModel.formatDateKey(task.date!).compareTo(todayKey) < 0;
    }).toList();
  }

  @override
  Future<Set<String>> getDatesWithTasks(DateTime start, DateTime end) async {
    final startKey = TaskModel.formatDateKey(start);
    final endKey = TaskModel.formatDateKey(end);
    return _store.values
        .where((task) => task.date != null)
        .map((task) => TaskModel.formatDateKey(task.date!))
        .where(
          (key) => key.compareTo(startKey) >= 0 && key.compareTo(endKey) <= 0,
        )
        .toSet();
  }

  @override
  Future<List<TaskModel>> searchTasks(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const [];
    return _store.values.where((task) {
      final matchesTitle = task.title.toLowerCase().contains(q);
      final matchesDesc = task.description.toLowerCase().contains(q);
      final matchesSub =
          task.checklistItems.any((i) => i.title.toLowerCase().contains(q));
      return matchesTitle || matchesDesc || matchesSub;
    }).toList();
  }

  @override
  Future<int> updateTask(TaskModel task) async {
    final id = task.id;
    if (id == null) {
      throw ArgumentError('Task id null');
    }
    _store[id] = task;
    return 1;
  }

  @override
  Future<int> toggleTaskComplete(
    int id,
    bool isCompleted, {
    DateTime? completedAt,
  }) async {
    final existing = _store[id];
    if (existing == null) return 0;
    _store[id] = existing.copyWith(
      isCompleted: isCompleted,
      completedAt: isCompleted ? (completedAt ?? DateTime.now()) : null,
      clearCompletedAt: !isCompleted,
    );
    return 1;
  }

  @override
  Future<List<TaskModel>> getAllTasks() async => _store.values.toList();

  @override
  Future<List<DailyCompletionStat>> getLast7DaysCompletionStats(
    DateTime today,
  ) async {
    return WorkspaceStats.compute(
      tasks: _store.values.toList(),
      projects: _projects.values.toList(),
      tags: _tags.values.toList(),
      repeatingRules: _rules.values.where((r) => r.isActive).toList(),
      today: today,
    ).last7Days;
  }

  @override
  Future<List<DailyCompletionStat>> getLast30DaysCompletionStats(
    DateTime today,
  ) async {
    return WorkspaceStats.compute(
      tasks: _store.values.toList(),
      projects: _projects.values.toList(),
      tags: _tags.values.toList(),
      repeatingRules: _rules.values.where((r) => r.isActive).toList(),
      today: today,
    ).last30Days;
  }

  @override
  Future<int> deleteTask(int id) async {
    return _store.remove(id) != null ? 1 : 0;
  }

  @override
  Future<int> insertRepeatingRule(RepeatingTaskRule rule) async {
    final id = rule.id ?? _nextRuleId++;
    if (id >= _nextRuleId) {
      _nextRuleId = id + 1;
    }
    _rules[id] = rule.copyWith(id: id);
    return id;
  }

  @override
  Future<List<RepeatingTaskRule>> getRepeatingRules({
    bool activeOnly = false,
  }) async {
    return _rules.values
        .where((rule) => !activeOnly || rule.isActive)
        .toList();
  }

  @override
  Future<RepeatingTaskRule?> getRepeatingRuleById(int id) async => _rules[id];

  @override
  Future<int> updateRepeatingRule(RepeatingTaskRule rule) async {
    final id = rule.id;
    if (id == null) throw ArgumentError('Rule id null');
    _rules[id] = rule;
    return 1;
  }

  @override
  Future<int> deleteRepeatingRule(int id) async {
    return _rules.remove(id) != null ? 1 : 0;
  }

  @override
  Future<bool> hasTaskForRepeatingRuleOnDate(int ruleId, DateTime date) async {
    final key = TaskModel.formatDateKey(date);
    return _store.values.any(
      (task) =>
          task.repeatingRuleId == ruleId &&
          task.date != null &&
          TaskModel.formatDateKey(task.date!) == key,
    );
  }

  @override
  Future<List<TaskModel>> getIncompleteFutureTasksForRule(
    int ruleId,
    DateTime fromDate,
  ) async {
    final fromKey = TaskModel.formatDateKey(fromDate);
    return _store.values
        .where(
          (task) =>
              task.repeatingRuleId == ruleId &&
              !task.isCompleted &&
              task.date != null &&
              TaskModel.formatDateKey(task.date!).compareTo(fromKey) >= 0,
        )
        .toList();
  }

  @override
  Future<int> deleteIncompleteFutureTasksForRule(
    int ruleId,
    DateTime fromDate,
  ) async {
    final fromKey = TaskModel.formatDateKey(fromDate);
    final toRemove = _store.entries
        .where(
          (entry) =>
              entry.value.repeatingRuleId == ruleId &&
              !entry.value.isCompleted &&
              entry.value.date != null &&
              TaskModel.formatDateKey(entry.value.date!).compareTo(fromKey) >=
                  0,
        )
        .map((entry) => entry.key)
        .toList();
    for (final key in toRemove) {
      _store.remove(key);
    }
    return toRemove.length;
  }

  @override
  Future<int> getCompletedCountForRule(int ruleId) async {
    return _store.values
        .where((task) => task.repeatingRuleId == ruleId && task.isCompleted)
        .length;
  }

  @override
  Future<Set<String>> getCompletedDatesForRuleInRange(
    int ruleId,
    DateTime start,
    DateTime end,
  ) async {
    final startKey = TaskModel.formatDateKey(start);
    final endKey = TaskModel.formatDateKey(end);
    return _store.values
        .where(
          (task) =>
              task.repeatingRuleId == ruleId &&
              task.isCompleted &&
              task.date != null,
        )
        .map((task) => TaskModel.formatDateKey(task.date!))
        .where(
          (key) => key.compareTo(startKey) >= 0 && key.compareTo(endKey) <= 0,
        )
        .toSet();
  }

  @override
  Future<int> insertProject(ProjectModel project) async {
    final id = project.id ?? _nextProjectId++;
    if (id >= _nextProjectId) _nextProjectId = id + 1;
    _projects[id] = project.copyWith(id: id);
    return id;
  }

  @override
  Future<List<ProjectModel>> getProjects() async =>
      _projects.values.toList()..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));

  @override
  Future<int> updateProject(ProjectModel project) async {
    _projects[project.id!] = project;
    return 1;
  }

  @override
  Future<int> deleteProject(int id) async {
    for (final key in _store.keys.toList()) {
      final task = _store[key]!;
      if (task.projectId == id) {
        _store[key] = task.copyWith(clearProject: true);
      }
    }
    for (final key in _rules.keys.toList()) {
      final rule = _rules[key]!;
      if (rule.projectId == id) {
        _rules[key] = rule.copyWith(clearProject: true);
      }
    }
    for (final key in _templates.keys.toList()) {
      final t = _templates[key]!;
      if (t.projectId == id) {
        _templates[key] = t.copyWith(clearProject: true);
      }
    }
    return _projects.remove(id) != null ? 1 : 0;
  }

  @override
  Future<int> insertTag(TagModel tag) async {
    final id = tag.id ?? _nextTagId++;
    if (id >= _nextTagId) _nextTagId = id + 1;
    _tags[id] = tag.copyWith(id: id);
    return id;
  }

  @override
  Future<List<TagModel>> getTags() async => _tags.values.toList();

  @override
  Future<int> updateTag(TagModel tag) async {
    _tags[tag.id!] = tag;
    return 1;
  }

  @override
  Future<int> deleteTag(int id) async {
    for (final key in _store.keys.toList()) {
      final task = _store[key]!;
      if (task.tagId == id) {
        _store[key] = task.copyWith(clearTag: true);
      }
    }
    for (final key in _rules.keys.toList()) {
      final rule = _rules[key]!;
      if (rule.tagId == id) {
        _rules[key] = rule.copyWith(clearTag: true);
      }
    }
    for (final key in _notes.keys.toList()) {
      final note = _notes[key]!;
      if (note.tagId == id) {
        _notes[key] = note.copyWith(clearTag: true);
      }
    }
    for (final key in _templates.keys.toList()) {
      final t = _templates[key]!;
      if (t.tagId == id) {
        _templates[key] = t.copyWith(clearTag: true);
      }
    }
    return _tags.remove(id) != null ? 1 : 0;
  }

  @override
  Future<int> insertNote(NoteModel note) async {
    final id = note.id ?? _nextNoteId++;
    if (id >= _nextNoteId) _nextNoteId = id + 1;
    _notes[id] = note.copyWith(id: id);
    return id;
  }

  @override
  Future<List<NoteModel>> getNotes() async => _notes.values.toList()
    ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  @override
  Future<int> updateNote(NoteModel note) async {
    _notes[note.id!] = note;
    return 1;
  }

  @override
  Future<int> deleteNote(int id) async => _notes.remove(id) != null ? 1 : 0;

  @override
  Future<int> insertTemplate(TaskTemplateModel template) async {
    final id = template.id ?? _nextTemplateId++;
    if (id >= _nextTemplateId) _nextTemplateId = id + 1;
    _templates[id] = template.copyWith(id: id);
    return id;
  }

  @override
  Future<List<TaskTemplateModel>> getTemplates() async =>
      _templates.values.toList();

  @override
  Future<int> updateTemplate(TaskTemplateModel template) async {
    _templates[template.id!] = template;
    return 1;
  }

  @override
  Future<int> deleteTemplate(int id) async =>
      _templates.remove(id) != null ? 1 : 0;

  @override
  Future<List<TaskModel>> getTasksByProject(int projectId) async =>
      _store.values.where((t) => t.projectId == projectId).toList();

  @override
  Future<List<TaskModel>> getTasksByTag(int tagId) async =>
      _store.values.where((t) => t.tagId == tagId).toList();

  @override
  Future<Map<int, ProjectProgress>> getProjectTaskCounts() async {
    final counts = <int, ProjectProgress>{};
    for (final task in _store.values) {
      final pid = task.projectId;
      if (pid == null) continue;
      final current = counts[pid] ?? const ProjectProgress();
      counts[pid] = ProjectProgress(
        completedCount: current.completedCount + (task.isCompleted ? 1 : 0),
        totalCount: current.totalCount + 1,
      );
    }
    return counts;
  }

  @override
  Future<Map<int, int>> getTagTaskCounts() async {
    final counts = <int, int>{};
    for (final task in _store.values) {
      final tid = task.tagId;
      if (tid == null) continue;
      counts[tid] = (counts[tid] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Future<void> close() async {}
}

class FakeExportService implements DataExportService {
  int exportCallCount = 0;
  ExportTarget? lastTarget;
  int lastTaskCount = 0;
  int lastNoteCount = 0;

  @override
  Future<ExportResult> exportData({
    required ExportTarget target,
    required List<TaskModel> tasks,
    required List<NoteModel> notes,
    required List<ProjectModel> projects,
    required List<TagModel> tags,
    DateTime? timestamp,
  }) async {
    exportCallCount++;
    lastTarget = target;
    lastTaskCount = tasks.length;
    lastNoteCount = notes.length;
    final count = target == ExportTarget.both ? 2 : 1;
    return ExportResult(
      success: true,
      fileCount: count,
      message: 'Berhasil menyiapkan $count berkas CSV.',
    );
  }
}

class FakeNotificationService implements TaskNotificationService {
  FakeNotificationService({this.permissionGranted = true});

  bool permissionGranted;
  int initCallCount = 0;
  int permissionRequestCount = 0;
  final List<TaskModel> scheduledTasks = [];
  final List<int> cancelledTaskIds = [];

  @override
  Future<void> init() async {
    initCallCount++;
  }

  @override
  Future<bool> requestPermissions() async {
    permissionRequestCount++;
    return permissionGranted;
  }

  @override
  Future<void> scheduleTaskReminder(TaskModel task) async {
    scheduledTasks.add(task);
  }

  @override
  Future<void> cancelTaskReminder(int taskId) async {
    cancelledTaskIds.add(taskId);
  }
}

class FakeDeviceCalendarService implements DeviceCalendarService {
  FakeDeviceCalendarService({
    this.granted = false,
    this.grantOnRequest = true,
    this.permanentlyDenied = false,
    this.calendars = const [],
    this.events = const [],
  });

  bool granted;
  bool grantOnRequest;
  bool permanentlyDenied;
  List<DeviceCalendarInfo> calendars;
  List<CalendarEventModel> events;

  int requestCount = 0;
  int openSettingsCount = 0;
  DateTime? lastQueriedDate;

  @override
  Future<bool> hasPermissions() async => granted;

  @override
  Future<bool> requestPermissions() async {
    requestCount++;
    if (grantOnRequest && !permanentlyDenied) {
      granted = true;
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
  Future<List<DeviceCalendarInfo>> getCalendars() async => calendars;

  @override
  Future<List<CalendarEventModel>> getEventsForDate(
    DateTime date,
    Set<String> selectedCalendarIds,
  ) async {
    lastQueriedDate = date;
    if (selectedCalendarIds.isEmpty) return const [];
    final key = TaskModel.formatDateKey(date);
    return events
        .where(
          (event) =>
              selectedCalendarIds.contains(event.calendarId) &&
              TaskModel.formatDateKey(event.start) == key,
        )
        .toList();
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

  testWidgets('AppTheme menggunakan palet GEMINI.md dan elevation 0 pada kartu',
      (WidgetTester tester) async {
    expect(AppTheme.lightBackground, const Color(0xFFFAFAFA));
    expect(AppTheme.lightSurfaceVariant, const Color(0xFFF5F5F4));
    expect(AppTheme.darkBackground, const Color(0xFF0A0A0A));
    expect(AppTheme.darkSurface, const Color(0xFF121212));

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: FakeDatabaseService(),
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        autoLoadTasks: false,
      ),
    );

    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.theme?.scaffoldBackgroundColor, const Color(0xFFFAFAFA));
    expect(materialApp.theme?.cardTheme.elevation, 0);
    expect(
      materialApp.darkTheme?.scaffoldBackgroundColor,
      const Color(0xFF0A0A0A),
    );
    expect(materialApp.darkTheme?.colorScheme.surface, const Color(0xFF121212));
    expect(materialApp.darkTheme?.cardTheme.elevation, 0);
  });

  test(
      'TaskModel mendukung tugas terjadwal, pengingat, dan tugas Unplanned (date null)',
      () {
    final original = TaskModel(
      id: 1,
      title: 'Setup Modul A',
      description: 'Bottom navigation dan unplanned',
      date: DateTime(2026, 11, 19),
      startTime: '09:00',
      isCompleted: false,
      priority: TaskPriority.high,
      colorHex: '#0D9488',
      reminderMinutesBefore: 10,
      checklistItems: const [
        ChecklistItem(title: 'Migrasi SQLite v3', isDone: true),
        ChecklistItem(title: 'Bottom nav 4 tab', isDone: false),
      ],
    );

    final restored = TaskModel.fromMap(original.toMap());
    expect(restored.isUnplanned, isFalse);
    expect(TaskModel.formatDateKey(restored.date!), '2026-11-19');
    expect(restored.reminderMinutesBefore, 10);
    expect(restored.reminderDateTime, DateTime(2026, 11, 19, 8, 50));

    final unplanned = restored.copyWith(clearDate: true);
    expect(unplanned.date, isNull);
    expect(unplanned.startTime, isNull);
    expect(unplanned.reminderMinutesBefore, isNull);
    expect(unplanned.isUnplanned, isTrue);

    final unplannedRestored = TaskModel.fromMap(unplanned.toMap());
    expect(unplannedRestored.date, isNull);
    expect(unplannedRestored.isUnplanned, isTrue);
  });

  test(
      'TaskProvider menghitung Overdue, Unplanned, datesWithTasks, dan menyimpan preferensi tampilan',
      () async {
    final today = DateTime(2026, 11, 19);
    final yesterday = DateTime(2026, 11, 18);
    final tomorrow = DateTime(2026, 11, 20);

    final fakeDb = FakeDatabaseService([
      TaskModel(
        id: 1,
        title: 'Tugas Kemarin Terlambat',
        date: yesterday,
        isCompleted: false,
      ),
      TaskModel(
        id: 2,
        title: 'Tugas Kemarin Selesai',
        date: yesterday,
        isCompleted: true,
      ),
      TaskModel(
        id: 3,
        title: 'Standup Pagi',
        date: today,
        startTime: '08:30',
      ),
      TaskModel(
        id: 4,
        title: 'Selesai Hari Ini',
        date: today,
        startTime: '11:00',
        isCompleted: true,
      ),
      TaskModel(
        id: 5,
        title: 'Ide Fitur Baru',
        date: null,
      ),
      TaskModel(
        id: 6,
        title: 'Persiapan Besok',
        date: tomorrow,
        startTime: '10:00',
      ),
    ]);

    final provider = TaskProvider(
      databaseService: fakeDb,
      notificationService: FakeNotificationService(),
      initialDate: today,
      nowProvider: () => today,
    );
    await provider.initialize();

    expect(provider.overdueCount, 1);
    expect(provider.overdueTasks.first.title, 'Tugas Kemarin Terlambat');
    expect(provider.unplannedCount, 1);
    expect(provider.unplannedTasks.first.title, 'Ide Fitur Baru');
    expect(provider.activeTaskCount, 1);
    expect(provider.hasTasksOnDate(today), isTrue);
    expect(provider.hasTasksOnDate(tomorrow), isTrue);
    expect(provider.hasTasksOnDate(DateTime(2026, 11, 25)), isFalse);

    // Sembunyikan tugas selesai -> simpan ke SharedPreferences
    await provider.setShowCompletedTasks(false);
    expect(provider.scheduledTasks.map((t) => t.title).toList(), ['Standup Pagi']);

    await provider.setViewMode(TimelineViewMode.timeline);
    expect(provider.timelineDates.length, 2);

    // Instance baru harus memulihkan preferensi
    final restoredProvider = TaskProvider(
      databaseService: fakeDb,
      notificationService: FakeNotificationService(),
      initialDate: today,
      nowProvider: () => today,
    );
    await restoredProvider.initialize();
    expect(restoredProvider.showCompletedTasks, isFalse);
    expect(restoredProvider.viewMode, TimelineViewMode.timeline);

    // Pindah tugas overdue ke hari ini
    await restoredProvider.moveTaskToDate(
      restoredProvider.overdueTasks.first,
      today,
    );
    expect(restoredProvider.overdueCount, 0);
    expect(restoredProvider.activeTaskCount, 2);
  });

  test(
      'TaskProvider menjadwalkan dan membatalkan notifikasi sesuai siklus hidup tugas',
      () async {
    final futureDate = DateTime.now().add(const Duration(days: 2));
    final fakeDb = FakeDatabaseService();
    final fakeNotifications = FakeNotificationService();
    final provider = TaskProvider(
      databaseService: fakeDb,
      notificationService: fakeNotifications,
      initialDate: futureDate,
    );

    await provider.addTask(
      TaskModel(
        title: 'Kirim proposal',
        date: futureDate,
        startTime: '10:00',
        reminderMinutesBefore: 10,
      ),
    );
    expect(fakeNotifications.scheduledTasks.length, 1);
    final createdTask = provider.tasks.first;

    await provider.toggleTaskComplete(createdTask);
    expect(fakeNotifications.cancelledTaskIds, [createdTask.id]);

    await provider.toggleTaskComplete(provider.tasks.first);
    expect(fakeNotifications.scheduledTasks.length, 2);

    await provider.updateTask(
      provider.tasks.first.copyWith(clearReminder: true),
    );
    expect(fakeNotifications.cancelledTaskIds.last, createdTask.id);

    final withReminder =
        provider.tasks.first.copyWith(reminderMinutesBefore: 30);
    await provider.updateTask(withReminder);
    expect(fakeNotifications.scheduledTasks.length, 3);

    await provider.deleteTask(createdTask.id!);
    expect(fakeNotifications.cancelledTaskIds.last, createdTask.id);

    await provider.restoreTask(withReminder);
    expect(fakeNotifications.scheduledTasks.length, 4);
  });

  test(
      'CalendarProvider menyimpan preferensi sinkronisasi & pilihan kalender secara persisten',
      () async {
    final today = DateTime(2026, 11, 19);
    final fakeCalendarService = FakeDeviceCalendarService(
      granted: false,
      grantOnRequest: true,
      calendars: const [
        DeviceCalendarInfo(
          id: 'cal_work',
          name: 'Kerja',
          accountName: 'kerja@company.com',
          colorHex: '#2563EB',
          isPrimary: true,
        ),
        DeviceCalendarInfo(
          id: 'cal_personal',
          name: 'Pribadi',
          colorHex: '#059669',
        ),
      ],
      events: [
        CalendarEventModel(
          id: 'ev_1',
          calendarId: 'cal_work',
          title: 'Sprint Planning',
          start: DateTime(2026, 11, 19, 10, 0),
          end: DateTime(2026, 11, 19, 11, 0),
          colorHex: '#2563EB',
        ),
        CalendarEventModel(
          id: 'ev_2',
          calendarId: 'cal_personal',
          title: 'Ulang Tahun Raka',
          start: DateTime(2026, 11, 19),
          end: DateTime(2026, 11, 20),
          isAllDay: true,
          colorHex: '#059669',
        ),
      ],
    );

    final provider = CalendarProvider(
      calendarService: fakeCalendarService,
      initialDate: today,
    );
    await provider.initialize(initialDate: today);
    expect(provider.isSyncEnabled, isFalse);

    await provider.setSyncEnabled(true);
    expect(provider.isSyncEnabled, isTrue);
    expect(provider.events.length, 2);

    await provider.toggleCalendarSelection('cal_personal');
    expect(provider.selectedCalendarIds, {'cal_work'});
    expect(provider.events.map((e) => e.title).toList(), ['Sprint Planning']);

    final restoredProvider = CalendarProvider(
      calendarService: fakeCalendarService,
      initialDate: today,
    );
    await restoredProvider.initialize(initialDate: today);
    expect(restoredProvider.isSyncEnabled, isTrue);
    expect(restoredProvider.selectedCalendarIds, {'cal_work'});
  });

  test(
      'TimelineMerger menggabungkan tugas dan acara kalender dalam urutan kronologis',
      () {
    final day = DateTime(2026, 11, 19);
    final mergedScheduled = TimelineMerger.mergeScheduled(
      tasks: [
        TaskModel(id: 2, title: 'Cek email', date: day, startTime: '08:30'),
        TaskModel(id: 3, title: 'Deploy staging', date: day, startTime: '13:00'),
      ],
      events: [
        CalendarEventModel(
          id: 'ev_10',
          calendarId: 'cal_1',
          title: 'Sync Desain',
          start: DateTime(2026, 11, 19, 10, 0),
          end: DateTime(2026, 11, 19, 11, 0),
        ),
      ],
    );

    expect(
      mergedScheduled.map((e) => e.sortTitle).toList(),
      ['Cek email', 'Sync Desain', 'Deploy staging'],
    );
  });

  testWidgets(
      'MainShell menampilkan 4 tab Bottom Navigation, 3 kartu ringkasan, DateStrip bawah, dan tombol cepat tambah tugas',
      (WidgetTester tester) async {
    final today = TaskProvider.normalizeDate(DateTime.now());
    final yesterday = today.subtract(const Duration(days: 1));

    final fakeDb = FakeDatabaseService([
      TaskModel(id: 1, title: 'Bayar tagihan kemarin', date: yesterday),
      TaskModel(id: 2, title: 'Catat ide baru', date: null),
    ]);

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: fakeDb,
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    // Navigasi 4 tab
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Timeline'), findsOneWidget);
    expect(find.text('Board'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);

    // 3 Kartu ringkasan + DateStrip di bagian bawah
    expect(find.text('To Do'), findsOneWidget);
    expect(find.text('Terlambat'), findsOneWidget);
    expect(find.byType(DateStrip), findsOneWidget);
    expect(find.text('Tambah tugas hari ini'), findsOneWidget);

    // Tambah tugas cepat dari ujung garis timeline (QuickAddTaskSheet)
    await tester.tap(find.text('Tambah tugas hari ini'));
    await tester.pumpAndSettle();
    expect(find.byType(QuickAddTaskSheet), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('quick_add_title_field')),
      'Beli kopi',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('quick_add_save_button')));
    await tester.pumpAndSettle();
    expect(find.text('Beli kopi'), findsOneWidget);

    // Ketuk kartu Terlambat -> buka Overdue sheet & pindah ke Hari Ini
    await tester.tap(find.text('Terlambat'));
    await tester.pumpAndSettle();
    expect(find.text('Tugas Terlambat'), findsOneWidget);
    expect(find.text('Bayar tagihan kemarin'), findsOneWidget);
    await tester.tap(find.text('Pindah ke Hari Ini'));
    await tester.pumpAndSettle();
    expect(find.text('Tidak ada tugas terlambat'), findsOneWidget);

    await tester.tap(find.byTooltip('Tutup'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Bayar tagihan kemarin'),
      150,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Bayar tagihan kemarin'), findsOneWidget);

    // Pindah ke tab Board
    await tester.tap(find.text('Board'));
    await tester.pumpAndSettle();
    expect(find.text('Belum ada proyek'), findsOneWidget);

    // Pindah ke tab Unplanned & tambah tugas tanpa tanggal
    await tester.tap(find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text('Unplanned'),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Catat ide baru'), findsOneWidget);

    await tester.tap(find.byTooltip('Tambah Tugas Unplanned'));
    await tester.pumpAndSettle();
    expect(find.byType(QuickAddTaskSheet), findsOneWidget);
    expect(find.text('Tanpa tanggal'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('quick_add_title_field')),
      'Baca buku desain',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('quick_add_save_button')));
    await tester.pumpAndSettle();
    expect(find.text('Baca buku desain'), findsOneWidget);
  });

  testWidgets(
      'TimelineOptionsSheet menyembunyikan tugas selesai dan mendukung Mode Timeline',
      (WidgetTester tester) async {
    final today = TaskProvider.normalizeDate(DateTime.now());
    final tomorrow = today.add(const Duration(days: 1));

    final fakeDb = FakeDatabaseService([
      TaskModel(
        id: 1,
        title: 'Tugas Aktif',
        date: today,
        startTime: '09:00',
      ),
      TaskModel(
        id: 2,
        title: 'Tugas Sudah Beres',
        date: today,
        startTime: '10:00',
        isCompleted: true,
      ),
      TaskModel(
        id: 3,
        title: 'Agenda Besok',
        date: tomorrow,
        startTime: '11:00',
      ),
    ]);

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: fakeDb,
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Tugas Sudah Beres'), findsOneWidget);
    expect(find.text('Agenda Besok'), findsNothing);

    await tester.tap(find.byTooltip('Opsi timeline'));
    await tester.pumpAndSettle();

    // Matikan tampilkan tugas selesai
    await tester.tap(find.text('Tampilkan tugas selesai'));
    await tester.pumpAndSettle();

    // Ubah ke Mode Timeline
    await tester.tap(find.text('Mode Timeline'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Tutup'));
    await tester.pumpAndSettle();

    expect(find.text('Tugas Sudah Beres'), findsNothing);
    expect(find.text('Tugas Aktif'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Agenda Besok'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Agenda Besok'), findsOneWidget);
  });

  testWidgets(
      'Workspace (tab More) mengelola Sinkronisasi Kalender, Tema persisten, dan Tentang',
      (WidgetTester tester) async {
    final today = TaskProvider.normalizeDate(DateTime.now());
    final fakeCalendar = FakeDeviceCalendarService(
      granted: false,
      grantOnRequest: true,
      calendars: const [
        DeviceCalendarInfo(
          id: 'cal_google',
          name: 'Google Calendar',
          accountName: 'user@gmail.com',
          colorHex: '#2563EB',
          isPrimary: true,
        ),
      ],
      events: [
        CalendarEventModel(
          id: 'ev_1',
          calendarId: 'cal_google',
          title: 'Rapat Desain',
          description: 'Review modul A',
          location: 'Ruang Meeting 2',
          start: DateTime(today.year, today.month, today.day, 10, 0),
          end: DateTime(today.year, today.month, today.day, 11, 0),
          colorHex: '#2563EB',
        ),
      ],
    );

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: FakeDatabaseService([
          TaskModel(id: 1, title: 'Standup', date: today, startTime: '09:00'),
        ]),
        notificationService: FakeNotificationService(),
        calendarService: fakeCalendar,
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    // Pindah ke tab More (Workspace)
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    expect(find.text('Workspace'), findsOneWidget);

    // 1. Buka Tentang & Privasi
    await tester.scrollUntilVisible(
      find.text('Tentang & Kebijakan Privasi'),
      250,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.ensureVisible(find.text('Tentang & Kebijakan Privasi'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tentang & Kebijakan Privasi'));
    await tester.pumpAndSettle();
    expect(find.text('Versi ${AboutSheet.appVersion}'), findsOneWidget);
    await tester.tap(find.byTooltip('Tutup'));
    await tester.pumpAndSettle();

    // 2. Pilih Tema Gelap di ThemeSettingsScreen -> simpan ke SharedPreferences
    await tester.scrollUntilVisible(
      find.text('Tema'),
      -200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.ensureVisible(find.text('Tema'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tema'));
    await tester.pumpAndSettle();
    expect(find.byType(ThemeSettingsScreen), findsOneWidget);
    await tester.tap(find.text('Gelap'));
    await tester.pumpAndSettle();
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(prefThemeModeKey), 'dark');
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // 3. Aktifkan Sinkronisasi Kalender lalu kembali ke Timeline
    await tester.scrollUntilVisible(
      find.text('Sinkronisasi Kalender'),
      -200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.ensureVisible(find.text('Sinkronisasi Kalender'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sinkronisasi Kalender'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Berikan Izin Kalender'));
    await tester.pumpAndSettle();
    expect(find.text('Google Calendar'), findsOneWidget);

    await tester.tap(find.byTooltip('Tutup'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Timeline'));
    await tester.pumpAndSettle();
    expect(find.byType(TimelineCalendarEventItem), findsOneWidget);
    expect(find.text('Rapat Desain'), findsOneWidget);
  });

  testWidgets(
      'Checklist inline, swipe selesai/hapus + Undo, dan pencarian bekerja di Timeline',
      (WidgetTester tester) async {
    final today = TaskProvider.normalizeDate(DateTime.now());
    final fakeNotifications = FakeNotificationService();
    final fakeDb = FakeDatabaseService([
      TaskModel(
        id: 1,
        title: 'Beli bahan makanan',
        date: today,
        checklistItems: const [
          ChecklistItem(title: 'Telur', isDone: false),
          ChecklistItem(title: 'Susu', isDone: true),
        ],
      ),
      TaskModel(
        id: 2,
        title: 'Review PR',
        date: today,
        startTime: '09:00',
        reminderMinutesBefore: 10,
      ),
    ]);

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: fakeDb,
        notificationService: fakeNotifications,
        calendarService: FakeDeviceCalendarService(),
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('1/2 sub-tugas'), findsOneWidget);
    await tester.tap(find.text('Telur'));
    await tester.pumpAndSettle();
    expect(find.text('2/2 sub-tugas'), findsOneWidget);

    // Cari tugas lewat ikon Search di AppBar
    await tester.tap(find.byTooltip('Cari tugas'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField),
      'Review',
    );
    await tester.pumpAndSettle();
    expect(find.text('Review PR'), findsWidgets);
    await tester.tap(find.byTooltip('Tutup'));
    await tester.pumpAndSettle();

    // Swipe kiri hapus lalu urungkan
    await tester.scrollUntilVisible(
      find.text('Review PR'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.drag(
      find.ancestor(
        of: find.text('Review PR'),
        matching: find.byType(TimelineTaskItem),
      ),
      const Offset(-500, 0),
    );
    await tester.pumpAndSettle();
    expect(find.text('Tugas dihapus'), findsOneWidget);
    await tester.tap(find.text('Urungkan'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Review PR'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Review PR'), findsOneWidget);
  });

  test(
      'RepeatingTaskRule matchesDate, nextOccurrenceFrom, scheduleSummary, dan serialisasi bekerja benar',
      () {
    final dailyRule = RepeatingTaskRule(
      id: 1,
      title: 'Olahraga Pagi',
      startTime: '05:30',
      frequency: RepeatFrequency.daily,
      startDate: DateTime(2026, 11, 19),
      excludedDates: const {'2026-11-20'},
      reminderMinutesBefore: 10,
    );

    expect(dailyRule.matchesDate(DateTime(2026, 11, 18)), isFalse);
    expect(dailyRule.matchesDate(DateTime(2026, 11, 19)), isTrue);
    expect(dailyRule.matchesDate(DateTime(2026, 11, 20)), isFalse);
    expect(dailyRule.matchesDate(DateTime(2026, 11, 21)), isTrue);
    expect(
      dailyRule.nextOccurrenceFrom(DateTime(2026, 11, 20)),
      DateTime(2026, 11, 21),
    );
    expect(dailyRule.scheduleSummary, 'Setiap hari · 05:30');

    final restoredDaily = RepeatingTaskRule.fromMap(dailyRule.toMap());
    expect(restoredDaily.excludedDates, {'2026-11-20'});
    expect(restoredDaily.frequency, RepeatFrequency.daily);

    // 2026-11-16 = Senin (1), 2026-11-20 = Jumat (5)
    final weeklyRule = RepeatingTaskRule(
      id: 2,
      title: 'Laporan Mingguan',
      startTime: '15:30',
      frequency: RepeatFrequency.weekly,
      weekdays: const [5, 1],
      startDate: DateTime(2026, 11, 16),
    );
    expect(weeklyRule.matchesDate(DateTime(2026, 11, 16)), isTrue);
    expect(weeklyRule.matchesDate(DateTime(2026, 11, 17)), isFalse);
    expect(weeklyRule.matchesDate(DateTime(2026, 11, 20)), isTrue);
    expect(weeklyRule.scheduleSummary, 'Setiap minggu Sen, Jum · 15:30');

    // Bulanan tgl 31 harus cocok ke 28 Feb pada tahun non-kabisat
    final monthlyRule = RepeatingTaskRule(
      id: 3,
      title: 'Tutup Buku',
      frequency: RepeatFrequency.monthly,
      startDate: DateTime(2026, 1, 31),
    );
    expect(monthlyRule.matchesDate(DateTime(2026, 2, 28)), isTrue);
    expect(monthlyRule.matchesDate(DateTime(2026, 2, 27)), isFalse);
    expect(monthlyRule.matchesDate(DateTime(2026, 4, 30)), isTrue);
  });

  test(
      'TaskProvider mencegah duplikasi & respawn saat hapus sekali, mendukung edit tunggal vs mendatang, dan menghitung dot tracker 30 hari',
      () async {
    final today = DateTime(2026, 11, 19);
    final yesterday = DateTime(2026, 11, 18);
    final tomorrow = DateTime(2026, 11, 20);

    final rule = RepeatingTaskRule(
      id: 1,
      title: 'Baca 20 Menit',
      startTime: '07:00',
      frequency: RepeatFrequency.daily,
      startDate: DateTime(2026, 11, 10),
      reminderMinutesBefore: 10,
    );

    final fakeDb = FakeDatabaseService(
      [
        TaskModel(
          id: 100,
          title: 'Baca 20 Menit',
          date: yesterday,
          startTime: '07:00',
          isCompleted: true,
          repeatingRuleId: 1,
        ),
      ],
      [rule],
    );
    final fakeNotifications = FakeNotificationService();

    final provider = TaskProvider(
      databaseService: fakeDb,
      notificationService: fakeNotifications,
      initialDate: today,
      nowProvider: () => today,
    );

    await provider.initialize();
    await provider.loadTasksForSelectedDate(); // Load ulang tidak boleh duplikasi

    expect(provider.tasks.length, 1);
    expect(provider.tasks.first.title, 'Baca 20 Menit');
    expect(provider.tasks.first.isRepeating, isTrue);

    // Statistik 30 hari: kemarin selesai -> index 28 == true, index 29 (hari ini) == false
    final statsBefore = provider.statsForRule(1);
    expect(statsBefore.last30DaysStatus.length, 30);
    expect(statsBefore.last30DaysStatus[28], isTrue);
    expect(statsBefore.last30DaysStatus[29], isFalse);
    expect(statsBefore.allTimeCompleted, 1);

    // Edit "Hanya tugas ini" hanya mengubah hari ini, bukan besok
    final todayTask = provider.tasks.first;
    await provider.updateRepeatingTask(
      todayTask.copyWith(title: 'Baca Artikel Singkat'),
      scope: RepeatingActionScope.single,
      originalDate: today,
    );
    expect(provider.tasks.first.title, 'Baca Artikel Singkat');
    expect(
      provider.scheduledTasksForDate(tomorrow).first.title,
      'Baca 20 Menit',
    );

    // Edit "Tugas ini dan semua yang akan datang" mengubah rule & jadwal belum selesai, riwayat kemarin utuh
    await provider.updateRepeatingTask(
      provider.tasks.first.copyWith(title: 'Baca 30 Menit'),
      scope: RepeatingActionScope.thisAndFollowing,
      originalDate: today,
    );
    expect(provider.tasks.first.title, 'Baca 30 Menit');
    expect(
      provider.scheduledTasksForDate(tomorrow).first.title,
      'Baca 30 Menit',
    );
    final yesterdayHistory = await fakeDb.getTasksByDate(yesterday);
    expect(yesterdayHistory.first.title, 'Baca 20 Menit');
    expect(yesterdayHistory.first.isCompleted, isTrue);

    // Hapus "Hanya tugas ini" -> masuk excludedDates & tidak respawn saat reload
    await provider.deleteRepeatingTask(
      provider.tasks.first,
      scope: RepeatingActionScope.single,
    );
    await provider.loadTasksForSelectedDate();
    expect(provider.tasks, isEmpty);
    final updatedRule = await fakeDb.getRepeatingRuleById(1);
    expect(updatedRule?.excludedDates, contains('2026-11-19'));
  });

  testWidgets(
      'RepeatingTasksScreen menampilkan tracker 30 hari, jadwal mingguan, dan dialog konfirmasi saat edit tugas berulang',
      (WidgetTester tester) async {
    final today = DateTime(2026, 11, 19);
    final dailyRule = RepeatingTaskRule(
      id: 1,
      title: 'Shalat Subuh & Dzikir',
      startTime: '04:30',
      frequency: RepeatFrequency.daily,
      startDate: today.subtract(const Duration(days: 5)),
      reminderMinutesBefore: 10,
      checklistItems: const [
        ChecklistItem(title: 'Dzikir pagi'),
      ],
    );
    final weeklyRule = RepeatingTaskRule(
      id: 2,
      title: 'Evaluasi Mingguan',
      startTime: '15:30',
      frequency: RepeatFrequency.weekly,
      weekdays: const [1, 5],
      startDate: today.subtract(const Duration(days: 7)),
    );

    final fakeDb = FakeDatabaseService(
      [
        TaskModel(
          id: 50,
          title: 'Shalat Subuh & Dzikir',
          date: today.subtract(const Duration(days: 1)),
          startTime: '04:30',
          isCompleted: true,
          repeatingRuleId: 1,
        ),
      ],
      [dailyRule, weeklyRule],
    );

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: fakeDb,
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    // Di Timeline, tugas berulang muncul dengan ikon repeat & ketuk memunculkan RepeatingActionSheet
    expect(find.text('Shalat Subuh & Dzikir'), findsOneWidget);
    expect(find.byIcon(Icons.repeat_rounded), findsOneWidget);

    await tester.tap(find.text('Shalat Subuh & Dzikir'));
    await tester.pumpAndSettle();

    expect(find.text('Ini adalah tugas berulang'), findsOneWidget);
    expect(find.text('Hanya tugas ini'), findsOneWidget);
    expect(find.text('Tugas ini dan semua yang akan datang'), findsOneWidget);

    await tester.tap(find.byTooltip('Tutup'));
    await tester.pumpAndSettle();

    // Buka tab More -> Otomatisasi -> Tugas Berulang
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Tugas Berulang'),
      220,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Otomatisasi'), findsOneWidget);
    expect(find.text('Tugas Berulang'), findsOneWidget);

    await tester.tap(find.text('Tugas Berulang'));
    await tester.pumpAndSettle();

    expect(find.text('Shalat Subuh & Dzikir'), findsOneWidget);
    expect(find.text('Setiap hari · 04:30'), findsOneWidget);
    expect(find.text('30 hari terakhir'), findsOneWidget);
    expect(find.byKey(const ValueKey('thirty_day_dot_tracker')), findsOneWidget);
    expect(find.text('Hari Ini'), findsOneWidget);

    expect(find.text('Evaluasi Mingguan'), findsOneWidget);
    expect(find.text('Setiap minggu Sen, Jum · 15:30'), findsOneWidget);
    expect(find.text('Sepanjang waktu'), findsOneWidget);
  });

  test(
      'WorkspaceProvider menghitung progres proyek dan menghapus proyek/tag secara aman tanpa menghapus tugas',
      () async {
    final today = DateTime(2026, 11, 19);
    final fakeDb = FakeDatabaseService(
      [
        TaskModel(
          id: 1,
          title: 'Riset UX',
          date: today,
          isCompleted: true,
          projectId: 1,
          tagId: 10,
        ),
        TaskModel(
          id: 2,
          title: 'Implementasi UI',
          date: today,
          isCompleted: false,
          projectId: 1,
          tagId: 10,
        ),
      ],
      null,
      [ProjectModel(id: 1, name: 'Rilis v1', colorHex: '#0D9488')],
      [const TagModel(id: 10, name: 'Produk', colorHex: '#2563EB')],
    );

    final workspace = WorkspaceProvider(databaseService: fakeDb);
    await workspace.initialize();

    final progress = workspace.progressForProject(1);
    expect(progress.completedCount, 1);
    expect(progress.totalCount, 2);
    expect(progress.percentage, 50);
    expect(workspace.taskCountForTag(10), 2);

    // Hapus proyek -> tugas tetap ada tetapi projectId menjadi null
    await workspace.deleteProject(1);
    expect(workspace.projects, isEmpty);
    final remainingTasks = await fakeDb.getTasksByDate(today);
    expect(remainingTasks.length, 2);
    expect(remainingTasks.every((t) => t.projectId == null), isTrue);

    // Hapus tag -> tugas tetap ada tetapi tagId menjadi null
    await workspace.deleteTag(10);
    expect(workspace.tags, isEmpty);
    final tasksAfterTagDelete = await fakeDb.getTasksByDate(today);
    expect(tasksAfterTagDelete.length, 2);
    expect(tasksAfterTagDelete.every((t) => t.tagId == null), isTrue);
  });

  testWidgets(
      'BoardScreen, Timeline badge tag/proyek, dan Organize (Tags, Templates Gunakan, Notes) bekerja end-to-end',
      (WidgetTester tester) async {
    final today = TaskProvider.normalizeDate(DateTime.now());
    final fakeDb = FakeDatabaseService(
      [
        TaskModel(
          id: 1,
          title: 'Audit performa',
          date: today,
          startTime: '09:30',
          isCompleted: true,
          projectId: 1,
          tagId: 1,
        ),
        TaskModel(
          id: 2,
          title: 'Siapkan rilis',
          date: today,
          startTime: '11:00',
          isCompleted: false,
          projectId: 1,
        ),
      ],
      null,
      [
        ProjectModel(id: 1, name: 'Zettask 1.0', colorHex: '#0D9488'),
        ProjectModel(id: 2, name: 'Marketing', colorHex: '#D97706'),
      ],
      [
        const TagModel(id: 1, name: 'Prioritas', colorHex: '#E11D48'),
      ],
      [
        NoteModel(
          id: 1,
          title: 'Catatan Arsitektur',
          content: 'Semua data disimpan lokal di SQLite.',
          tagId: 1,
        ),
      ],
      [
        const TaskTemplateModel(
          id: 1,
          name: 'Checklist Rilis',
          title: 'Verifikasi Rilis Play Store',
          priority: TaskPriority.high,
          colorHex: '#2563EB',
          checklistItems: [
            ChecklistItem(title: 'Cek analyze'),
            ChecklistItem(title: 'Cek build APK'),
          ],
          tagId: 1,
          projectId: 1,
        ),
      ],
    );

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: fakeDb,
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    // 1. Timeline menampilkan badge Tag & label Proyek pada kartu tugas
    expect(find.text('Audit performa'), findsOneWidget);
    expect(find.text('Prioritas'), findsOneWidget);
    expect(find.text('Zettask 1.0'), findsWidgets);

    // 2. Tab Board: filter chip & progress bar proyek (1/2 selesai · 50%)
    await tester.tap(find.text('Board'));
    await tester.pumpAndSettle();

    expect(find.text('Semua Proyek'), findsOneWidget);
    expect(find.text('1/2 selesai'), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);

    // Filter menggunakan chip Marketing
    await tester.tap(find.widgetWithText(ChoiceChip, 'Marketing'));
    await tester.pumpAndSettle();
    expect(find.text('0/0 selesai'), findsOneWidget);
    expect(find.text('1/2 selesai'), findsNothing);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Semua'));
    await tester.pumpAndSettle();
    expect(find.text('1/2 selesai'), findsOneWidget);

    // 3. Tab More -> Organize -> Tags
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Notes'),
      180,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Organize'), findsOneWidget);

    await tester.ensureVisible(find.text('Tags'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tags'));
    await tester.pumpAndSettle();
    expect(find.text('Prioritas'), findsOneWidget);
    expect(find.text('1 tugas'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // 4. Organize -> Notes (tampil catatan & hapus dengan Undo)
    await tester.ensureVisible(find.text('Notes'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Notes'));
    await tester.pumpAndSettle();
    expect(find.text('Catatan Arsitektur'), findsOneWidget);
    await tester.drag(find.text('Catatan Arsitektur'), const Offset(-500, 0));
    await tester.pumpAndSettle();
    expect(find.text('Catatan dihapus'), findsOneWidget);
    await tester.tap(find.text('Urungkan'));
    await tester.pumpAndSettle();
    expect(find.text('Catatan Arsitektur'), findsOneWidget);
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // 5. Organize -> Templates -> Gunakan -> buka TaskEditorSheet terisi template & simpan
    await tester.ensureVisible(find.text('Templates'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Templates'));
    await tester.pumpAndSettle();
    expect(find.text('Checklist Rilis'), findsOneWidget);

    await tester.tap(find.text('Gunakan'));
    await tester.pumpAndSettle();

    expect(
      find.widgetWithText(TextFormField, 'Verifikasi Rilis Play Store'),
      findsOneWidget,
    );
    await tester.tap(find.text('Simpan Tugas'));
    await tester.pumpAndSettle();
    expect(find.text('Tugas dari template disimpan'), findsOneWidget);
  });

  test('WorkspaceStats menghitung 7 hari terakhir, fallback date, dan completion rate', () {
    final today = DateTime(2026, 11, 19);
    final twoDaysAgo = DateTime(2026, 11, 17);
    final tenDaysAgo = DateTime(2026, 11, 9);

    final stats = WorkspaceStats.compute(
      today: today,
      projects: [ProjectModel(id: 1, name: 'Proyek A')],
      tasks: [
        TaskModel(
          id: 1,
          title: 'Selesai Hari Ini',
          date: today,
          isCompleted: true,
          completedAt: DateTime(2026, 11, 19, 10, 0),
          priority: TaskPriority.high,
          projectId: 1,
          checklistItems: const [
            ChecklistItem(title: 'Sub 1', isDone: true),
            ChecklistItem(title: 'Sub 2', isDone: true),
          ],
        ),
        // Legacy task tanpa completedAt -> fallback ke date
        TaskModel(
          id: 2,
          title: 'Selesai 2 Hari Lalu',
          date: twoDaysAgo,
          isCompleted: true,
          priority: TaskPriority.medium,
          projectId: 1,
          checklistItems: const [
            ChecklistItem(title: 'Sub 3', isDone: true),
          ],
        ),
        TaskModel(
          id: 3,
          title: 'Selesai Lama',
          date: tenDaysAgo,
          isCompleted: true,
          completedAt: tenDaysAgo,
          priority: TaskPriority.low,
        ),
        TaskModel(
          id: 4,
          title: 'Belum Selesai',
          date: today,
          isCompleted: false,
          projectId: 1,
        ),
      ],
    );

    expect(stats.last7Days.length, 7);
    expect(stats.completedToday, 1);
    expect(stats.totalTasks7Days, 2);
    expect(stats.totalChecklists7Days, 3);
    expect(stats.allTimeCompletedTasks, 3);
    expect(stats.totalTasks, 4);
    expect(stats.completionPercentage, 75);
    expect(stats.breakdownByPriority[TaskPriority.high], 1);
    expect(stats.breakdownByPriority[TaskPriority.medium], 1);
    expect(stats.breakdownByPriority[TaskPriority.low], 1);
    expect(stats.breakdownByProject.first.completedCount, 2);
    expect(stats.breakdownByProject.first.totalCount, 3);
  });

  test('CsvExportService melakukan escaping RFC 4180 untuk koma, kutip, dan baris baru', () {
    expect(CsvExportService.escapeCsvField('Biasa'), 'Biasa');
    expect(CsvExportService.escapeCsvField('Satu, Dua'), '"Satu, Dua"');
    expect(CsvExportService.escapeCsvField('Kata "Kutip"'), '"Kata ""Kutip"""');
    expect(CsvExportService.escapeCsvField('Baris 1\nBaris 2'), '"Baris 1\nBaris 2"');

    final tasksCsv = CsvExportService.buildTasksCsv(
      tasks: [
        TaskModel(
          id: 7,
          title: 'Rapat "Q4", Tim',
          description: 'Baris A\nBaris B',
          date: DateTime(2026, 11, 19),
          startTime: '09:00',
          isCompleted: true,
          priority: TaskPriority.high,
          projectId: 1,
          tagId: 2,
          checklistItems: const [ChecklistItem(title: 'A', isDone: true)],
          completedAt: DateTime(2026, 11, 19, 9, 30),
        ),
      ],
      projectNames: const {1: 'Zettask'},
      tagNames: const {2: 'Kerja'},
    );

    expect(tasksCsv, contains('id,judul,deskripsi,tanggal,jam,status,prioritas,proyek,tag,jumlah_sub_tugas,selesai_pada'));
    expect(tasksCsv, contains('"Rapat ""Q4"", Tim"'));
    expect(tasksCsv, contains('"Baris A\nBaris B"'));
    expect(tasksCsv, contains(',Selesai,Tinggi,Zettask,Kerja,1,'));

    final notesCsv = CsvExportService.buildNotesCsv(
      notes: [
        NoteModel(
          id: 3,
          title: 'Ide, "Baru"',
          content: 'Poin 1\nPoin 2',
          tagId: 2,
          updatedAt: DateTime(2026, 11, 19, 12, 0),
        ),
      ],
      tagNames: const {2: 'Kerja'},
    );
    expect(notesCsv, contains('id,judul,isi,tag,diperbarui_pada'));
    expect(notesCsv, contains('"Ide, ""Baru"""'));
    expect(notesCsv, contains('"Poin 1\nPoin 2"'));
  });

  testWidgets(
      'WeeklyStatsCard, StatsScreen, dan Ekspor CSV di WorkspaceScreen bekerja end-to-end',
      (WidgetTester tester) async {
    final today = TaskProvider.normalizeDate(DateTime.now());
    final fakeExport = FakeExportService();
    final fakeDb = FakeDatabaseService(
      [
        TaskModel(
          id: 1,
          title: 'Selesaikan Modul D',
          date: today,
          isCompleted: true,
          completedAt: today,
          priority: TaskPriority.high,
          projectId: 1,
          checklistItems: const [
            ChecklistItem(title: 'Grafik 7 hari', isDone: true),
            ChecklistItem(title: 'Ekspor CSV', isDone: true),
          ],
        ),
        TaskModel(
          id: 2,
          title: 'Draft Rilis',
          date: today,
          isCompleted: false,
          projectId: 1,
        ),
      ],
      null,
      [ProjectModel(id: 1, name: 'Peluncuran', colorHex: '#0D9488')],
      null,
      [NoteModel(id: 1, title: 'Catatan Rilis', content: 'Siap uji')],
    );

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: fakeDb,
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        exportService: fakeExport,
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    // Pindah ke tab More (Workspace)
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    expect(find.byType(WeeklyStatsCard), findsOneWidget);
    expect(find.text('7 HARI TERAKHIR'), findsOneWidget);
    expect(find.byKey(const ValueKey('weekly_stats_bars')), findsOneWidget);
    expect(find.text('1 tugas, plus 2 item checklist'), findsOneWidget);

    // Ketuk WeeklyStatsCard -> buka StatsScreen
    await tester.tap(find.byType(WeeklyStatsCard));
    await tester.pumpAndSettle();

    expect(find.text('Statistik'), findsOneWidget);
    expect(find.text('Selesai Hari Ini'), findsOneWidget);
    expect(find.text('Tingkat Selesai'), findsOneWidget);
    expect(find.text('50%'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Peluncuran'),
      250,
      scrollable: find.byType(Scrollable).last,
    );
    expect(find.text('Peluncuran'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    // Scroll ke Ekspor CSV -> pilih Ekspor Keduanya -> verifikasi FakeExportService dipanggil
    await tester.scrollUntilVisible(
      find.text('Ekspor CSV'),
      250,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.ensureVisible(find.text('Ekspor CSV'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ekspor CSV'));
    await tester.pumpAndSettle();

    expect(find.text('Ekspor Data CSV'), findsOneWidget);
    await tester.tap(find.text('Ekspor Keduanya'));
    await tester.pumpAndSettle();

    expect(fakeExport.exportCallCount, 1);
    expect(fakeExport.lastTarget, ExportTarget.both);
    expect(fakeExport.lastTaskCount, 2);
    expect(fakeExport.lastNoteCount, 1);
    expect(find.text('Berhasil menyiapkan 2 berkas CSV.'), findsOneWidget);
  });

  test('mapFirebaseAuthError menerjemahkan kode error Firebase Auth ke Bahasa Indonesia', () {
    expect(
      mapFirebaseAuthError('user-not-found'),
      contains('belum terdaftar'),
    );
    expect(
      mapFirebaseAuthError('wrong-password'),
      contains('Kata sandi'),
    );
    expect(
      mapFirebaseAuthError('invalid-credential'),
      contains('tidak valid'),
    );
    expect(
      mapFirebaseAuthError('email-already-in-use'),
      contains('sudah terdaftar'),
    );
    expect(
      mapFirebaseAuthError('weak-password'),
      contains('minimal 6 karakter'),
    );
    expect(
      mapFirebaseAuthError('network-request-failed'),
      contains('internet'),
    );
    expect(
      mapFirebaseAuthError('requires-recent-login'),
      contains('masuk kembali'),
    );
  });

  test('CloudSyncMerger menggabungkan data lokal & cloud tanpa duplikasi serta menyelesaikan konflik', () {
    final today = DateTime(2026, 11, 19);
    final earlier = DateTime(2026, 11, 18, 9, 0);
    final later = DateTime(2026, 11, 19, 14, 0);

    // First-time merge: ID=1 collides between different projects/tasks, and duplicate task merges
    final firstPlan = CloudSyncMerger.merge(
      local: SyncDataset(
        projects: [
          ProjectModel(id: 1, name: 'Proyek Lokal', createdAt: earlier),
          ProjectModel(id: 2, name: 'Proyek Bersama', createdAt: earlier),
        ],
        tasks: [
          TaskModel(
            id: 1,
            title: 'Tugas Lokal Unik',
            date: today,
            projectId: 1,
          ),
          TaskModel(
            id: 2,
            title: 'Standup Harian',
            date: today,
            startTime: '09:00',
            isCompleted: true,
            completedAt: later,
            projectId: 2,
          ),
        ],
        notes: [
          NoteModel(
            id: 1,
            title: 'Catatan Rilis',
            content: 'Versi baru',
            updatedAt: later,
          ),
        ],
      ),
      cloud: SyncDataset(
        projects: [
          ProjectModel(id: 1, name: 'Proyek Cloud', createdAt: earlier),
          ProjectModel(id: 10, name: 'Proyek Bersama', createdAt: earlier),
        ],
        tasks: [
          TaskModel(
            id: 1,
            title: 'Tugas Cloud Unik',
            date: today,
            projectId: 1,
          ),
          TaskModel(
            id: 10,
            title: 'Standup Harian',
            date: today,
            startTime: '09:00',
            isCompleted: false,
            projectId: 10,
          ),
        ],
        notes: [
          NoteModel(
            id: 1,
            title: 'Catatan Rilis',
            content: 'Versi baru',
            updatedAt: earlier,
          ),
        ],
      ),
      lastSyncedAt: null,
    );

    // 3 distinct projects (Proyek Cloud id=1, Proyek Bersama id=10, Proyek Lokal remapped to id=11)
    expect(firstPlan.merged.projects.length, 3);
    final remappedLocalProject = firstPlan.merged.projects
        .firstWhere((p) => p.name == 'Proyek Lokal');
    expect(remappedLocalProject.id, isNot(1));

    // 3 distinct tasks (no duplication of Standup Harian, local unique task remapped FK)
    expect(firstPlan.merged.tasks.length, 3);
    final mergedStandup =
        firstPlan.merged.tasks.firstWhere((t) => t.title == 'Standup Harian');
    expect(mergedStandup.isCompleted, isTrue);
    expect(mergedStandup.projectId, 10);

    final remappedLocalTask = firstPlan.merged.tasks
        .firstWhere((t) => t.title == 'Tugas Lokal Unik');
    expect(remappedLocalTask.projectId, remappedLocalProject.id);

    // Subsequent sync: newer Note updatedAt wins
    final nextPlan = CloudSyncMerger.merge(
      local: SyncDataset(
        notes: [
          NoteModel(
            id: 5,
            title: 'Catatan',
            content: 'Isi lama',
            updatedAt: earlier,
          ),
        ],
      ),
      cloud: SyncDataset(
        notes: [
          NoteModel(
            id: 5,
            title: 'Catatan',
            content: 'Isi terbaru dari cloud',
            updatedAt: later,
          ),
        ],
      ),
      lastSyncedAt: earlier,
    );

    expect(nextPlan.toSaveLocally.notes.length, 1);
    expect(nextPlan.toSaveLocally.notes.first.content, 'Isi terbaru dari cloud');
    expect(nextPlan.toUploadToCloud.notes, isEmpty);
  });

  test('AuthProvider mengelola login, sinkronisasi otomatis, logout, dan hapus akun termasuk requires-recent-login', () async {
    final today = DateTime(2026, 11, 19);
    final fakeDb = FakeDatabaseService([
      TaskModel(id: 1, title: 'Tugas Lokal', date: today),
    ]);
    final fakeAuth = FakeAuthService();
    final fakeSync = FakeCloudSyncService(
      cloudData: SyncDataset(
        tasks: [
          TaskModel(id: 5, title: 'Tugas Cloud', date: today),
        ],
      ),
    );
    var refreshCallbacks = 0;

    final provider = AuthProvider(
      authService: fakeAuth,
      cloudSyncService: fakeSync,
      databaseService: fakeDb,
      onDataSynced: () async {
        refreshCallbacks++;
      },
    );

    expect(provider.isSignedIn, isFalse);

    // Login email -> otomatis sinkronisasi & panggil onDataSynced
    final signedIn = await provider.signInWithEmail('budi@zettask.app', 'rahasia123');
    expect(signedIn, isTrue);
    expect(provider.isSignedIn, isTrue);
    expect(provider.user?.email, 'budi@zettask.app');
    expect(provider.syncStatus, SyncStatus.synced);
    expect(provider.lastSyncedAt, isNotNull);
    expect(fakeSync.syncCallCount, 1);
    expect(refreshCallbacks, 1);

    final allLocalAfterSync = await fakeDb.getAllTasks();
    expect(allLocalAfterSync.map((t) => t.title), containsAll(['Tugas Lokal', 'Tugas Cloud']));

    // Hapus akun dengan requires-recent-login
    fakeAuth.nextDeleteErrorCode = 'requires-recent-login';
    final deleteBlocked = await provider.deleteAccount();
    expect(deleteBlocked, isFalse);
    expect(provider.requiresRecentLogin, isTrue);
    expect(provider.errorMessage, contains('masuk kembali'));

    // Hapus akun sukses
    fakeAuth.nextDeleteErrorCode = null;
    final deleted = await provider.deleteAccount();
    expect(deleted, isTrue);
    expect(provider.isSignedIn, isFalse);
    expect(fakeSync.deleteUserDataCallCount, 2);
    expect(fakeAuth.deleteAccountCount, 1);

    // Login Google -> lalu Logout
    final googleOk = await provider.signInWithGoogle();
    expect(googleOk, isTrue);
    expect(provider.user?.providerId, 'google.com');

    final signedOut = await provider.signOut();
    expect(signedOut, isTrue);
    expect(provider.isSignedIn, isFalse);
    expect(fakeAuth.signOutCount, 1);

    provider.dispose();
    fakeAuth.dispose();
  });

  testWidgets('Alur AuthWelcomeScreen, validasi SignUp/Login, sync cloud, dan AccountSheet (Logout & Hapus Akun)', (WidgetTester tester) async {
    final today = DateTime(2026, 11, 19);
    final fakeDb = FakeDatabaseService([
      TaskModel(id: 1, title: 'Tugas Offline', date: today, startTime: '08:00'),
    ]);
    final fakeAuth = FakeAuthService();
    final fakeSync = FakeCloudSyncService(
      cloudData: SyncDataset(
        tasks: [
          TaskModel(id: 2, title: 'Tugas dari Cloud', date: today, startTime: '10:00'),
        ],
      ),
    );

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: fakeDb,
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        authService: fakeAuth,
        cloudSyncService: fakeSync,
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    // Buka tab More (Workspace) lalu ketuk ikon profil AppBar
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Akun & Sinkronisasi'));
    await tester.pumpAndSettle();

    expect(find.byType(AuthWelcomeScreen), findsOneWidget);
    expect(find.text('Simpan progres dan tugas Anda'), findsOneWidget);
    expect(find.text('Buat akun baru'), findsOneWidget);
    expect(find.text('Masuk'), findsOneWidget);
    expect(find.text('Lanjutkan dengan Google'), findsOneWidget);

    // Buka SignUpScreen dan uji validasi form
    await tester.tap(find.text('Buat akun baru'));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpScreen), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'email-tidak-valid');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.tap(find.widgetWithText(FilledButton, 'Buat akun baru'));
    await tester.pumpAndSettle();
    expect(find.text('Format email tidak valid.'), findsOneWidget);
    expect(find.text('Kata sandi minimal 6 karakter.'), findsOneWidget);

    // Pindah ke LoginScreen lewat footer
    await tester.ensureVisible(find.text('Masuk'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);

    // Uji Lupa? reset sandi
    await tester.enterText(find.byType(TextFormField).at(0), 'user@zettask.app');
    await tester.tap(find.text('Lupa?'));
    await tester.pumpAndSettle();
    expect(fakeAuth.resetPasswordCount, 1);
    expect(fakeAuth.lastResetEmail, 'user@zettask.app');
    expect(
      find.text('Tautan reset kata sandi dikirim ke user@zettask.app.'),
      findsOneWidget,
    );

    // Masuk dengan email & kata sandi valid -> otomatis sync & kembali ke Workspace
    await tester.enterText(find.byType(TextFormField).at(1), 'sandi123');
    await tester.tap(find.widgetWithText(FilledButton, 'Masuk'));
    await tester.pumpAndSettle();

    expect(find.byType(AuthWelcomeScreen), findsNothing);
    expect(find.text('user@zettask.app'), findsOneWidget);
    expect(fakeSync.syncCallCount, 1);

    // Verifikasi tugas cloud muncul di Timeline setelah sync
    await tester.tap(find.text('Timeline'));
    await tester.pumpAndSettle();
    expect(find.text('Tugas Offline'), findsOneWidget);
    expect(find.text('Tugas dari Cloud'), findsOneWidget);

    // Kembali ke Workspace -> buka AccountSheet -> Sinkronkan sekarang -> Hapus Akun (konfirmasi ganda)
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Akun & Sinkronisasi'));
    await tester.pumpAndSettle();

    expect(find.byType(AccountSheet), findsOneWidget);
    expect(find.text('Sinkronkan sekarang'), findsOneWidget);
    expect(find.text('Keluar'), findsOneWidget);
    expect(find.text('Hapus Akun'), findsOneWidget);

    await tester.tap(find.text('Sinkronkan sekarang'));
    await tester.pumpAndSettle();
    expect(fakeSync.syncCallCount, 2);

    await tester.tap(find.text('Hapus Akun'));
    await tester.pumpAndSettle();
    expect(find.text('Hapus Akun?'), findsOneWidget);

    await tester.tap(find.text('Lanjutkan'));
    await tester.pumpAndSettle();
    expect(find.text('Konfirmasi Penghapusan Permanen'), findsOneWidget);

    await tester.tap(find.text('Ya, Hapus Permanen'));
    await tester.pumpAndSettle();

    expect(fakeSync.deleteUserDataCallCount, 1);
    expect(fakeAuth.deleteAccountCount, 1);
    expect(find.text('Masuk ke Akun Zettask'), findsOneWidget);

    fakeAuth.dispose();
  });

  test('ThemeProvider menyimpan dan memulihkan ThemeMode serta 6 AppThemePreset', () async {
    final provider = ThemeProvider();
    expect(provider.preset, AppThemePreset.defaultIndigo);
    expect(AppThemePreset.values.length, 6);

    await provider.setThemeMode(ThemeMode.dark);
    await provider.setPreset(AppThemePreset.terracotta);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(prefThemeModeKey), 'dark');
    expect(prefs.getString(prefThemePresetKey), 'terracotta');

    final restored = ThemeProvider();
    await restored.loadSavedPreferences();
    expect(restored.themeMode, ThemeMode.dark);
    expect(restored.preset, AppThemePreset.terracotta);
    expect(
      restored.darkTheme.colorScheme.primary,
      AppThemePreset.terracotta.tokens.primaryDark,
    );
  });

  testWidgets(
      'ThemeSettingsScreen menampilkan Live Preview, 6 palet warna, dan menyimpan pilihan',
      (WidgetTester tester) async {
    final today = DateTime(2026, 11, 19);
    await tester.pumpWidget(
      ZettaskApp(
        databaseService: FakeDatabaseService(),
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(
      find.text('Tema'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.ensureVisible(find.text('Tema'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tema'));
    await tester.pumpAndSettle();

    expect(find.byType(ThemeSettingsScreen), findsOneWidget);
    expect(find.byKey(const ValueKey('theme_live_preview')), findsOneWidget);
    expect(find.text('Review desain antarmuka'), findsOneWidget);
    expect(find.text('Sinkronkan jadwal mingguan'), findsOneWidget);
    expect(find.text('Ocean'), findsOneWidget);
    expect(find.text('Forest'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Forest'),
      200,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.ensureVisible(find.text('Forest'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Forest'));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('preset_check_forest')), findsOneWidget);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(prefThemePresetKey), 'forest');
  });

  testWidgets(
      'StatsScreen mendukung 7/30 Hari, Rincian per Tag, dan Kebiasaan (Habits)',
      (WidgetTester tester) async {
    final today = DateTime(2026, 11, 19);
    final fifteenDaysAgo = DateTime(2026, 11, 4);

    final fakeDb = FakeDatabaseService(
      [
        TaskModel(
          id: 1,
          title: 'Olahraga pagi',
          date: today,
          isCompleted: true,
          completedAt: today,
          tagId: 1,
          repeatingRuleId: 1,
          checklistItems: const [
            ChecklistItem(title: 'Pemanasan', isDone: true),
          ],
        ),
        TaskModel(
          id: 2,
          title: 'Tugas 15 hari lalu',
          date: fifteenDaysAgo,
          isCompleted: true,
          completedAt: fifteenDaysAgo,
          tagId: 1,
        ),
      ],
      [
        RepeatingTaskRule(
          id: 1,
          title: 'Olahraga pagi',
          frequency: RepeatFrequency.daily,
          startDate: today,
          isActive: true,
        ),
      ],
      const [],
      const [
        TagModel(id: 1, name: 'Kesehatan', colorHex: '#059669'),
      ],
    );

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: fakeDb,
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(WeeklyStatsCard));
    await tester.pumpAndSettle();
    expect(find.byType(StatsScreen), findsOneWidget);
    expect(find.text('7 Hari'), findsOneWidget);
    expect(find.text('30 Hari'), findsOneWidget);

    // Pindah ke mode 30 Hari -> total 30 hari mencakup tugas 15 hari lalu (2 tugas)
    await tester.tap(find.text('30 Hari'));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('stats_30_day_chart')), findsOneWidget);
    expect(find.text('30 Hari Terakhir'), findsOneWidget);
    expect(
      find.text('Total 30 hari: 2 tugas, plus 1 item checklist'),
      findsOneWidget,
    );

    // Scroll ke Rincian per Tag dan Kebiasaan (Habits)
    final statsVerticalScrollable = find
        .descendant(
          of: find.byType(StatsScreen),
          matching: find.byType(Scrollable),
        )
        .first;
    await tester.scrollUntilVisible(
      find.text('Rincian per Tag'),
      250,
      scrollable: statsVerticalScrollable,
    );
    expect(find.text('#Kesehatan'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Olahraga pagi'),
      250,
      scrollable: statsVerticalScrollable,
    );
    expect(find.text('Kebiasaan (Habits) · 30 Hari'), findsOneWidget);
    expect(find.text('Olahraga pagi'), findsOneWidget);
    expect(find.text('100%'), findsWidgets);
  });

  testWidgets(
      'Pengaturan Hari Awal Minggu (Senin/Minggu) tersimpan dan mengubah urutan DateStrip',
      (WidgetTester tester) async {
    final thursday = DateTime(2026, 11, 19); // Kamis

    // Unit check DateStrip.weekDates
    final mondayWeek = DateStrip.weekDates(thursday, DateTime.monday);
    expect(mondayWeek.first.weekday, DateTime.monday);
    expect(mondayWeek.last.weekday, DateTime.sunday);

    final sundayWeek = DateStrip.weekDates(thursday, DateTime.sunday);
    expect(sundayWeek.first.weekday, DateTime.sunday);
    expect(sundayWeek.last.weekday, DateTime.saturday);

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: FakeDatabaseService(),
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        initialDate: thursday,
        nowProvider: () => thursday,
      ),
    );
    await tester.pumpAndSettle();

    // Default Senin: sel index 0 adalah 2026-11-16 (Senin)
    expect(
      find.byKey(const ValueKey('date_strip_cell_0_2026-11-16')),
      findsOneWidget,
    );

    // Ubah ke Minggu di WorkspaceScreen
    await tester.tap(find.text('More'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Hari Awal Minggu'),
      250,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.ensureVisible(find.text('Hari Awal Minggu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hari Awal Minggu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Minggu'));
    await tester.pumpAndSettle();

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getInt(TaskProvider.prefFirstDayOfWeek), DateTime.sunday);

    // Kembali ke Timeline -> sel index 0 kini adalah 2026-11-15 (Minggu)
    await tester.tap(find.text('Timeline'));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('date_strip_cell_0_2026-11-15')),
      findsOneWidget,
    );
  });

  testWidgets(
      'QuickAddTaskSheet menyimpan tugas cepat dengan chip dan tombol Perluas membuka TaskEditorSheet tanpa kehilangan input',
      (WidgetTester tester) async {
    final today = DateTime(2026, 11, 19);
    final fakeDb = FakeDatabaseService(
      const [],
      const [],
      [ProjectModel(id: 1, name: 'Kerja', colorHex: '#2563EB')],
      const [TagModel(id: 1, name: 'Penting', colorHex: '#E11D48')],
    );

    await tester.pumpWidget(
      ZettaskApp(
        databaseService: fakeDb,
        notificationService: FakeNotificationService(),
        calendarService: FakeDeviceCalendarService(),
        initialDate: today,
        nowProvider: () => today,
      ),
    );
    await tester.pumpAndSettle();

    // Buka QuickAddTaskSheet -> isi judul, pilih Proyek & Prioritas -> Perluas ke TaskEditorSheet
    await tester.tap(find.text('Tambah tugas hari ini'));
    await tester.pumpAndSettle();
    expect(find.byType(QuickAddTaskSheet), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('quick_add_title_field')),
      'Siapkan presentasi klien',
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Proyek'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kerja'));
    await tester.pumpAndSettle();
    expect(find.text('Kerja'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('quick_add_expand_button')));
    await tester.pumpAndSettle();

    expect(find.byType(TaskEditorSheet), findsOneWidget);
    expect(find.text('Tugas Baru'), findsOneWidget);
    expect(
      find.widgetWithText(TextFormField, 'Siapkan presentasi klien'),
      findsOneWidget,
    );

    await tester.tap(find.text('Simpan Tugas'));
    await tester.pumpAndSettle();

    expect(find.text('Siapkan presentasi klien'), findsOneWidget);
    final savedTasks = await fakeDb.getAllTasks();
    expect(savedTasks.length, 1);
    expect(savedTasks.first.projectId, 1);
  });
}

class FakeAuthService implements AuthService {
  final StreamController<AuthUser?> _controller =
      StreamController<AuthUser?>.broadcast();

  AuthUser? _currentUser;
  String? nextSignInErrorCode;
  String? nextDeleteErrorCode;
  int signInCount = 0;
  int signUpCount = 0;
  int googleSignInCount = 0;
  int resetPasswordCount = 0;
  int signOutCount = 0;
  int deleteAccountCount = 0;
  String? lastResetEmail;

  @override
  Stream<AuthUser?> get authStateChanges => _controller.stream;

  @override
  AuthUser? get currentUser => _currentUser;

  @override
  Future<AuthUser> signInWithEmail(String email, String password) async {
    signInCount++;
    if (nextSignInErrorCode != null) {
      throw AuthException(
        code: nextSignInErrorCode!,
        message: mapFirebaseAuthError(nextSignInErrorCode!),
      );
    }
    _currentUser = AuthUser(
      uid: 'uid_email_1',
      email: email.trim(),
      providerId: 'password',
    );
    _controller.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<AuthUser> signUpWithEmail(String email, String password) async {
    signUpCount++;
    _currentUser = AuthUser(
      uid: 'uid_email_new',
      email: email.trim(),
      providerId: 'password',
    );
    _controller.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    googleSignInCount++;
    _currentUser = const AuthUser(
      uid: 'uid_google_1',
      email: 'google@zettask.app',
      displayName: 'Pengguna Google',
      providerId: 'google.com',
    );
    _controller.add(_currentUser);
    return _currentUser;
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    resetPasswordCount++;
    lastResetEmail = email.trim();
  }

  @override
  Future<void> signOut() async {
    signOutCount++;
    _currentUser = null;
    _controller.add(null);
  }

  @override
  Future<void> deleteAccount() async {
    if (nextDeleteErrorCode != null) {
      throw AuthException(
        code: nextDeleteErrorCode!,
        message: mapFirebaseAuthError(nextDeleteErrorCode!),
      );
    }
    deleteAccountCount++;
    _currentUser = null;
    _controller.add(null);
  }

  void dispose() {
    _controller.close();
  }
}

class FakeCloudSyncService implements CloudSyncService {
  FakeCloudSyncService({
    SyncDataset? cloudData,
  }) : cloudData = cloudData ?? const SyncDataset();

  SyncDataset cloudData;
  int syncCallCount = 0;
  int deleteUserDataCallCount = 0;
  String? lastDeletedUid;
  bool shouldFailSync = false;

  @override
  Future<SyncSummary> syncAll(
    String uid,
    DatabaseService db, {
    DateTime? lastSyncedAt,
  }) async {
    syncCallCount++;
    if (shouldFailSync) {
      throw Exception('Simulasi jaringan putus');
    }

    final local = SyncDataset(
      projects: await db.getProjects(),
      tags: await db.getTags(),
      repeatingRules: await db.getRepeatingRules(),
      tasks: await db.getAllTasks(),
      notes: await db.getNotes(),
      templates: await db.getTemplates(),
    );

    final plan = CloudSyncMerger.merge(
      local: local,
      cloud: cloudData,
      lastSyncedAt: lastSyncedAt,
    );

    var downloaded = 0;
    for (final p in plan.toSaveLocally.projects) {
      await db.insertProject(p);
      downloaded++;
    }
    for (final t in plan.toSaveLocally.tags) {
      await db.insertTag(t);
      downloaded++;
    }
    for (final r in plan.toSaveLocally.repeatingRules) {
      await db.insertRepeatingRule(r);
      downloaded++;
    }
    for (final task in plan.toSaveLocally.tasks) {
      await db.insertTask(task);
      downloaded++;
    }
    for (final n in plan.toSaveLocally.notes) {
      await db.insertNote(n);
      downloaded++;
    }
    for (final tpl in plan.toSaveLocally.templates) {
      await db.insertTemplate(tpl);
      downloaded++;
    }

    cloudData = plan.merged;
    final uploaded = plan.toUploadToCloud.projects.length +
        plan.toUploadToCloud.tags.length +
        plan.toUploadToCloud.repeatingRules.length +
        plan.toUploadToCloud.tasks.length +
        plan.toUploadToCloud.notes.length +
        plan.toUploadToCloud.templates.length;

    return SyncSummary(
      uploadedCount: uploaded,
      downloadedCount: downloaded,
      syncedAt: DateTime(2026, 11, 19, 22, 0),
    );
  }

  @override
  Future<void> deleteAllUserData(String uid) async {
    deleteUserDataCallCount++;
    lastDeletedUid = uid;
    cloudData = const SyncDataset();
  }
}
