import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/project_model.dart';
import '../models/repeating_task_model.dart';
import '../models/task_model.dart';
import '../providers/locale_provider.dart';
import '../providers/task_provider.dart';
import '../providers/workspace_provider.dart';
import '../widgets/task_editor_sheet.dart';
import '../widgets/zettask_loaders.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({
    super.key,
    required this.project,
  });

  final ProjectModel project;

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  List<TaskModel> _tasks = const [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final projectId = widget.project.id;
    if (projectId == null) {
      setState(() => _isLoading = false);
      return;
    }

    final workspaceProvider = context.read<WorkspaceProvider>();
    final fetched = await workspaceProvider.getTasksByProject(projectId);
    if (!mounted) return;
    setState(() {
      _tasks = fetched;
      _isLoading = false;
    });
  }

  String _formatDateLabel(
    DateTime? date,
    AppLocalizations l10n,
    String intlLocale,
  ) {
    if (date == null) return l10n.unplanned;
    try {
      return DateFormat('d MMM', intlLocale).format(date);
    } catch (_) {
      return DateFormat('d MMM').format(date);
    }
  }

  Future<void> _openTaskEditor({TaskModel? task}) async {
    final taskProvider = context.read<TaskProvider>();
    final workspaceProvider = context.read<WorkspaceProvider>();

    final result = await TaskEditorSheet.show(
      context,
      initialTask: task,
      defaultDate: task == null ? taskProvider.selectedDate : null,
      defaultProjectId: widget.project.id,
      onRequestNotificationPermission:
          taskProvider.requestNotificationPermission,
    );

    if (!mounted || result == null) return;

    switch (result) {
      case TaskEditorSaved(:final task, :final repeatConfig):
        if (result.task.id == null) {
          if (repeatConfig != null && task.date != null) {
            await taskProvider.addRepeatingTask(
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
                projectId: task.projectId,
                tagId: task.tagId,
              ),
            );
          } else {
            await taskProvider.addTask(task);
          }
        } else {
          await taskProvider.updateTask(task);
        }
        await workspaceProvider.refreshCounts();
        await _loadTasks();
      case TaskEditorDeleted(:final task):
        await _deleteWithUndo(task);
    }
  }

  Future<void> _toggleComplete(TaskModel task) async {
    final taskProvider = context.read<TaskProvider>();
    final workspaceProvider = context.read<WorkspaceProvider>();
    await taskProvider.toggleTaskComplete(task);
    await workspaceProvider.refreshCounts();
    await _loadTasks();
  }

  Future<void> _toggleCancel(TaskModel task) async {
    final taskProvider = context.read<TaskProvider>();
    final workspaceProvider = context.read<WorkspaceProvider>();
    final nowCancelled = await taskProvider.toggleTaskCancelled(task);
    await workspaceProvider.refreshCounts();
    await _loadTasks();

    if (!mounted || !nowCancelled) return;
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
            onPressed: () async {
              await taskProvider.toggleTaskCancelled(cancelledSnapshot);
              await workspaceProvider.refreshCounts();
              if (mounted) await _loadTasks();
            },
          ),
        ),
      );
  }

  Future<void> _toggleChecklistItem(TaskModel task, int index) async {
    final taskProvider = context.read<TaskProvider>();
    await taskProvider.toggleChecklistItem(task, index);
    await _loadTasks();
  }

  Future<void> _deleteWithUndo(TaskModel task) async {
    final taskId = task.id;
    if (taskId == null) return;

    final taskProvider = context.read<TaskProvider>();
    final workspaceProvider = context.read<WorkspaceProvider>();
    await taskProvider.deleteTask(taskId);
    await workspaceProvider.refreshCounts();
    await _loadTasks();

    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.taskDeleted),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: l10n.undo,
            onPressed: () async {
              await taskProvider.restoreTask(task);
              await workspaceProvider.refreshCounts();
              if (mounted) await _loadTasks();
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
    final workspaceProvider = context.watch<WorkspaceProvider>();
    final currentProject =
        workspaceProvider.findProject(widget.project.id) ?? widget.project;
    final accentColor = AppTheme.resolveTagColor(
      currentProject.colorHex,
      theme.brightness,
    );
    final nonCancelledTasks = _tasks.where((t) => !t.isCancelled).toList();
    final completedCount = nonCancelledTasks.where((t) => t.isCompleted).length;
    final progress = ProjectProgress(
      completedCount: completedCount,
      totalCount: nonCancelledTasks.length,
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                currentProject.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colorScheme.outline, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Text(
                          l10n.projectTasksCompletedRatio(
                            progress.completedCount,
                            progress.totalCount,
                          ),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${progress.percentage}%',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: accentColor,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress.ratio,
                        minHeight: 5,
                        backgroundColor: colorScheme.outline,
                        valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _isLoading
                  ? const ZettaskTaskListSkeleton()
                  : _tasks.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.folder_open_outlined,
                                  size: 36,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  l10n.noProjectTasksTitle,
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l10n.noProjectTasksSubtitle(
                                    currentProject.name,
                                  ),
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
                          itemCount: _tasks.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final task = _tasks[index];
                            final tag = workspaceProvider.findTag(task.tagId);
                            return _ProjectTaskCard(
                              task: task,
                              dateLabel:
                                  _formatDateLabel(task.date, l10n, intlLocale),
                              tagName: tag?.name,
                              tagColorHex: tag?.colorHex,
                              onTap: () => _openTaskEditor(task: task),
                              onToggleComplete: () => _toggleComplete(task),
                              onToggleCancel: () => _toggleCancel(task),
                              onDelete: () => _deleteWithUndo(task),
                              onToggleChecklistItem: (i) =>
                                  _toggleChecklistItem(task, i),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'project_detail_fab',
        onPressed: () => _openTaskEditor(),
        tooltip: l10n.addTaskToProjectTooltip,
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}

class _ProjectTaskCard extends StatelessWidget {
  const _ProjectTaskCard({
    required this.task,
    required this.dateLabel,
    this.tagName,
    this.tagColorHex,
    required this.onTap,
    required this.onToggleComplete,
    required this.onToggleCancel,
    required this.onDelete,
    required this.onToggleChecklistItem,
  });

  final TaskModel task;
  final String dateLabel;
  final String? tagName;
  final String? tagColorHex;
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
    final taskColor = AppTheme.resolveTagColor(task.colorHex, brightness);
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
    final successColor = AppTheme.successColor(brightness);

    return Dismissible(
      key: ValueKey('project_task_${task.id ?? task.hashCode}'),
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
        child: Icon(
          isMuted ? Icons.undo_rounded : Icons.check_circle_outline_rounded,
          color: successColor,
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
        child: Icon(Icons.delete_outline_rounded, color: colorScheme.error),
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
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCancelled
                                  ? cancelledFill
                                  : (task.isCompleted
                                      ? taskColor
                                      : Colors.transparent),
                              border: Border.all(
                                color: isCancelled ? cancelledFill : taskColor,
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
                            Text(
                              task.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 15,
                                decoration:
                                    isMuted ? TextDecoration.lineThrough : null,
                                color: isCancelled
                                    ? mutedNeutral
                                    : task.isCompleted
                                        ? colorScheme.onSurfaceVariant
                                        : colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  task.hasStartTime
                                      ? '$dateLabel · ${task.startTime}'
                                      : dateLabel,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isCancelled ? mutedNeutral : null,
                                  ),
                                ),
                                if (tagName != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 7,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (isCancelled
                                              ? colorScheme.onSurfaceVariant
                                              : AppTheme.resolveTagColor(
                                                  tagColorHex ?? '#2563EB',
                                                  brightness,
                                                ))
                                          .withValues(
                                        alpha: isCancelled ? 0.08 : 0.12,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      tagName!,
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        color: isCancelled
                                            ? mutedNeutral
                                            : AppTheme.resolveTagColor(
                                                tagColorHex ?? '#2563EB',
                                                brightness,
                                              ),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.5,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (task.checklistItems.isNotEmpty) ...[
                Divider(
                  height: 1,
                  color: colorScheme.outline.withValues(alpha: 0.7),
                ),
                ...List.generate(task.checklistItems.length, (index) {
                  final item = task.checklistItems[index];
                  return InkWell(
                    onTap: () => onToggleChecklistItem(index),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 44),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.isDone
                                  ? Icons.check_box_rounded
                                  : Icons.check_box_outline_blank_rounded,
                              size: 18,
                              color: item.isDone
                                  ? taskColor
                                  : colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item.title,
                                style: theme.textTheme.bodySmall?.copyWith(
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
              ],
            ],
          ),
        ),
      ),
    );
  }
}
