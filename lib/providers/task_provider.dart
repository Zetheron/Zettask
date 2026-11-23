import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/repeating_task_model.dart';
import '../models/task_model.dart';
import '../services/database_service.dart';
import '../services/home_widget_service.dart';
import '../services/notification_service.dart';

enum TaskFilter {
  all('Semua'),
  active('Aktif'),
  completed('Selesai');

  const TaskFilter(this.label);

  final String label;
}

enum TimelineViewMode {
  timeline('Timeline'),
  day('Harian');

  const TimelineViewMode(this.label);

  final String label;

  static TimelineViewMode fromStorage(String? value) {
    return switch (value) {
      'timeline' => TimelineViewMode.timeline,
      _ => TimelineViewMode.day,
    };
  }
}

enum RepeatingActionScope {
  single,
  thisAndFollowing,
}

class TaskProvider extends ChangeNotifier {
  TaskProvider({
    DatabaseService? databaseService,
    TaskNotificationService? notificationService,
    HomeWidgetSyncService? homeWidgetService,
    DateTime? initialDate,
    DateTime Function()? nowProvider,
  })  : _databaseService = databaseService ?? DatabaseService.instance,
        _notificationService =
            notificationService ?? NotificationService.instance,
        _homeWidgetService =
            homeWidgetService ?? AndroidHomeWidgetService.instance,
        _nowProvider = nowProvider ?? DateTime.now,
        _selectedDate =
            normalizeDate(initialDate ?? (nowProvider?.call() ?? DateTime.now()));

  static const String prefShowCompletedTasks = 'zettask_show_completed_tasks';
  static const String prefTimelineViewMode = 'zettask_timeline_view_mode';
  static const String prefFirstDayOfWeek = 'zettask_first_day_of_week';
  static const int timelineLookaheadDays = 6;
  static const int dateStripIndicatorWindowDays = 35;

  final DatabaseService _databaseService;
  final TaskNotificationService _notificationService;
  final HomeWidgetSyncService _homeWidgetService;
  final DateTime Function() _nowProvider;

  List<TaskModel> _tasks = [];
  List<TaskModel> _unplannedTasks = [];
  List<TaskModel> _overdueTasks = [];
  Set<String> _datesWithTasks = {};
  Map<String, List<TaskModel>> _timelineTasksByDate = {};
  List<RepeatingTaskRule> _repeatingRules = [];
  Map<int, RepeatingTaskStats> _repeatingStats = {};

  DateTime _selectedDate;
  TaskFilter _filter = TaskFilter.all;
  TaskPriority? _priorityFilter;
  bool _showCompletedTasks = true;
  TimelineViewMode _viewMode = TimelineViewMode.day;
  int _firstDayOfWeek = DateTime.monday;
  bool _isLoading = false;
  bool _prefsLoaded = false;
  String? _errorMessage;

  List<TaskModel> get tasks => List.unmodifiable(_tasks);
  List<TaskModel> get unplannedTasks => List.unmodifiable(_unplannedTasks);
  List<TaskModel> get overdueTasks => List.unmodifiable(_overdueTasks);
  Set<String> get datesWithTasks => Set.unmodifiable(_datesWithTasks);
  List<RepeatingTaskRule> get repeatingRules =>
      List.unmodifiable(_repeatingRules);

  DateTime get selectedDate => _selectedDate;
  DateTime get currentToday => normalizeDate(_nowProvider());
  TaskFilter get filter => _filter;
  TaskPriority? get priorityFilter => _priorityFilter;
  bool get showCompletedTasks => _showCompletedTasks;
  TimelineViewMode get viewMode => _viewMode;
  int get firstDayOfWeek => _firstDayOfWeek;
  String get firstDayOfWeekLabel =>
      _firstDayOfWeek == DateTime.sunday ? 'Minggu' : 'Senin';
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  int get totalTaskCount => _tasks.length;
  int get completedTaskCount =>
      _tasks.where((task) => task.isCompleted && !task.isCancelled).length;
  int get cancelledTaskCount =>
      _tasks.where((task) => task.isCancelled).length;
  int get activeTaskCount =>
      _tasks.where((task) => !task.isCompleted && !task.isCancelled).length;
  int get overdueCount => _overdueTasks.length;
  int get unplannedCount => _unplannedTasks
      .where((task) => !task.isCompleted && !task.isCancelled)
      .length;
  int get activeRepeatingRuleCount =>
      _repeatingRules.where((rule) => rule.isActive).length;

  RepeatingTaskRule? findRepeatingRule(int? ruleId) {
    if (ruleId == null) return null;
    for (final rule in _repeatingRules) {
      if (rule.id == ruleId) return rule;
    }
    return null;
  }

  RepeatingTaskStats statsForRule(int ruleId) {
    return _repeatingStats[ruleId] ?? RepeatingTaskStats.empty();
  }

  List<TaskModel> get visibleUnplannedTasks {
    return _unplannedTasks
        .where(
          (task) =>
              _showCompletedTasks || (!task.isCompleted && !task.isCancelled),
        )
        .toList();
  }

  List<TaskModel> get allDayTasks {
    final result = _matchingFilteredTasks(_tasks)
        .where((task) => !task.hasStartTime)
        .toList();
    result.sort(_compareAllDayTasks);
    return result;
  }

  List<TaskModel> get scheduledTasks {
    final result = _matchingFilteredTasks(_tasks)
        .where((task) => task.hasStartTime)
        .toList();
    result.sort(_compareScheduledTasks);
    return result;
  }

  List<TaskModel> get filteredTasks => [...allDayTasks, ...scheduledTasks];

  List<TaskModel> allDayTasksForDate(DateTime date) {
    final source = _tasksForDateBucket(date);
    final result = _matchingFilteredTasks(source)
        .where((task) => !task.hasStartTime)
        .toList();
    result.sort(_compareAllDayTasks);
    return result;
  }

  List<TaskModel> scheduledTasksForDate(DateTime date) {
    final source = _tasksForDateBucket(date);
    final result = _matchingFilteredTasks(source)
        .where((task) => task.hasStartTime)
        .toList();
    result.sort(_compareScheduledTasks);
    return result;
  }

  List<DateTime> get timelineDates {
    final dates = <DateTime>[_selectedDate];
    for (var offset = 1; offset <= timelineLookaheadDays; offset++) {
      final candidate = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day + offset,
      );
      final key = TaskModel.formatDateKey(candidate);
      final dayTasks = _timelineTasksByDate[key] ?? const [];
      if (_matchingFilteredTasks(dayTasks).isNotEmpty) {
        dates.add(candidate);
      }
    }
    return dates;
  }

  bool hasTasksOnDate(DateTime date) {
    return _datesWithTasks.contains(TaskModel.formatDateKey(date));
  }

  List<TaskModel> _tasksForDateBucket(DateTime date) {
    if (isSameDay(date, _selectedDate)) {
      return _tasks;
    }
    return _timelineTasksByDate[TaskModel.formatDateKey(date)] ?? const [];
  }

  Iterable<TaskModel> _matchingFilteredTasks(List<TaskModel> source) {
    return source.where((task) {
      if (!_showCompletedTasks && (task.isCompleted || task.isCancelled)) {
        return false;
      }

      final matchesStatus = switch (_filter) {
        TaskFilter.all => true,
        TaskFilter.active => !task.isCompleted && !task.isCancelled,
        TaskFilter.completed => task.isCompleted && !task.isCancelled,
      };

      final matchesPriority =
          _priorityFilter == null || task.priority == _priorityFilter;

      return matchesStatus && matchesPriority;
    });
  }

  bool get isSelectedDateToday => isSameDay(_selectedDate, _nowProvider());

  static DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static int _compareAllDayTasks(TaskModel a, TaskModel b) {
    final priorityCompare = b.priority.value.compareTo(a.priority.value);
    if (priorityCompare != 0) return priorityCompare;
    return (a.id ?? 0).compareTo(b.id ?? 0);
  }

  static int _compareScheduledTasks(TaskModel a, TaskModel b) {
    final timeCompare =
        (a.startTime ?? '').trim().compareTo((b.startTime ?? '').trim());
    if (timeCompare != 0) return timeCompare;
    final priorityCompare = b.priority.value.compareTo(a.priority.value);
    if (priorityCompare != 0) return priorityCompare;
    return (a.id ?? 0).compareTo(b.id ?? 0);
  }

  Future<void> initialize() async {
    await _loadPreferences();
    await loadTasksForSelectedDate();
  }

  Future<void> _loadPreferences() async {
    if (_prefsLoaded) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      _showCompletedTasks = prefs.getBool(prefShowCompletedTasks) ?? true;
      _viewMode = TimelineViewMode.fromStorage(
        prefs.getString(prefTimelineViewMode),
      );
      final storedFirstDay = prefs.getInt(prefFirstDayOfWeek);
      _firstDayOfWeek = storedFirstDay == DateTime.sunday
          ? DateTime.sunday
          : DateTime.monday;
    } catch (e) {
      debugPrint('TaskProvider gagal membaca preferensi: $e');
    }
    _prefsLoaded = true;
  }

  Future<void> setFirstDayOfWeek(int weekday) async {
    final normalized =
        weekday == DateTime.sunday ? DateTime.sunday : DateTime.monday;
    if (_firstDayOfWeek == normalized) return;
    _firstDayOfWeek = normalized;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(prefFirstDayOfWeek, normalized);
    } catch (e) {
      debugPrint('TaskProvider gagal menyimpan firstDayOfWeek: $e');
    }
  }

  Future<void> setShowCompletedTasks(bool value) async {
    if (_showCompletedTasks == value) return;
    _showCompletedTasks = value;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(prefShowCompletedTasks, value);
    } catch (e) {
      debugPrint('TaskProvider gagal menyimpan showCompletedTasks: $e');
    }
  }

  Future<void> setViewMode(TimelineViewMode mode) async {
    if (_viewMode == mode) return;
    _viewMode = mode;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefTimelineViewMode, mode.name);
    } catch (e) {
      debugPrint('TaskProvider gagal menyimpan viewMode: $e');
    }
  }

  Future<bool> requestNotificationPermission() {
    return _notificationService.requestPermissions();
  }

  Future<void> _syncReminder(TaskModel task) async {
    final taskId = task.id;
    if (taskId == null) return;

    if (task.shouldScheduleReminder) {
      await _notificationService.scheduleTaskReminder(task);
    } else {
      await _notificationService.cancelTaskReminder(taskId);
    }
  }

  Future<void> loadTasksForSelectedDate({bool showLoading = true}) async {
    if (showLoading) {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
    }

    try {
      await _refreshAllTaskCollections();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Gagal memuat tugas: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _materializeRepeatingTasksForRange(
    DateTime start,
    DateTime end,
    List<RepeatingTaskRule> activeRules,
  ) async {
    if (activeRules.isEmpty) return;

    final startDay = normalizeDate(start);
    final endDay = normalizeDate(end);
    final totalDays = endDay.difference(startDay).inDays;
    if (totalDays < 0) return;

    for (var offset = 0; offset <= totalDays; offset++) {
      final day = DateTime(startDay.year, startDay.month, startDay.day + offset);
      for (final rule in activeRules) {
        final ruleId = rule.id;
        if (ruleId == null || !rule.matchesDate(day)) continue;

        final exists = await _databaseService.hasTaskForRepeatingRuleOnDate(
          ruleId,
          day,
        );
        if (exists) continue;

        final instance = rule.buildTaskInstance(day);
        final insertedId = await _databaseService.insertTask(instance);
        final saved = instance.copyWith(id: insertedId);
        if (saved.shouldScheduleReminder) {
          await _notificationService.scheduleTaskReminder(saved);
        }
      }
    }
  }

  Future<void> _refreshAllTaskCollections() async {
    final today = normalizeDate(_nowProvider());
    final indicatorStart = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day - dateStripIndicatorWindowDays,
    );
    final indicatorEnd = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day + dateStripIndicatorWindowDays,
    );
    final timelineEnd = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day + timelineLookaheadDays,
    );

    final allRules = await _databaseService.getRepeatingRules();
    final activeRules = allRules.where((r) => r.isActive).toList();

    await _materializeRepeatingTasksForRange(
      _selectedDate,
      timelineEnd,
      activeRules,
    );

    final results = await Future.wait<Object>([
      _databaseService.getTasksByDate(_selectedDate),
      _databaseService.getUnplannedTasks(),
      _databaseService.getOverdueTasks(today),
      _databaseService.getDatesWithTasks(indicatorStart, indicatorEnd),
      _databaseService.getTasksInDateRange(_selectedDate, timelineEnd),
    ]);

    _repeatingRules = allRules;
    _tasks = results[0] as List<TaskModel>;
    _unplannedTasks = results[1] as List<TaskModel>;
    _overdueTasks = results[2] as List<TaskModel>;

    // Union stored task dates with active repeating rule dates so DateStrip dots stay accurate without bloating SQLite.
    final dateIndicators = Set<String>.from(results[3] as Set<String>);
    if (activeRules.isNotEmpty) {
      final spanDays = indicatorEnd.difference(indicatorStart).inDays;
      for (var offset = 0; offset <= spanDays; offset++) {
        final day = DateTime(
          indicatorStart.year,
          indicatorStart.month,
          indicatorStart.day + offset,
        );
        final key = TaskModel.formatDateKey(day);
        if (dateIndicators.contains(key)) continue;
        if (activeRules.any((rule) => rule.matchesDate(day))) {
          dateIndicators.add(key);
        }
      }
    }
    _datesWithTasks = dateIndicators;

    final rangeTasks = results[4] as List<TaskModel>;
    final grouped = <String, List<TaskModel>>{};
    for (final task in rangeTasks) {
      final taskDate = task.date;
      if (taskDate == null) continue;
      final key = TaskModel.formatDateKey(taskDate);
      grouped.putIfAbsent(key, () => []).add(task);
    }
    _timelineTasksByDate = grouped;

    await _refreshRepeatingStats(allRules, today);
    await _syncHomeWidget(today);
  }

  Future<void> _syncHomeWidget(DateTime today) async {
    try {
      final todayTasks = isSameDay(_selectedDate, today)
          ? _tasks
          : await _databaseService.getTasksByDate(today);
      await _homeWidgetService.updateTodayTasks(todayTasks);
    } catch (e) {
      debugPrint('TaskProvider._syncHomeWidget gagal: $e');
    }
  }

  Future<void> _refreshRepeatingStats(
    List<RepeatingTaskRule> rules,
    DateTime today,
  ) async {
    final start30 = DateTime(today.year, today.month, today.day - 29);
    final statsMap = <int, RepeatingTaskStats>{};

    for (final rule in rules) {
      final ruleId = rule.id;
      if (ruleId == null) continue;

      final allTime = await _databaseService.getCompletedCountForRule(ruleId);
      final completedDates30 =
          await _databaseService.getCompletedDatesForRuleInRange(
        ruleId,
        start30,
        today,
      );

      final last30 = List<bool>.generate(30, (index) {
        final day = DateTime(start30.year, start30.month, start30.day + index);
        return completedDates30.contains(TaskModel.formatDateKey(day));
      });

      statsMap[ruleId] = RepeatingTaskStats(
        allTimeCompleted: allTime,
        last30DaysStatus: last30,
      );
    }

    _repeatingStats = statsMap;
  }

  Future<void> selectDate(DateTime date) async {
    final normalized = normalizeDate(date);
    if (normalized == _selectedDate && _tasks.isNotEmpty) {
      return;
    }
    _selectedDate = normalized;
    await loadTasksForSelectedDate();
  }

  Future<void> goToToday() async {
    await selectDate(_nowProvider());
  }

  Future<void> previousDay() async {
    await selectDate(_selectedDate.subtract(const Duration(days: 1)));
  }

  Future<void> nextDay() async {
    await selectDate(_selectedDate.add(const Duration(days: 1)));
  }

  void setFilter(TaskFilter newFilter) {
    if (_filter == newFilter) return;
    _filter = newFilter;
    notifyListeners();
  }

  void setPriorityFilter(TaskPriority? priority) {
    if (_priorityFilter == priority) return;
    _priorityFilter = priority;
    notifyListeners();
  }

  Future<bool> addTask(TaskModel task) async {
    try {
      _errorMessage = null;
      final insertedId = await _databaseService.insertTask(task);
      final savedTask = task.copyWith(id: insertedId);
      if (savedTask.shouldScheduleReminder) {
        await _notificationService.scheduleTaskReminder(savedTask);
      }
      await loadTasksForSelectedDate(showLoading: false);
      return true;
    } catch (e) {
      _errorMessage = 'Gagal menambahkan tugas: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> addRepeatingTask(RepeatingTaskRule rule) async {
    try {
      _errorMessage = null;
      final ruleId = await _databaseService.insertRepeatingRule(rule);
      final savedRule = rule.copyWith(id: ruleId);

      // Materialize startDate immediately if it matches so reminders schedule right away.
      if (savedRule.matchesDate(savedRule.startDate)) {
        final exists = await _databaseService.hasTaskForRepeatingRuleOnDate(
          ruleId,
          savedRule.startDate,
        );
        if (!exists) {
          final firstInstance = savedRule.buildTaskInstance(savedRule.startDate);
          final taskId = await _databaseService.insertTask(firstInstance);
          final savedTask = firstInstance.copyWith(id: taskId);
          if (savedTask.shouldScheduleReminder) {
            await _notificationService.scheduleTaskReminder(savedTask);
          }
        }
      }

      await loadTasksForSelectedDate(showLoading: false);
      return true;
    } catch (e) {
      _errorMessage = 'Gagal menambahkan tugas berulang: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTask(TaskModel task) async {
    try {
      _errorMessage = null;
      await _databaseService.updateTask(task);
      await _syncReminder(task);
      await loadTasksForSelectedDate(showLoading: false);
      return true;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui tugas: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateRepeatingTask(
    TaskModel updatedTask, {
    required RepeatingActionScope scope,
    DateTime? originalDate,
    RepeatConfig? repeatConfig,
  }) async {
    final ruleId = updatedTask.repeatingRuleId;
    if (ruleId == null || scope == RepeatingActionScope.single) {
      try {
        _errorMessage = null;
        if (ruleId != null &&
            originalDate != null &&
            (updatedTask.date == null ||
                !isSameDay(originalDate, updatedTask.date!))) {
          await _addExcludedDate(ruleId, originalDate);
        }
        await _databaseService.updateTask(updatedTask);
        await _syncReminder(updatedTask);
        await loadTasksForSelectedDate(showLoading: false);
        return true;
      } catch (e) {
        _errorMessage = 'Gagal memperbarui tugas: $e';
        notifyListeners();
        return false;
      }
    }

    try {
      _errorMessage = null;
      final existingRule = await _databaseService.getRepeatingRuleById(ruleId);
      if (existingRule == null) {
        return await updateTask(updatedTask);
      }

      final templateChecklist = updatedTask.checklistItems
          .where((item) => !item.isCancelled)
          .map((item) => ChecklistItem(title: item.title, isDone: false))
          .toList();

      final newRule = existingRule.copyWith(
        title: updatedTask.title,
        description: updatedTask.description,
        startTime: updatedTask.startTime,
        clearStartTime: !updatedTask.hasStartTime,
        priority: updatedTask.priority,
        colorHex: updatedTask.colorHex,
        checklistItems: templateChecklist,
        reminderMinutesBefore: updatedTask.reminderMinutesBefore,
        clearReminder: updatedTask.reminderMinutesBefore == null,
        frequency: repeatConfig?.frequency ?? existingRule.frequency,
        weekdays: repeatConfig?.weekdays ?? existingRule.weekdays,
        projectId: updatedTask.projectId,
        clearProject: updatedTask.projectId == null,
        tagId: updatedTask.tagId,
        clearTag: updatedTask.tagId == null,
      );
      await _databaseService.updateRepeatingRule(newRule);

      final pivotDate = normalizeDate(
        originalDate ?? updatedTask.date ?? _nowProvider(),
      );
      await _syncIncompleteFutureTasksWithRule(
        newRule,
        fromDate: pivotDate,
        editedTask: updatedTask,
      );

      await loadTasksForSelectedDate(showLoading: false);
      return true;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui tugas berulang: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateRepeatingRuleFromManager(
    RepeatingTaskRule updatedRule,
  ) async {
    final ruleId = updatedRule.id;
    if (ruleId == null) return false;

    try {
      _errorMessage = null;
      await _databaseService.updateRepeatingRule(updatedRule);
      await _syncIncompleteFutureTasksWithRule(
        updatedRule,
        fromDate: normalizeDate(_nowProvider()),
      );
      await loadTasksForSelectedDate(showLoading: false);
      return true;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui aturan berulang: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> _syncIncompleteFutureTasksWithRule(
    RepeatingTaskRule rule, {
    required DateTime fromDate,
    TaskModel? editedTask,
  }) async {
    final ruleId = rule.id;
    if (ruleId == null) return;

    final futureTasks = await _databaseService.getIncompleteFutureTasksForRule(
      ruleId,
      fromDate,
    );

    for (final existing in futureTasks) {
      final existingDate = existing.date;
      if (existingDate == null) continue;

      if (!rule.matchesDate(existingDate)) {
        if (existing.id != null) {
          await _notificationService.cancelTaskReminder(existing.id!);
          await _databaseService.deleteTask(existing.id!);
        }
        continue;
      }

      final checklistToUse = (editedTask != null && existing.id == editedTask.id)
          ? editedTask.checklistItems
          : rule.checklistItems
              .map((item) => ChecklistItem(title: item.title, isDone: false))
              .toList();

      final synced = existing.copyWith(
        title: rule.title,
        description: rule.description,
        startTime: rule.startTime,
        clearStartTime: !rule.hasStartTime,
        priority: rule.priority,
        colorHex: rule.colorHex,
        checklistItems: checklistToUse,
        reminderMinutesBefore: rule.reminderMinutesBefore,
        clearReminder: rule.reminderMinutesBefore == null,
        projectId: rule.projectId,
        clearProject: rule.projectId == null,
        tagId: rule.tagId,
        clearTag: rule.tagId == null,
      );

      await _databaseService.updateTask(synced);
      await _syncReminder(synced);
    }
  }

  Future<void> deleteRepeatingTask(
    TaskModel task, {
    required RepeatingActionScope scope,
  }) async {
    final taskId = task.id;
    final ruleId = task.repeatingRuleId;
    if (taskId == null) return;

    if (ruleId == null || scope == RepeatingActionScope.single) {
      final previousTasks = List<TaskModel>.from(_tasks);
      _removeTaskFromMemory(taskId);
      notifyListeners();

      try {
        if (ruleId != null && task.date != null) {
          await _addExcludedDate(ruleId, task.date!);
        }
        await _databaseService.deleteTask(taskId);
        await _notificationService.cancelTaskReminder(taskId);
        await loadTasksForSelectedDate(showLoading: false);
      } catch (e) {
        _tasks = previousTasks;
        _errorMessage = 'Gagal menghapus tugas: $e';
        notifyListeners();
      }
      return;
    }

    try {
      _errorMessage = null;
      final pivotDate = normalizeDate(task.date ?? _nowProvider());
      final futureTasks = await _databaseService.getIncompleteFutureTasksForRule(
        ruleId,
        pivotDate,
      );
      for (final futureTask in futureTasks) {
        if (futureTask.id != null) {
          await _notificationService.cancelTaskReminder(futureTask.id!);
        }
      }
      await _databaseService.deleteIncompleteFutureTasksForRule(
        ruleId,
        pivotDate,
      );
      await _databaseService.deleteRepeatingRule(ruleId);
      await loadTasksForSelectedDate(showLoading: false);
    } catch (e) {
      _errorMessage = 'Gagal menghapus tugas berulang: $e';
      notifyListeners();
    }
  }

  Future<void> deleteRepeatingRuleFromManager(int ruleId) async {
    try {
      _errorMessage = null;
      final today = normalizeDate(_nowProvider());
      final futureTasks = await _databaseService.getIncompleteFutureTasksForRule(
        ruleId,
        today,
      );
      for (final futureTask in futureTasks) {
        if (futureTask.id != null) {
          await _notificationService.cancelTaskReminder(futureTask.id!);
        }
      }
      await _databaseService.deleteIncompleteFutureTasksForRule(ruleId, today);
      await _databaseService.deleteRepeatingRule(ruleId);
      await loadTasksForSelectedDate(showLoading: false);
    } catch (e) {
      _errorMessage = 'Gagal menghapus aturan berulang: $e';
      notifyListeners();
    }
  }

  Future<void> _addExcludedDate(int ruleId, DateTime date) async {
    final rule = await _databaseService.getRepeatingRuleById(ruleId);
    if (rule == null) return;
    final updatedExcluded = Set<String>.from(rule.excludedDates)
      ..add(TaskModel.formatDateKey(date));
    await _databaseService.updateRepeatingRule(
      rule.copyWith(excludedDates: updatedExcluded),
    );
  }

  Future<void> _removeExcludedDate(int ruleId, DateTime date) async {
    final rule = await _databaseService.getRepeatingRuleById(ruleId);
    if (rule == null) return;
    final key = TaskModel.formatDateKey(date);
    if (!rule.excludedDates.contains(key)) return;
    final updatedExcluded = Set<String>.from(rule.excludedDates)..remove(key);
    await _databaseService.updateRepeatingRule(
      rule.copyWith(excludedDates: updatedExcluded),
    );
  }

  Future<bool> moveTaskToDate(TaskModel task, DateTime targetDate) async {
    final updated = task.copyWith(date: normalizeDate(targetDate));
    return updateRepeatingTask(
      updated,
      scope: RepeatingActionScope.single,
      originalDate: task.date,
    );
  }

  Future<void> moveAllOverdueToToday() async {
    if (_overdueTasks.isEmpty) return;
    final today = normalizeDate(_nowProvider());
    try {
      _errorMessage = null;
      for (final task in List<TaskModel>.from(_overdueTasks)) {
        if (task.repeatingRuleId != null && task.date != null) {
          await _addExcludedDate(task.repeatingRuleId!, task.date!);
        }
        final updated = task.copyWith(date: today);
        await _databaseService.updateTask(updated);
        await _syncReminder(updated);
      }
      await loadTasksForSelectedDate(showLoading: false);
    } catch (e) {
      _errorMessage = 'Gagal memindahkan tugas terlambat: $e';
      notifyListeners();
    }
  }

  Future<List<TaskModel>> searchTasks(String query) async {
    try {
      return await _databaseService.searchTasks(query);
    } catch (e) {
      debugPrint('TaskProvider.searchTasks gagal: $e');
      return const [];
    }
  }

  Future<void> toggleTaskComplete(TaskModel task) async {
    final taskId = task.id;
    if (taskId == null) return;

    final previousTasks = List<TaskModel>.from(_tasks);
    final previousUnplanned = List<TaskModel>.from(_unplannedTasks);
    final previousOverdue = List<TaskModel>.from(_overdueTasks);

    // Opsi A: tapping a completed or cancelled circle restores it to Active; tapping an active circle marks it Done.
    final nextCompleted = task.isCancelled ? false : !task.isCompleted;
    final completedAt = nextCompleted ? _nowProvider() : null;
    final updatedTask = task.copyWith(
      isCompleted: nextCompleted,
      isCancelled: false,
      completedAt: completedAt,
      clearCompletedAt: !nextCompleted,
    );

    // Update in-memory first so checkboxes and swipe actions respond without a loading flash.
    _tasks = _tasks
        .map((item) => item.id == taskId ? updatedTask : item)
        .toList();
    _unplannedTasks = _unplannedTasks
        .map((item) => item.id == taskId ? updatedTask : item)
        .toList();
    _overdueTasks = nextCompleted
        ? _overdueTasks.where((item) => item.id != taskId).toList()
        : _overdueTasks;
    _replaceInTimelineMap(updatedTask);
    _errorMessage = null;
    notifyListeners();

    try {
      if (task.isCancelled) {
        await _databaseService.updateTask(updatedTask);
      } else {
        await _databaseService.toggleTaskComplete(
          taskId,
          nextCompleted,
          completedAt: completedAt,
        );
      }
      if (nextCompleted) {
        await _notificationService.cancelTaskReminder(taskId);
      } else {
        await _syncReminder(updatedTask);
      }
      await loadTasksForSelectedDate(showLoading: false);
    } catch (e) {
      _tasks = previousTasks;
      _unplannedTasks = previousUnplanned;
      _overdueTasks = previousOverdue;
      _errorMessage = 'Gagal mengubah status tugas: $e';
      notifyListeners();
    }
  }

  Future<bool> toggleTaskCancelled(TaskModel task) async {
    final taskId = task.id;
    if (taskId == null) return task.isCancelled;

    final previousTasks = List<TaskModel>.from(_tasks);
    final previousUnplanned = List<TaskModel>.from(_unplannedTasks);
    final previousOverdue = List<TaskModel>.from(_overdueTasks);

    final nextCancelled = !task.isCancelled;
    final updatedTask = task.copyWith(
      isCompleted: false,
      isCancelled: nextCancelled,
      clearCompletedAt: true,
    );

    _tasks = _tasks
        .map((item) => item.id == taskId ? updatedTask : item)
        .toList();
    _unplannedTasks = _unplannedTasks
        .map((item) => item.id == taskId ? updatedTask : item)
        .toList();
    _overdueTasks = nextCancelled
        ? _overdueTasks.where((item) => item.id != taskId).toList()
        : _overdueTasks;
    _replaceInTimelineMap(updatedTask);
    _errorMessage = null;
    notifyListeners();

    try {
      await _databaseService.updateTask(updatedTask);
      if (nextCancelled) {
        await _notificationService.cancelTaskReminder(taskId);
      } else {
        await _syncReminder(updatedTask);
      }
      await loadTasksForSelectedDate(showLoading: false);
      return nextCancelled;
    } catch (e) {
      _tasks = previousTasks;
      _unplannedTasks = previousUnplanned;
      _overdueTasks = previousOverdue;
      _errorMessage = 'Gagal mengubah status batal tugas: $e';
      notifyListeners();
      return task.isCancelled;
    }
  }

  Future<TaskModel?> findTaskById(int taskId) async {
    for (final list in [
      _tasks,
      _unplannedTasks,
      _overdueTasks,
      ..._timelineTasksByDate.values,
    ]) {
      for (final item in list) {
        if (item.id == taskId) return item;
      }
    }
    try {
      final all = await _databaseService.getAllTasks();
      for (final item in all) {
        if (item.id == taskId) return item;
      }
    } catch (e) {
      debugPrint('TaskProvider.findTaskById gagal: $e');
    }
    return null;
  }

  TaskModel _resolveLatestInMemory(TaskModel fallback) {
    final taskId = fallback.id;
    if (taskId == null) return fallback;
    for (final list in [
      _tasks,
      _unplannedTasks,
      _overdueTasks,
      ..._timelineTasksByDate.values,
    ]) {
      for (final item in list) {
        if (item.id == taskId) return item;
      }
    }
    return fallback;
  }

  Future<void> toggleChecklistItem(TaskModel task, int itemIndex) async {
    final currentTask = _resolveLatestInMemory(task);
    final taskId = currentTask.id;
    if (taskId == null ||
        itemIndex < 0 ||
        itemIndex >= currentTask.checklistItems.length) {
      return;
    }

    final previousTasks = List<TaskModel>.from(_tasks);
    final previousUnplanned = List<TaskModel>.from(_unplannedTasks);
    final updatedItems = List<ChecklistItem>.from(currentTask.checklistItems);
    final currentItem = updatedItems[itemIndex];
    updatedItems[itemIndex] = currentItem.isCancelled
        ? currentItem.copyWith(isDone: false, isCancelled: false)
        : currentItem.copyWith(isDone: !currentItem.isDone, isCancelled: false);
    final updatedTask = currentTask.copyWith(checklistItems: updatedItems);

    _tasks = _tasks
        .map((item) => item.id == taskId ? updatedTask : item)
        .toList();
    _unplannedTasks = _unplannedTasks
        .map((item) => item.id == taskId ? updatedTask : item)
        .toList();
    _replaceInTimelineMap(updatedTask);
    _errorMessage = null;
    notifyListeners();

    try {
      await _databaseService.updateTask(updatedTask);
      await _syncReminder(updatedTask);
    } catch (e) {
      _tasks = previousTasks;
      _unplannedTasks = previousUnplanned;
      _errorMessage = 'Gagal memperbarui sub-tugas: $e';
      notifyListeners();
    }
  }

  Future<bool> setChecklistItemCancelled(
    TaskModel task,
    int itemIndex, {
    required bool isCancelled,
  }) async {
    final currentTask = _resolveLatestInMemory(task);
    final taskId = currentTask.id;
    if (taskId == null ||
        itemIndex < 0 ||
        itemIndex >= currentTask.checklistItems.length) {
      return false;
    }

    final previousTasks = List<TaskModel>.from(_tasks);
    final previousUnplanned = List<TaskModel>.from(_unplannedTasks);
    final updatedItems = List<ChecklistItem>.from(currentTask.checklistItems);
    final currentItem = updatedItems[itemIndex];
    if (currentItem.isCancelled == isCancelled) return false;

    updatedItems[itemIndex] = currentItem.copyWith(
      isDone: false,
      isCancelled: isCancelled,
    );
    final updatedTask = currentTask.copyWith(checklistItems: updatedItems);

    _tasks = _tasks
        .map((item) => item.id == taskId ? updatedTask : item)
        .toList();
    _unplannedTasks = _unplannedTasks
        .map((item) => item.id == taskId ? updatedTask : item)
        .toList();
    _replaceInTimelineMap(updatedTask);
    _errorMessage = null;
    notifyListeners();

    try {
      await _databaseService.updateTask(updatedTask);
      await _syncReminder(updatedTask);
      return true;
    } catch (e) {
      _tasks = previousTasks;
      _unplannedTasks = previousUnplanned;
      _errorMessage = 'Gagal mengubah status batal sub-tugas: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelChecklistItem(TaskModel task, int itemIndex) {
    return setChecklistItemCancelled(task, itemIndex, isCancelled: true);
  }

  Future<bool> restoreChecklistItem(TaskModel task, int itemIndex) {
    return setChecklistItemCancelled(task, itemIndex, isCancelled: false);
  }

  Future<void> deleteTask(int id) async {
    final previousTasks = List<TaskModel>.from(_tasks);
    final previousUnplanned = List<TaskModel>.from(_unplannedTasks);
    final previousOverdue = List<TaskModel>.from(_overdueTasks);

    _removeTaskFromMemory(id);
    _errorMessage = null;
    notifyListeners();

    try {
      await _databaseService.deleteTask(id);
      await _notificationService.cancelTaskReminder(id);
      await loadTasksForSelectedDate(showLoading: false);
    } catch (e) {
      _tasks = previousTasks;
      _unplannedTasks = previousUnplanned;
      _overdueTasks = previousOverdue;
      _errorMessage = 'Gagal menghapus tugas: $e';
      notifyListeners();
    }
  }

  Future<void> restoreTask(TaskModel task) async {
    try {
      _errorMessage = null;
      if (task.repeatingRuleId != null && task.date != null) {
        await _removeExcludedDate(task.repeatingRuleId!, task.date!);
      }
      final restoredId = await _databaseService.insertTask(task);
      await _syncReminder(task.copyWith(id: restoredId));
      await loadTasksForSelectedDate(showLoading: false);
    } catch (e) {
      _errorMessage = 'Gagal mengembalikan tugas: $e';
      notifyListeners();
    }
  }

  void _removeTaskFromMemory(int id) {
    _tasks = _tasks.where((item) => item.id != id).toList();
    _unplannedTasks = _unplannedTasks.where((item) => item.id != id).toList();
    _overdueTasks = _overdueTasks.where((item) => item.id != id).toList();
    for (final key in _timelineTasksByDate.keys) {
      _timelineTasksByDate[key] =
          _timelineTasksByDate[key]!.where((item) => item.id != id).toList();
    }
  }

  void _replaceInTimelineMap(TaskModel updatedTask) {
    final taskDate = updatedTask.date;
    if (taskDate == null) return;
    final key = TaskModel.formatDateKey(taskDate);
    final bucket = _timelineTasksByDate[key];
    if (bucket == null) return;
    _timelineTasksByDate[key] = bucket
        .map((item) => item.id == updatedTask.id ? updatedTask : item)
        .toList();
  }
}
