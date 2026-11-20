import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_helpers.dart';
import '../models/repeating_task_model.dart';
import '../models/task_model.dart';
import '../providers/locale_provider.dart';
import '../providers/task_provider.dart';
import '../widgets/quick_add_task_sheet.dart';
import '../widgets/task_editor_sheet.dart';

class UnplannedScreen extends StatelessWidget {
  const UnplannedScreen({super.key});

  String _formatShortDate(DateTime date, String intlLocale) {
    try {
      return DateFormat('d MMM yyyy', intlLocale).format(date);
    } catch (_) {
      return DateFormat('d MMM yyyy').format(date);
    }
  }

  Future<void> _openQuickAdd(BuildContext context) async {
    final taskProvider = context.read<TaskProvider>();
    final quickResult = await QuickAddTaskSheet.show(
      context,
      defaultDate: null,
      onRequestNotificationPermission:
          taskProvider.requestNotificationPermission,
    );
    if (!context.mounted || quickResult == null) return;

    switch (quickResult) {
      case QuickAddSaved(:final task):
        final isSuccess = await taskProvider.addTask(task);
        if (isSuccess && context.mounted && task.date != null) {
          final l10n = AppLocalizations.of(context);
          final intlLocale =
              LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  l10n.scheduledForDate(
                    _formatShortDate(task.date!, intlLocale),
                  ),
                ),
              ),
            );
        }
      case QuickAddExpand(:final draftTask):
        await _openTaskEditor(context, task: draftTask);
    }
  }

  Future<void> _openTaskEditor(
    BuildContext context, {
    TaskModel? task,
  }) async {
    final taskProvider = context.read<TaskProvider>();
    final result = await TaskEditorSheet.show(
      context,
      initialTask: task,
      defaultDate: null,
      onRequestNotificationPermission:
          taskProvider.requestNotificationPermission,
    );

    if (!context.mounted || result == null) return;

    switch (result) {
      case TaskEditorSaved(:final task, :final repeatConfig):
        bool isSuccess;
        if (result.task.id == null &&
            repeatConfig != null &&
            task.date != null) {
          isSuccess = await taskProvider.addRepeatingTask(
            RepeatingTaskRule(
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
            ),
          );
        } else {
          isSuccess = result.task.id == null
              ? await taskProvider.addTask(task)
              : await taskProvider.updateTask(task);
        }

        if (isSuccess && context.mounted && task.date != null) {
          final l10n = AppLocalizations.of(context);
          final intlLocale =
              LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  l10n.scheduledForDate(
                    _formatShortDate(task.date!, intlLocale),
                  ),
                ),
              ),
            );
        }
      case TaskEditorDeleted(:final task):
        await _deleteWithUndo(context, taskProvider, task);
    }
  }

  Future<void> _handleToggleCancel(
    BuildContext context,
    TaskProvider taskProvider,
    TaskModel task,
  ) async {
    final nowCancelled = await taskProvider.toggleTaskCancelled(task);
    if (!context.mounted) return;
    if (nowCancelled) {
      final l10n = AppLocalizations.of(context);
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
              onPressed: () =>
                  taskProvider.toggleTaskCancelled(cancelledSnapshot),
            ),
          ),
        );
    }
  }

  Future<void> _deleteWithUndo(
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
            onPressed: () => taskProvider.restoreTask(task),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        final tasks = taskProvider.visibleUnplannedTasks;
        final activeCount = taskProvider.unplannedCount;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.unplannedTitle),
            actions: [
              if (activeCount > 0)
                Center(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 16),
                    child: Text(
                      l10n.activeCountLabel(activeCount),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          body: SafeArea(
            child: tasks.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: colorScheme.outline,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.inbox_outlined,
                              size: 26,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            l10n.noUnplannedTitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.noUnplannedSubtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
                    itemCount: tasks.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return _UnplannedTaskCard(
                        task: task,
                        onTap: () => _openTaskEditor(context, task: task),
                        onToggleComplete: () =>
                            taskProvider.toggleTaskComplete(task),
                        onToggleCancel: () =>
                            _handleToggleCancel(context, taskProvider, task),
                        onDelete: () =>
                            _deleteWithUndo(context, taskProvider, task),
                        onToggleChecklistItem: (itemIndex) =>
                            taskProvider.toggleChecklistItem(task, itemIndex),
                      );
                    },
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'unplanned_fab',
            onPressed: () => _openQuickAdd(context),
            tooltip: l10n.addUnplannedTooltip,
            child: const Icon(Icons.add_rounded),
          ),
        );
      },
    );
  }
}

class _UnplannedTaskCard extends StatelessWidget {
  const _UnplannedTaskCard({
    required this.task,
    required this.onTap,
    required this.onToggleComplete,
    required this.onToggleCancel,
    required this.onDelete,
    required this.onToggleChecklistItem,
  });

  final TaskModel task;
  final VoidCallback onTap;
  final VoidCallback onToggleComplete;
  final VoidCallback onToggleCancel;
  final VoidCallback onDelete;
  final ValueChanged<int> onToggleChecklistItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;
    final l10n = AppLocalizations.of(context);
    final tagColor = AppTheme.resolveTagColor(task.colorHex, brightness);
    final priorityColor = AppTheme.priorityColor(task.priority, brightness);
    final successColor = AppTheme.successColor(brightness);
    final checkColor =
        brightness == Brightness.dark ? const Color(0xFF0A0A0A) : Colors.white;
    final cancelledFill = brightness == Brightness.dark
        ? const Color(0xFF52525B)
        : const Color(0xFF71717A);
    final cancelledIconColor =
        brightness == Brightness.dark ? const Color(0xFFFAFAFA) : Colors.white;
    final isCancelled = task.isCancelled;
    final isMuted = task.isCompleted || isCancelled;
    final mutedNeutral = colorScheme.onSurfaceVariant.withValues(alpha: 0.6);
    final hasDescription = task.description.trim().isNotEmpty;
    final hasChecklist = task.checklistItems.isNotEmpty;
    final doneSubtasks = task.checklistItems.where((i) => i.isDone).length;

    return Dismissible(
      key: ValueKey(
        'unplanned_task_${task.id ?? Object.hash(task.title, task.description)}',
      ),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onToggleComplete();
          return false;
        }
        return true;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerStart,
        decoration: BoxDecoration(
          color: successColor.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: successColor.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isMuted ? Icons.undo_rounded : Icons.check_circle_outline_rounded,
              color: successColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              isCancelled
                  ? l10n.restoreTaskLabel
                  : (task.isCompleted
                      ? l10n.uncompleteLabel
                      : l10n.completedLabel),
              style: theme.textTheme.labelMedium?.copyWith(
                color: successColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: AlignmentDirectional.centerEnd,
        decoration: BoxDecoration(
          color: colorScheme.error.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: colorScheme.error.withValues(alpha: 0.4),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.delete,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colorScheme.error,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.delete_outline_rounded,
              color: colorScheme.error,
              size: 20,
            ),
          ],
        ),
      ),
      child: Material(
        color: isCancelled
            ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.65)
            : task.isCompleted
                ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                : colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: colorScheme.outline, width: 1),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 14, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: InkWell(
                        onTap: onToggleComplete,
                        onLongPress: () {
                          HapticFeedback.mediumImpact();
                          onToggleCancel();
                        },
                        customBorder: const CircleBorder(),
                        child: Center(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 160),
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCancelled
                                  ? cancelledFill
                                  : (task.isCompleted
                                      ? tagColor
                                      : Colors.transparent),
                              border: Border.all(
                                color: isCancelled ? cancelledFill : tagColor,
                                width: 1.75,
                              ),
                            ),
                            child: isCancelled
                                ? Icon(
                                    Icons.close_rounded,
                                    size: 14,
                                    color: cancelledIconColor,
                                  )
                                : task.isCompleted
                                    ? Icon(
                                        Icons.check_rounded,
                                        size: 14,
                                        color: checkColor,
                                      )
                                    : null,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    task.title,
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontSize: 15,
                                      decoration: isMuted
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: isCancelled
                                          ? mutedNeutral
                                          : task.isCompleted
                                              ? colorScheme.onSurfaceVariant
                                                  .withValues(alpha: 0.7)
                                              : colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        color: isCancelled
                                            ? mutedNeutral
                                            : task.isCompleted
                                                ? priorityColor.withValues(
                                                    alpha: 0.5,
                                                  )
                                                : priorityColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      localizedPriorityLabel(
                                        l10n,
                                        task.priority,
                                      ),
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        color: isCancelled
                                            ? mutedNeutral
                                            : task.isCompleted
                                                ? priorityColor.withValues(
                                                    alpha: 0.5,
                                                  )
                                                : priorityColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (hasDescription) ...[
                              const SizedBox(height: 4),
                              Text(
                                task.description.trim(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isMuted
                                      ? colorScheme.onSurfaceVariant
                                          .withValues(alpha: 0.5)
                                      : null,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (hasChecklist) ...[
                Divider(
                  height: 1,
                  thickness: 1,
                  color: colorScheme.outline.withValues(alpha: 0.7),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
                  child: Text(
                    l10n.subtasksCount(
                      doneSubtasks,
                      task.checklistItems.length,
                    ),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ...List.generate(task.checklistItems.length, (index) {
                  final item = task.checklistItems[index];
                  return InkWell(
                    onTap: () => onToggleChecklistItem(index),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 48),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: item.isDone
                                    ? tagColor
                                    : Colors.transparent,
                                border: Border.all(
                                  color: item.isDone
                                      ? tagColor
                                      : colorScheme.onSurfaceVariant,
                                  width: 1.5,
                                ),
                              ),
                              child: item.isDone
                                  ? Icon(
                                      Icons.check_rounded,
                                      size: 12,
                                      color: checkColor,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item.title,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.5,
                                  decoration: item.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color: item.isDone
                                      ? colorScheme.onSurfaceVariant
                                      : colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 4),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
