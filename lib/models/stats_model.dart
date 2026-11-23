import 'project_model.dart';
import 'repeating_task_model.dart';
import 'tag_model.dart';
import 'task_model.dart';

class DailyCompletionStat {
  const DailyCompletionStat({
    required this.date,
    this.completedTasks = 0,
    this.completedChecklists = 0,
  });

  final DateTime date;
  final int completedTasks;
  final int completedChecklists;
}

class ProjectStatBreakdown {
  const ProjectStatBreakdown({
    required this.project,
    required this.completedCount,
    required this.totalCount,
  });

  final ProjectModel project;
  final int completedCount;
  final int totalCount;

  double get ratio => totalCount == 0 ? 0.0 : completedCount / totalCount;

  int get percentage => (ratio * 100).round().clamp(0, 100);
}

class TagStatBreakdown {
  const TagStatBreakdown({
    required this.tag,
    required this.completedCount,
    required this.totalCount,
  });

  final TagModel tag;
  final int completedCount;
  final int totalCount;

  double get ratio => totalCount == 0 ? 0.0 : completedCount / totalCount;

  int get percentage => (ratio * 100).round().clamp(0, 100);
}

class HabitStatItem {
  const HabitStatItem({
    required this.rule,
    required this.completedLast30Days,
    required this.scheduledLast30Days,
    required this.last30DaysStatus,
  });

  final RepeatingTaskRule rule;
  final int completedLast30Days;
  final int scheduledLast30Days;
  final List<bool> last30DaysStatus;

  double get consistencyRatio => scheduledLast30Days == 0
      ? 0.0
      : (completedLast30Days / scheduledLast30Days).clamp(0.0, 1.0);

  int get consistencyPercentage =>
      (consistencyRatio * 100).round().clamp(0, 100);
}

class WorkspaceStats {
  const WorkspaceStats({
    required this.last7Days,
    required this.totalTasks7Days,
    required this.totalChecklists7Days,
    this.last30Days = const [],
    this.totalTasks30Days = 0,
    this.totalChecklists30Days = 0,
    required this.completedToday,
    required this.allTimeCompletedTasks,
    required this.totalTasks,
    required this.completionRate,
    required this.breakdownByPriority,
    required this.breakdownByProject,
    this.breakdownByTag = const [],
    this.habitStats = const [],
  });

  final List<DailyCompletionStat> last7Days;
  final int totalTasks7Days;
  final int totalChecklists7Days;
  final List<DailyCompletionStat> last30Days;
  final int totalTasks30Days;
  final int totalChecklists30Days;
  final int completedToday;
  final int allTimeCompletedTasks;
  final int totalTasks;
  final double completionRate;
  final Map<TaskPriority, int> breakdownByPriority;
  final List<ProjectStatBreakdown> breakdownByProject;
  final List<TagStatBreakdown> breakdownByTag;
  final List<HabitStatItem> habitStats;

  int get completionPercentage => (completionRate * 100).round().clamp(0, 100);

  factory WorkspaceStats.empty({DateTime? today}) {
    final base = today ?? DateTime.now();
    final normalizedToday = DateTime(base.year, base.month, base.day);
    final start30 = DateTime(
      normalizedToday.year,
      normalizedToday.month,
      normalizedToday.day - 29,
    );
    final days30 = List<DailyCompletionStat>.generate(
      30,
      (i) => DailyCompletionStat(
        date: DateTime(start30.year, start30.month, start30.day + i),
      ),
    );
    return WorkspaceStats(
      last7Days: List.unmodifiable(days30.sublist(23)),
      totalTasks7Days: 0,
      totalChecklists7Days: 0,
      last30Days: List.unmodifiable(days30),
      totalTasks30Days: 0,
      totalChecklists30Days: 0,
      completedToday: 0,
      allTimeCompletedTasks: 0,
      totalTasks: 0,
      completionRate: 0.0,
      breakdownByPriority: const {
        TaskPriority.high: 0,
        TaskPriority.medium: 0,
        TaskPriority.low: 0,
      },
      breakdownByProject: const [],
      breakdownByTag: const [],
      habitStats: const [],
    );
  }

  factory WorkspaceStats.compute({
    required List<TaskModel> tasks,
    required List<ProjectModel> projects,
    List<TagModel> tags = const [],
    List<RepeatingTaskRule> repeatingRules = const [],
    required DateTime today,
  }) {
    final normalizedToday = DateTime(today.year, today.month, today.day);
    final start30 = DateTime(
      normalizedToday.year,
      normalizedToday.month,
      normalizedToday.day - 29,
    );

    final dayKeys30 = <String>[];
    final dayDates30 = <DateTime>[];
    final taskCountsByDay = <String, int>{};
    final checklistCountsByDay = <String, int>{};

    for (var i = 0; i < 30; i++) {
      final day = DateTime(start30.year, start30.month, start30.day + i);
      final key = TaskModel.formatDateKey(day);
      dayDates30.add(day);
      dayKeys30.add(key);
      taskCountsByDay[key] = 0;
      checklistCountsByDay[key] = 0;
    }

    var allTimeCompleted = 0;
    final priorityCounts = <TaskPriority, int>{
      TaskPriority.high: 0,
      TaskPriority.medium: 0,
      TaskPriority.low: 0,
    };
    final projectCompleted = <int, int>{};
    final projectTotals = <int, int>{};
    final tagCompleted = <int, int>{};
    final tagTotals = <int, int>{};
    final completedDatesByRule = <int, Set<String>>{};

    var activeTasksCount = 0;
    for (final task in tasks) {
      if (task.isCancelled) continue;
      activeTasksCount++;
      if (task.projectId != null) {
        projectTotals[task.projectId!] =
            (projectTotals[task.projectId!] ?? 0) + 1;
      }
      if (task.tagId != null) {
        tagTotals[task.tagId!] = (tagTotals[task.tagId!] ?? 0) + 1;
      }

      final checkedSubtasks = task.checklistItems
          .where((item) => item.isDone && !item.isCancelled)
          .length;

      if (task.isCompleted) {
        allTimeCompleted++;
        priorityCounts[task.priority] =
            (priorityCounts[task.priority] ?? 0) + 1;

        if (task.projectId != null) {
          projectCompleted[task.projectId!] =
              (projectCompleted[task.projectId!] ?? 0) + 1;
        }
        if (task.tagId != null) {
          tagCompleted[task.tagId!] = (tagCompleted[task.tagId!] ?? 0) + 1;
        }

        if (task.repeatingRuleId != null && task.date != null) {
          completedDatesByRule
              .putIfAbsent(task.repeatingRuleId!, () => <String>{})
              .add(TaskModel.formatDateKey(task.date!));
        }

        final completionDate = task.effectiveCompletionDate;
        if (completionDate != null) {
          final key = TaskModel.formatDateKey(completionDate);
          if (taskCountsByDay.containsKey(key)) {
            taskCountsByDay[key] = (taskCountsByDay[key] ?? 0) + 1;
            checklistCountsByDay[key] =
                (checklistCountsByDay[key] ?? 0) + checkedSubtasks;
          }
        }
      } else if (checkedSubtasks > 0 && task.date != null) {
        final key = TaskModel.formatDateKey(task.date!);
        if (checklistCountsByDay.containsKey(key)) {
          checklistCountsByDay[key] =
              (checklistCountsByDay[key] ?? 0) + checkedSubtasks;
        }
      }
    }

    final last30Days = <DailyCompletionStat>[];
    var totalTasks30 = 0;
    var totalChecklists30 = 0;

    for (var i = 0; i < 30; i++) {
      final key = dayKeys30[i];
      final dayTasks = taskCountsByDay[key] ?? 0;
      final dayChecklists = checklistCountsByDay[key] ?? 0;
      totalTasks30 += dayTasks;
      totalChecklists30 += dayChecklists;
      last30Days.add(
        DailyCompletionStat(
          date: dayDates30[i],
          completedTasks: dayTasks,
          completedChecklists: dayChecklists,
        ),
      );
    }

    final last7Days = last30Days.sublist(23);
    var totalTasks7 = 0;
    var totalChecklists7 = 0;
    for (final stat in last7Days) {
      totalTasks7 += stat.completedTasks;
      totalChecklists7 += stat.completedChecklists;
    }

    final todayKey = TaskModel.formatDateKey(normalizedToday);
    final completedToday = taskCountsByDay[todayKey] ?? 0;
    final totalTasks = activeTasksCount;
    final completionRate =
        totalTasks == 0 ? 0.0 : allTimeCompleted / totalTasks;

    final projectBreakdown = projects.map((project) {
      final id = project.id;
      return ProjectStatBreakdown(
        project: project,
        completedCount: id != null ? (projectCompleted[id] ?? 0) : 0,
        totalCount: id != null ? (projectTotals[id] ?? 0) : 0,
      );
    }).toList();

    final tagBreakdown = tags.map((tag) {
      final id = tag.id;
      return TagStatBreakdown(
        tag: tag,
        completedCount: id != null ? (tagCompleted[id] ?? 0) : 0,
        totalCount: id != null ? (tagTotals[id] ?? 0) : 0,
      );
    }).toList();

    final habitStats = <HabitStatItem>[];
    for (final rule in repeatingRules.where((r) => r.isActive)) {
      final completedKeys =
          rule.id != null ? (completedDatesByRule[rule.id!] ?? const <String>{}) : const <String>{};
      final dotStatus = <bool>[];
      var completedInWindow = 0;
      var scheduledInWindow = 0;

      for (var i = 0; i < 30; i++) {
        final day = dayDates30[i];
        final key = dayKeys30[i];
        final isDone = completedKeys.contains(key);
        dotStatus.add(isDone);
        if (isDone) {
          completedInWindow++;
          scheduledInWindow++;
        } else if (rule.matchesDate(day)) {
          scheduledInWindow++;
        }
      }

      habitStats.add(
        HabitStatItem(
          rule: rule,
          completedLast30Days: completedInWindow,
          scheduledLast30Days: scheduledInWindow,
          last30DaysStatus: List.unmodifiable(dotStatus),
        ),
      );
    }

    return WorkspaceStats(
      last7Days: List.unmodifiable(last7Days),
      totalTasks7Days: totalTasks7,
      totalChecklists7Days: totalChecklists7,
      last30Days: List.unmodifiable(last30Days),
      totalTasks30Days: totalTasks30,
      totalChecklists30Days: totalChecklists30,
      completedToday: completedToday,
      allTimeCompletedTasks: allTimeCompleted,
      totalTasks: totalTasks,
      completionRate: completionRate,
      breakdownByPriority: Map.unmodifiable(priorityCounts),
      breakdownByProject: List.unmodifiable(projectBreakdown),
      breakdownByTag: List.unmodifiable(tagBreakdown),
      habitStats: List.unmodifiable(habitStats),
    );
  }
}
