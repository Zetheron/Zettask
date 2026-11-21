import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/repeating_task_model.dart';
import '../models/task_model.dart';
import '../models/timeline_entry.dart';
import '../providers/auth_provider.dart';
import '../providers/calendar_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/task_provider.dart';
import '../providers/workspace_provider.dart';
import '../widgets/date_strip.dart';
import '../widgets/overdue_tasks_sheet.dart';
import '../widgets/quick_add_task_sheet.dart';
import '../widgets/repeating_action_sheet.dart';
import '../widgets/task_editor_sheet.dart';
import '../widgets/task_search_sheet.dart';
import '../widgets/timeline_calendar_event_item.dart';
import '../widgets/timeline_options_sheet.dart';
import '../widgets/timeline_task_item.dart';
import '../widgets/zettask_loaders.dart';
import '../widgets/zettask_motion.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.autoLoad = true,
    this.onOpenUnplannedTab,
  });

  final bool autoLoad;
  final VoidCallback? onOpenUnplannedTab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.autoLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final taskProvider = context.read<TaskProvider>();
        final calendarProvider = context.read<CalendarProvider>();
        taskProvider.initialize();
        calendarProvider.initialize(initialDate: taskProvider.selectedDate);
      });
    }
  }

  String _formatShortDate(DateTime date, String intlLocale) {
    try {
      return DateFormat('EEE, d MMM', intlLocale).format(date);
    } catch (_) {
      return DateFormat('EEE, d MMM').format(date);
    }
  }

  String _formatMediumDate(DateTime date, String intlLocale) {
    try {
      return DateFormat('d MMM yyyy', intlLocale).format(date);
    } catch (_) {
      return DateFormat('d MMM yyyy').format(date);
    }
  }

  String _formatDayHeading(
    DateTime date,
    AppLocalizations l10n,
    String intlLocale,
  ) {
    final today = TaskProvider.normalizeDate(DateTime.now());
    final target = TaskProvider.normalizeDate(date);
    final diff = target.difference(today).inDays;
    if (diff == 0) return l10n.today;
    if (diff == 1) return l10n.tomorrow;
    if (diff == -1) return l10n.yesterday;
    try {
      return DateFormat('EEEE', intlLocale).format(date);
    } catch (_) {
      return DateFormat('EEEE').format(date);
    }
  }

  Future<void> _selectDate(BuildContext context, DateTime date) async {
    final taskProvider = context.read<TaskProvider>();
    final calendarProvider = context.read<CalendarProvider>();
    await Future.wait([
      taskProvider.selectDate(date),
      calendarProvider.loadEventsForDate(date),
    ]);
  }

  Future<void> _goToToday(BuildContext context) async {
    await _selectDate(context, DateTime.now());
  }

  Future<void> _pickDate(BuildContext context, DateTime initialDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && context.mounted) {
      await _selectDate(context, picked);
    }
  }

  Future<void> _openQuickAdd(
    BuildContext context, {
    required DateTime defaultDate,
  }) async {
    final taskProvider = context.read<TaskProvider>();
    final quickResult = await QuickAddTaskSheet.show(
      context,
      defaultDate: defaultDate,
      onRequestNotificationPermission:
          taskProvider.requestNotificationPermission,
    );
    if (!context.mounted || quickResult == null) return;

    switch (quickResult) {
      case QuickAddSaved(:final task):
        final saved = await taskProvider.addTask(task);
        if (saved && context.mounted) {
          final l10n = AppLocalizations.of(context);
          final intlLocale =
              LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
          if (task.date == null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(l10n.savedToUnplannedNoDate),
                ),
              );
          } else if (!TaskProvider.isSameDay(
            task.date!,
            taskProvider.selectedDate,
          )) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.taskScheduledForDate(
                      _formatMediumDate(task.date!, intlLocale),
                    ),
                  ),
                ),
              );
          }
        }
      case QuickAddExpand(:final draftTask):
        await _openTaskEditor(
          context,
          task: draftTask,
          defaultDate: draftTask.date,
        );
    }
  }

  Future<void> _openTaskEditor(
    BuildContext context, {
    TaskModel? task,
    DateTime? defaultDate,
  }) async {
    final taskProvider = context.read<TaskProvider>();
    final widgetTaskDate = task?.date;

    RepeatingActionScope? editScope;
    RepeatingTaskRule? linkedRule;
    if (task != null && task.isRepeating) {
      editScope = await RepeatingActionSheet.show(
        context,
        intent: RepeatingActionIntent.edit,
      );
      if (!context.mounted || editScope == null) return;
      if (editScope == RepeatingActionScope.thisAndFollowing) {
        linkedRule = taskProvider.findRepeatingRule(task.repeatingRuleId);
      }
    }

    final result = await TaskEditorSheet.show(
      context,
      initialTask: task,
      initialRepeatingRule: linkedRule,
      defaultDate:
          task == null ? (defaultDate ?? taskProvider.selectedDate) : null,
      allowRepeatPicker: task == null ||
          task.id == null ||
          editScope == RepeatingActionScope.thisAndFollowing,
      onRequestNotificationPermission:
          taskProvider.requestNotificationPermission,
    );

    if (!context.mounted || result == null) return;

    switch (result) {
      case TaskEditorSaved(:final task, :final repeatConfig):
        bool isSuccess;
        if (result.task.id == null) {
          if (repeatConfig != null && task.date != null) {
            final newRule = RepeatingTaskRule(
              title: task.title,
              description: task.description,
              startTime: task.startTime,
              priority: task.priority,
              colorHex: task.colorHex,
              checklistItems: task.checklistItems
                  .map((i) => ChecklistItem(title: i.title, isDone: false))
                  .toList(),
              reminderMinutesBefore: task.reminderMinutesBefore,
              frequency: repeatConfig.frequency,
              weekdays: repeatConfig.weekdays,
              startDate: task.date!,
              projectId: task.projectId,
              tagId: task.tagId,
            );
            isSuccess = await taskProvider.addRepeatingTask(newRule);
          } else {
            isSuccess = await taskProvider.addTask(task);
          }
        } else if (editScope != null) {
          isSuccess = await taskProvider.updateRepeatingTask(
            task,
            scope: editScope,
            originalDate: widgetTaskDate,
            repeatConfig: repeatConfig,
          );
        } else {
          isSuccess = await taskProvider.updateTask(task);
        }

        if (isSuccess && context.mounted) {
          final l10n = AppLocalizations.of(context);
          final intlLocale =
              LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
          if (task.date == null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(l10n.savedToUnplanned),
                ),
              );
          } else if (!TaskProvider.isSameDay(
            task.date!,
            taskProvider.selectedDate,
          )) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    l10n.scheduledForDate(
                      _formatMediumDate(task.date!, intlLocale),
                    ),
                  ),
                ),
              );
          }
        }
      case TaskEditorDeleted(:final task):
        if (task.isRepeating) {
          final deleteScope = editScope ??
              await RepeatingActionSheet.show(
                context,
                intent: RepeatingActionIntent.delete,
              );
          if (!context.mounted || deleteScope == null) return;
          await _deleteRepeatingTaskWithFeedback(
            context,
            taskProvider,
            task,
            scope: deleteScope,
          );
        } else {
          await _deleteTaskWithUndo(context, taskProvider, task);
        }
    }
  }

  Future<bool> _confirmAndDeleteRepeatingSwipe(
    BuildContext context,
    TaskProvider taskProvider,
    TaskModel task,
  ) async {
    final scope = await RepeatingActionSheet.show(
      context,
      intent: RepeatingActionIntent.delete,
    );
    if (!context.mounted || scope == null) {
      return false;
    }

    await _deleteRepeatingTaskWithFeedback(
      context,
      taskProvider,
      task,
      scope: scope,
    );
    return false;
  }

  Future<void> _deleteRepeatingTaskWithFeedback(
    BuildContext context,
    TaskProvider taskProvider,
    TaskModel task, {
    required RepeatingActionScope scope,
  }) async {
    await taskProvider.deleteRepeatingTask(task, scope: scope);
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);

    if (scope == RepeatingActionScope.single) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(l10n.taskDeleted),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: l10n.undo,
              onPressed: () {
                taskProvider.restoreTask(task);
              },
            ),
          ),
        );
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(l10n.repeatingTasksAndFollowingDeleted),
          ),
        );
    }
  }

  Future<void> _deleteTaskWithUndo(
    BuildContext context,
    TaskProvider taskProvider,
    TaskModel task,
  ) async {
    final taskId = task.id;
    if (taskId == null) return;

    await taskProvider.deleteTask(taskId);
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.taskDeleted),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: l10n.undo,
            onPressed: () {
              taskProvider.restoreTask(task);
            },
          ),
        ),
      );
  }

  Future<void> _handleToggleCancel(
    BuildContext context,
    TaskProvider taskProvider,
    TaskModel task,
  ) async {
    final nowCancelled = await taskProvider.toggleTaskCancelled(task);
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);

    if (nowCancelled) {
      final cancelledSnapshot = task.copyWith(
        isCompleted: false,
        isCancelled: true,
        clearCompletedAt: true,
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(l10n.taskCancelled),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: l10n.undo,
              onPressed: () {
                taskProvider.toggleTaskCancelled(cancelledSnapshot);
              },
            ),
          ),
        );
    }
  }

  void _openOverdueSheet(BuildContext context) {
    OverdueTasksSheet.show(
      context,
      onEditTask: (task) => _openTaskEditor(context, task: task),
    );
  }

  void _openSearchSheet(BuildContext context) {
    TaskSearchSheet.show(
      context,
      onSelectTask: (task) => _openTaskEditor(context, task: task),
    );
  }

  void _openOptionsSheet(BuildContext context) {
    TimelineOptionsSheet.show(
      context,
      onOpenOverdue: () => _openOverdueSheet(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Consumer2<TaskProvider, CalendarProvider>(
      builder: (context, taskProvider, calendarProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 17,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Text(l10n.appName),
              ],
            ),
            actions: [
              IconButton(
                tooltip: l10n.searchTasksTooltip,
                onPressed: () => _openSearchSheet(context),
                style: IconButton.styleFrom(
                  minimumSize: const Size(48, 48),
                ),
                icon: const Icon(Icons.search_rounded),
              ),
              IconButton(
                tooltip: l10n.timelineOptionsTooltip,
                onPressed: () => _openOptionsSheet(context),
                style: IconButton.styleFrom(
                  minimumSize: const Size(48, 48),
                ),
                icon: const Icon(Icons.tune_rounded),
              ),
              const SizedBox(width: 4),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (calendarProvider.isLoadingEvents ||
                  (context.watch<AuthProvider?>()?.isSyncing ?? false))
                const ZettaskIndeterminateBar(),
              Expanded(
                child: Stack(
                  children: [
                    _buildMainBody(
                      context: context,
                      taskProvider: taskProvider,
                      calendarProvider: calendarProvider,
                    ),
                    PositionedDirectional(
                      end: 16,
                      bottom: 16,
                      child: FloatingActionButton(
                        heroTag: 'timeline_fab',
                        onPressed: () => _openTaskEditor(
                          context,
                          defaultDate: taskProvider.selectedDate,
                        ),
                        tooltip: l10n.addTaskTooltip,
                        child: const Icon(Icons.add_rounded),
                      ),
                    ),
                  ],
                ),
              ),
              DateStrip(
                selectedDate: taskProvider.selectedDate,
                datesWithTasks: taskProvider.datesWithTasks,
                firstDayOfWeek: taskProvider.firstDayOfWeek,
                showTopBorder: true,
                onDateSelected: (date) => _selectDate(context, date),
                onPickDate: () =>
                    _pickDate(context, taskProvider.selectedDate),
                onGoToToday: () => _goToToday(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMainBody({
    required BuildContext context,
    required TaskProvider taskProvider,
    required CalendarProvider calendarProvider,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));

    if (taskProvider.isLoading) {
      return const ZettaskTaskListSkeleton();
    }

    if (taskProvider.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 36,
                color: colorScheme.error,
              ),
              const SizedBox(height: 12),
              Text(
                taskProvider.errorMessage!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: taskProvider.loadTasksForSelectedDate,
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      );
    }

    final selectedAllDayEntries = TimelineMerger.mergeAllDay(
      tasks: taskProvider.allDayTasks,
      events: calendarProvider.allDayEvents,
    );
    final selectedScheduledEntries = TimelineMerger.mergeScheduled(
      tasks: taskProvider.scheduledTasks,
      events: calendarProvider.scheduledEvents,
    );

    final isTimelineMode = taskProvider.viewMode == TimelineViewMode.timeline;
    final upcomingDates = isTimelineMode
        ? ({
            ...taskProvider.timelineDates.skip(1),
            ...calendarProvider.upcomingDatesWithEvents,
          }.toList()
          ..sort((a, b) => a.compareTo(b)))
        : const <DateTime>[];

    final quickAddLabel = taskProvider.isSelectedDateToday
        ? l10n.addTaskToday
        : l10n.addTask;
    final selectedDateKey = TaskModel.formatDateKey(taskProvider.selectedDate);

    final selectedDayItems = <Widget>[
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 14),
        child: _SummaryCardsRow(
          todoCount: taskProvider.activeTaskCount,
          overdueCount: taskProvider.overdueCount,
          unplannedCount: taskProvider.unplannedCount,
          onTapOverdue: () => _openOverdueSheet(context),
          onTapUnplanned: widget.onOpenUnplannedTab,
        ),
      ),
      if (selectedAllDayEntries.isEmpty && selectedScheduledEntries.isEmpty)
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
          child: Text(
            l10n.noTasksForDate,
            style: theme.textTheme.bodySmall,
          ),
        ),
      if (selectedAllDayEntries.isNotEmpty) ...[
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
          child: _TimelineSectionHeader(
            title: l10n.allDay,
            count: selectedAllDayEntries.length,
          ),
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < selectedAllDayEntries.length; i++)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
            child: ZettaskLineReveal(
              key: ValueKey(
                'reveal_${selectedDateKey}_all_${_timelineEntryKey(selectedAllDayEntries[i], i)}',
              ),
              index: i,
              child: _buildTimelineEntryItem(
                context: context,
                taskProvider: taskProvider,
                entry: selectedAllDayEntries[i],
                isFirstInSection: i == 0,
                isLastInSection: i == selectedAllDayEntries.length - 1 &&
                    selectedScheduledEntries.isNotEmpty,
              ),
            ),
          ),
        if (selectedScheduledEntries.isNotEmpty) const SizedBox(height: 12),
      ],
      if (selectedScheduledEntries.isNotEmpty) ...[
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
          child: _TimelineSectionHeader(
            title: l10n.scheduled,
            count: selectedScheduledEntries.length,
          ),
        ),
        const SizedBox(height: 8),
        for (var i = 0; i < selectedScheduledEntries.length; i++)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
            child: ZettaskLineReveal(
              key: ValueKey(
                'reveal_${selectedDateKey}_sch_${_timelineEntryKey(selectedScheduledEntries[i], i)}',
              ),
              index: selectedAllDayEntries.length + i,
              child: _buildTimelineEntryItem(
                context: context,
                taskProvider: taskProvider,
                entry: selectedScheduledEntries[i],
                isFirstInSection: i == 0,
                isLastInSection: false,
              ),
            ),
          ),
      ],
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 16, 0),
        child: _TimelineQuickAddRow(
          label: quickAddLabel,
          showTopLine: selectedAllDayEntries.isNotEmpty ||
              selectedScheduledEntries.isNotEmpty,
          onTap: () => _openQuickAdd(
            context,
            defaultDate: taskProvider.selectedDate,
          ),
        ),
      ),
    ];

    final upcomingSlivers = <Widget>[];
    for (final upcomingDate in upcomingDates) {
      final sliverGroup = _buildUpcomingDaySliverGroup(
        context: context,
        taskProvider: taskProvider,
        calendarProvider: calendarProvider,
        date: upcomingDate,
      );
      if (sliverGroup != null) {
        upcomingSlivers.add(sliverGroup);
      }
    }

    return CustomScrollView(
      slivers: [
        SliverMainAxisGroup(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: ZettaskPinnedHeaderDelegate(
                height: 66,
                padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatShortDate(taskProvider.selectedDate, intlLocale),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      _formatDayHeading(
                        taskProvider.selectedDate,
                        l10n,
                        intlLocale,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: 25,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(selectedDayItems),
            ),
          ],
        ),
        if (upcomingSlivers.isNotEmpty)
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ...upcomingSlivers,
        const SliverToBoxAdapter(child: SizedBox(height: 108)),
      ],
    );
  }

  String _timelineEntryKey(TimelineEntry entry, int fallbackIndex) {
    return switch (entry) {
      TaskTimelineEntry(:final task) => 't_${task.id ?? fallbackIndex}',
      CalendarEventTimelineEntry(:final event) => 'e_${event.id}',
    };
  }

  Widget? _buildUpcomingDaySliverGroup({
    required BuildContext context,
    required TaskProvider taskProvider,
    required CalendarProvider calendarProvider,
    required DateTime date,
  }) {
    final allDayEntries = TimelineMerger.mergeAllDay(
      tasks: taskProvider.allDayTasksForDate(date),
      events: calendarProvider.allDayEventsForDate(date),
    );
    final scheduledEntries = TimelineMerger.mergeScheduled(
      tasks: taskProvider.scheduledTasksForDate(date),
      events: calendarProvider.scheduledEventsForDate(date),
    );
    final combined = [...allDayEntries, ...scheduledEntries];
    if (combined.isEmpty) return null;

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));

    return SliverMainAxisGroup(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: ZettaskPinnedHeaderDelegate(
            height: 40,
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Row(
              children: [
                Text(
                  '${_formatDayHeading(date, l10n, intlLocale)} · ${_formatShortDate(date, intlLocale)}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Divider(color: colorScheme.outline),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 16, 12),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildTimelineEntryItem(
                context: context,
                taskProvider: taskProvider,
                calendarProvider: calendarProvider,
                entry: combined[index],
                isFirstInSection: index == 0,
                isLastInSection: index == combined.length - 1,
              ),
              childCount: combined.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineEntryItem({
    required BuildContext context,
    required TaskProvider taskProvider,
    CalendarProvider? calendarProvider,
    required TimelineEntry entry,
    required bool isFirstInSection,
    required bool isLastInSection,
  }) {
    final workspaceProvider = context.watch<WorkspaceProvider>();
    final resolvedCalendarProvider =
        calendarProvider ?? context.read<CalendarProvider>();
    return switch (entry) {
      TaskTimelineEntry(:final task) => TimelineTaskItem(
          task: task,
          tag: workspaceProvider.findTag(task.tagId),
          project: workspaceProvider.findProject(task.projectId),
          isFirstInSection: isFirstInSection,
          isLastInSection: isLastInSection,
          onTap: () => _openTaskEditor(context, task: task),
          onToggleComplete: () => taskProvider.toggleTaskComplete(task),
          onToggleCancel: () =>
              _handleToggleCancel(context, taskProvider, task),
          onConfirmDelete: task.isRepeating
              ? () => _confirmAndDeleteRepeatingSwipe(
                    context,
                    taskProvider,
                    task,
                  )
              : null,
          onDelete: () => _deleteTaskWithUndo(context, taskProvider, task),
          onToggleChecklistItem: (itemIndex) =>
              taskProvider.toggleChecklistItem(task, itemIndex),
        ),
      CalendarEventTimelineEntry(:final event) => () {
          final cal = resolvedCalendarProvider.findCalendar(event.calendarId);
          return TimelineCalendarEventItem(
            event: event,
            calendarName: cal?.name ?? event.calendarName,
            calendarAccount: cal?.accountName,
            isFirstInSection: isFirstInSection,
            isLastInSection: isLastInSection,
          );
        }(),
    };
  }
}

class _SummaryCardsRow extends StatelessWidget {
  const _SummaryCardsRow({
    required this.todoCount,
    required this.overdueCount,
    required this.unplannedCount,
    required this.onTapOverdue,
    this.onTapUnplanned,
  });

  final int todoCount;
  final int overdueCount;
  final int unplannedCount;
  final VoidCallback onTapOverdue;
  final VoidCallback? onTapUnplanned;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            label: l10n.toDo,
            count: todoCount,
            accentColor: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SummaryCard(
            label: l10n.overdue,
            count: overdueCount,
            accentColor: overdueCount > 0
                ? colorScheme.error
                : colorScheme.onSurfaceVariant,
            isHighlighted: overdueCount > 0,
            onTap: onTapOverdue,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _SummaryCard(
            label: l10n.unplanned,
            count: unplannedCount,
            accentColor: colorScheme.secondary,
            onTap: onTapUnplanned,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.label,
    required this.count,
    required this.accentColor,
    this.isHighlighted = false,
    this.onTap,
  });

  final String label;
  final int count;
  final Color accentColor;
  final bool isHighlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: isHighlighted
          ? accentColor.withValues(alpha: 0.08)
          : colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isHighlighted
              ? accentColor.withValues(alpha: 0.45)
              : colorScheme.outline,
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 68),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$count',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: isHighlighted ? accentColor : colorScheme.onSurface,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isHighlighted
                        ? accentColor
                        : colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TimelineQuickAddRow extends StatelessWidget {
  const _TimelineQuickAddRow({
    required this.label,
    required this.showTopLine,
    required this.onTap,
  });

  final String label;
  final bool showTopLine;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(width: 48),
          SizedBox(
            width: 16,
            child: Column(
              children: [
                Container(
                  width: 1.5,
                  height: 19,
                  color: showTopLine ? colorScheme.outline : Colors.transparent,
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.surface,
                    border: Border.all(
                      color: colorScheme.primary,
                      width: 1.75,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Material(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(
                  color: colorScheme.outline,
                  width: 1,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.add_rounded,
                          size: 18,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            label,
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.primary,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineSectionHeader extends StatelessWidget {
  const _TimelineSectionHeader({
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4),
      child: Row(
        children: [
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              fontSize: 12.5,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '· $count',
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.75),
              fontWeight: FontWeight.w600,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
