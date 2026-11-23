import 'dart:async';

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_helpers.dart';
import '../models/project_model.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';
import 'zettask_motion.dart';

class TimelineTaskItem extends StatelessWidget {
  const TimelineTaskItem({
    super.key,
    required this.task,
    required this.isFirstInSection,
    required this.isLastInSection,
    required this.onTap,
    required this.onToggleComplete,
    required this.onDelete,
    required this.onToggleChecklistItem,
    this.onCancelChecklistItem,
    this.onToggleCancel,
    this.onConfirmDelete,
    this.tag,
    this.project,
  });

  final TaskModel task;
  final bool isFirstInSection;
  final bool isLastInSection;
  final VoidCallback onTap;
  final VoidCallback onToggleComplete;
  final VoidCallback? onToggleCancel;
  final VoidCallback onDelete;
  final ValueChanged<int> onToggleChecklistItem;
  final ValueChanged<int>? onCancelChecklistItem;
  final Future<bool> Function()? onConfirmDelete;
  final TagModel? tag;
  final ProjectModel? project;

  bool get _hasStartTime =>
      task.startTime != null && task.startTime!.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;
    final l10n = AppLocalizations.of(context);
    final tagColor = AppTheme.resolveTagColor(task.colorHex, brightness);
    final priorityColor = AppTheme.priorityColor(task.priority, brightness);
    final successColor = AppTheme.successColor(brightness);
    final bottomGap = isLastInSection ? 4.0 : 12.0;
    final isMuted = task.isCompleted || task.isCancelled;
    final mutedGrey = colorScheme.onSurfaceVariant.withValues(alpha: 0.55);

    return Dismissible(
      key: ValueKey(
        'timeline_task_${task.id ?? Object.hash(task.title, task.startTime)}',
      ),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onToggleComplete();
          return false;
        }
        if (onConfirmDelete != null) {
          return await onConfirmDelete!();
        }
        return true;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
      background: _SwipeActionBackground(
        isStart: true,
        color: successColor.withValues(alpha: 0.14),
        borderColor: successColor.withValues(alpha: 0.4),
        foregroundColor: successColor,
        icon: isMuted ? Icons.undo_rounded : Icons.check_circle_outline_rounded,
        label: task.isCancelled
            ? l10n.restoreTaskLabel
            : (task.isCompleted ? l10n.uncompleteLabel : l10n.completedLabel),
        bottomMargin: bottomGap,
      ),
      secondaryBackground: _SwipeActionBackground(
        isStart: false,
        color: colorScheme.error.withValues(alpha: 0.14),
        borderColor: colorScheme.error.withValues(alpha: 0.4),
        foregroundColor: colorScheme.error,
        icon: Icons.delete_outline_rounded,
        label: l10n.delete,
        bottomMargin: bottomGap,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _TimelineTimeColumn(
              timeLabel: _hasStartTime ? task.startTime!.trim() : null,
              isMuted: isMuted,
            ),
            _TimelineRail(
              nodeColor: task.isCancelled ? mutedGrey : tagColor,
              lineColor: colorScheme.outline,
              isMuted: isMuted,
              showTopLine: !isFirstInSection,
              showBottomLine: !isLastInSection,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomGap),
                child: _TaskCard(
                  task: task,
                  tagColor: tagColor,
                  priorityColor: priorityColor,
                  tag: tag,
                  project: project,
                  onTap: onTap,
                  onToggleComplete: onToggleComplete,
                  onToggleCancel: onToggleCancel,
                  onToggleChecklistItem: onToggleChecklistItem,
                  onCancelChecklistItem: onCancelChecklistItem,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SwipeActionBackground extends StatelessWidget {
  const _SwipeActionBackground({
    required this.isStart,
    required this.color,
    required this.borderColor,
    required this.foregroundColor,
    required this.icon,
    required this.label,
    required this.bottomMargin,
  });

  final bool isStart;
  final Color color;
  final Color borderColor;
  final Color foregroundColor;
  final IconData icon;
  final String label;
  final double bottomMargin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAmoled = AppTheme.isAmoled(theme);

    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: isStart
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: isAmoled ? Border.all(color: borderColor, width: 1) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isStart) ...[
            Icon(icon, color: foregroundColor, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (!isStart) ...[
            const SizedBox(width: 8),
            Icon(icon, color: foregroundColor, size: 20),
          ],
        ],
      ),
    );
  }
}

class _TimelineTimeColumn extends StatelessWidget {
  const _TimelineTimeColumn({
    required this.timeLabel,
    required this.isMuted,
  });

  final String? timeLabel;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 48,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 15, end: 6),
        child: Align(
          alignment: AlignmentDirectional.topEnd,
          child: timeLabel != null
              ? Text(
                  timeLabel!,
                  maxLines: 1,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: isMuted
                        ? colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
                        : colorScheme.onSurface,
                  ),
                )
              : Icon(
                  Icons.wb_sunny_outlined,
                  size: 15,
                  color: colorScheme.onSurfaceVariant.withValues(
                    alpha: isMuted ? 0.4 : 0.75,
                  ),
                ),
        ),
      ),
    );
  }
}

class _TimelineRail extends StatelessWidget {
  const _TimelineRail({
    required this.nodeColor,
    required this.lineColor,
    required this.isMuted,
    required this.showTopLine,
    required this.showBottomLine,
  });

  final Color nodeColor;
  final Color lineColor;
  final bool isMuted;
  final bool showTopLine;
  final bool showBottomLine;

  @override
  Widget build(BuildContext context) {
    final surfaceColor = Theme.of(context).colorScheme.surface;

    return SizedBox(
      width: 16,
      child: Column(
        children: [
          Container(
            width: 1.5,
            height: 18,
            color: showTopLine ? lineColor : Colors.transparent,
          ),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isMuted ? surfaceColor : nodeColor,
              border: Border.all(
                color: isMuted ? nodeColor.withValues(alpha: 0.5) : nodeColor,
                width: 2,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: 1.5,
              color: showBottomLine ? lineColor : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.tagColor,
    required this.priorityColor,
    this.tag,
    this.project,
    required this.onTap,
    required this.onToggleComplete,
    this.onToggleCancel,
    required this.onToggleChecklistItem,
    this.onCancelChecklistItem,
  });

  final TaskModel task;
  final Color tagColor;
  final Color priorityColor;
  final TagModel? tag;
  final ProjectModel? project;
  final VoidCallback onTap;
  final VoidCallback onToggleComplete;
  final VoidCallback? onToggleCancel;
  final ValueChanged<int> onToggleChecklistItem;
  final ValueChanged<int>? onCancelChecklistItem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final hasDescription = task.description.trim().isNotEmpty;
    final visibleChecklistEntries = <(int, ChecklistItem)>[
      for (var i = 0; i < task.checklistItems.length; i++)
        if (!task.checklistItems[i].isCancelled) (i, task.checklistItems[i]),
    ];
    final hasChecklist = visibleChecklistEntries.isNotEmpty;
    final completedSubtasks =
        visibleChecklistEntries.where((entry) => entry.$2.isDone).length;
    final totalActiveSubtasks = visibleChecklistEntries.length;
    final reminderLabel =
        localizedReminderShortLabel(l10n, task.reminderMinutesBefore);
    final isCancelled = task.isCancelled;
    final isMuted = task.isCompleted || isCancelled;
    final mutedNeutral = colorScheme.onSurfaceVariant.withValues(alpha: 0.6);

    final cardColor = isCancelled
        ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.7)
        : task.isCompleted
            ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.55)
            : colorScheme.surfaceContainerLow;

    return Material(
      color: cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: AppTheme.cardBorderSide(theme),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(4, 6, 14, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CircularTaskCheckbox(
                    isCompleted: task.isCompleted,
                    isCancelled: isCancelled,
                    activeColor: tagColor,
                    onTap: onToggleComplete,
                    onLongPress: onToggleCancel,
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
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontSize: 15.5,
                                    height: 1.35,
                                    decoration: isMuted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    decorationColor: isCancelled
                                        ? colorScheme.onSurfaceVariant
                                            .withValues(alpha: 0.55)
                                        : colorScheme.onSurfaceVariant,
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
                              _PriorityIndicator(
                                priority: task.priority,
                                color: isCancelled ? mutedNeutral : priorityColor,
                                isMuted: isMuted,
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
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                          if ((task.hasActiveReminder &&
                                  reminderLabel != null) ||
                              task.isRepeating ||
                              tag != null ||
                              project != null) ...[
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                if (tag != null)
                                  _TagPill(
                                    tag: tag!,
                                    isMuted: isMuted,
                                    isGreyed: isCancelled,
                                  ),
                                if (project != null)
                                  _ProjectLabel(
                                    project: project!,
                                    isMuted: isMuted,
                                  ),
                                if (task.hasActiveReminder &&
                                    reminderLabel != null)
                                  _ReminderIndicator(
                                    label: reminderLabel,
                                    isMuted: isMuted,
                                  ),
                                if (task.isRepeating)
                                  _RepeatIndicator(isMuted: isMuted),
                              ],
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
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.checklist_rounded,
                      size: 14,
                      color: isCancelled
                          ? mutedNeutral
                          : colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.subtasksCount(
                        completedSubtasks,
                        totalActiveSubtasks,
                      ),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isCancelled
                            ? mutedNeutral
                            : colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: totalActiveSubtasks == 0
                              ? 0.0
                              : completedSubtasks / totalActiveSubtasks,
                          minHeight: 5,
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isCancelled
                                ? mutedNeutral
                                : task.isCompleted
                                    ? tagColor.withValues(alpha: 0.5)
                                    : tagColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...visibleChecklistEntries.map((entry) {
                final (originalIndex, item) = entry;
                return _InlineChecklistRow(
                  key: ValueKey('subtask_item_${task.id ?? 'x'}_$originalIndex'),
                  taskId: task.id,
                  itemIndex: originalIndex,
                  item: item,
                  accentColor: isCancelled ? mutedNeutral : tagColor,
                  isParentCancelled: isCancelled,
                  onTap: () => onToggleChecklistItem(originalIndex),
                  onLongPressCancel: onCancelChecklistItem != null
                      ? () => onCancelChecklistItem!(originalIndex)
                      : null,
                );
              }),
              const SizedBox(height: 4),
            ],
          ],
        ),
      ),
    );
  }
}

class _CircularTaskCheckbox extends StatelessWidget {
  const _CircularTaskCheckbox({
    required this.isCompleted,
    required this.isCancelled,
    required this.activeColor,
    required this.onTap,
    this.onLongPress,
  });

  final bool isCompleted;
  final bool isCancelled;
  final Color activeColor;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final checkColor =
        brightness == Brightness.dark ? const Color(0xFF0A0A0A) : Colors.white;
    final cancelledFill = brightness == Brightness.dark
        ? const Color(0xFF52525B)
        : const Color(0xFF71717A);
    final cancelledIconColor =
        brightness == Brightness.dark ? const Color(0xFFFAFAFA) : Colors.white;
    final l10n = AppLocalizations.of(context);

    final semanticLabel = isCancelled
        ? l10n.restoreTaskLabel
        : (isCompleted
            ? l10n.markUncompletedSemantics
            : l10n.markCompletedSemantics);

    return Semantics(
      button: true,
      checked: isCompleted,
      label: semanticLabel,
      child: SizedBox(
        width: 48,
        height: 48,
        child: InkWell(
          key: const ValueKey('task_status_circle'),
          onTap: onTap,
          onLongPress: onLongPress != null
              ? () {
                  HapticFeedback.mediumImpact();
                  onLongPress!();
                }
              : null,
          customBorder: const CircleBorder(),
          child: Center(
            child: ZettaskSpringCheckBounce(
              stateKey: (isCompleted, isCancelled),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                curve: ZettaskSpringCurve.snappy,
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCancelled
                      ? cancelledFill
                      : (isCompleted ? activeColor : Colors.transparent),
                  border: Border.all(
                    color: isCancelled ? cancelledFill : activeColor,
                    width: 2,
                  ),
                ),
                child: isCancelled
                    ? Icon(
                        Icons.close_rounded,
                        size: 15,
                        color: cancelledIconColor,
                      )
                    : isCompleted
                        ? Icon(
                            Icons.check_rounded,
                            size: 15,
                            color: checkColor,
                          )
                        : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReminderIndicator extends StatelessWidget {
  const _ReminderIndicator({
    required this.label,
    required this.isMuted,
  });

  final String label;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final foregroundColor = isMuted
        ? colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
        : colorScheme.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.notifications_none_rounded,
          size: 13,
          color: foregroundColor,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: foregroundColor,
            fontWeight: FontWeight.w600,
            fontSize: 11,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill({
    required this.tag,
    required this.isMuted,
    this.isGreyed = false,
  });

  final TagModel tag;
  final bool isMuted;
  final bool isGreyed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final resolved = isGreyed
        ? colorScheme.onSurfaceVariant
        : AppTheme.resolveTagColor(tag.colorHex, theme.brightness);
    final fg = isMuted ? resolved.withValues(alpha: 0.55) : resolved;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
      decoration: BoxDecoration(
        color: resolved.withValues(alpha: isMuted ? 0.08 : 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        tag.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.labelSmall?.copyWith(
          color: fg,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _ProjectLabel extends StatelessWidget {
  const _ProjectLabel({
    required this.project,
    required this.isMuted,
  });

  final ProjectModel project;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final fg = isMuted
        ? colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
        : colorScheme.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.folder_outlined,
          size: 12,
          color: fg,
        ),
        const SizedBox(width: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 110),
          child: Text(
            project.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}

class _RepeatIndicator extends StatelessWidget {
  const _RepeatIndicator({required this.isMuted});

  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = isMuted
        ? colorScheme.onSurfaceVariant.withValues(alpha: 0.5)
        : colorScheme.onSurfaceVariant;

    return Icon(
      Icons.repeat_rounded,
      size: 13,
      color: foregroundColor,
      semanticLabel: AppLocalizations.of(context).repeatingTaskLabel,
    );
  }
}

class _PriorityIndicator extends StatelessWidget {
  const _PriorityIndicator({
    required this.priority,
    required this.color,
    required this.isMuted,
  });

  final TaskPriority priority;
  final Color color;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isMuted ? color.withValues(alpha: 0.5) : color;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: effectiveColor.withValues(alpha: isMuted ? 0.06 : 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: effectiveColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            localizedPriorityLabel(l10n, priority),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: effectiveColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }
}

class _InlineChecklistRow extends StatefulWidget {
  const _InlineChecklistRow({
    super.key,
    required this.taskId,
    required this.itemIndex,
    required this.item,
    required this.accentColor,
    this.isParentCancelled = false,
    required this.onTap,
    this.onLongPressCancel,
  });

  final int? taskId;
  final int itemIndex;
  final ChecklistItem item;
  final Color accentColor;
  final bool isParentCancelled;
  final VoidCallback onTap;
  final VoidCallback? onLongPressCancel;

  @override
  State<_InlineChecklistRow> createState() => _InlineChecklistRowState();
}

class _InlineChecklistRowState extends State<_InlineChecklistRow> {
  bool _isCancelling = false;
  Timer? _cancelCommitTimer;

  @override
  void didUpdateWidget(covariant _InlineChecklistRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item != widget.item && !widget.item.isCancelled) {
      _cancelCommitTimer?.cancel();
      _cancelCommitTimer = null;
      _isCancelling = false;
    }
  }

  @override
  void dispose() {
    _cancelCommitTimer?.cancel();
    super.dispose();
  }

  void _triggerCancel() {
    final onCancel = widget.onLongPressCancel;
    if (onCancel == null || _isCancelling) return;

    HapticFeedback.mediumImpact();
    if (MediaQuery.disableAnimationsOf(context)) {
      onCancel();
      return;
    }

    setState(() => _isCancelling = true);
    _cancelCommitTimer?.cancel();
    _cancelCommitTimer = Timer(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      onCancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final brightness = theme.brightness;
    final checkColor =
        brightness == Brightness.dark ? const Color(0xFF0A0A0A) : Colors.white;
    final cancelledFill = brightness == Brightness.dark
        ? const Color(0xFF52525B)
        : const Color(0xFF71717A);
    final cancelledIconColor =
        brightness == Brightness.dark ? const Color(0xFFFAFAFA) : Colors.white;
    final isMuted =
        widget.item.isDone || widget.isParentCancelled || _isCancelling;

    return Semantics(
      button: true,
      checked: widget.item.isDone,
      label: widget.item.title,
      child: InkWell(
        key: ValueKey(
          'subtask_row_${widget.taskId ?? 'x'}_${widget.itemIndex}',
        ),
        onTap: _isCancelling ? null : widget.onTap,
        onLongPress:
            widget.onLongPressCancel != null ? _triggerCancel : null,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Row(
              children: [
                ZettaskSpringCheckBounce(
                  stateKey: (widget.item.isDone, _isCancelling),
                  child: AnimatedContainer(
                    key: ValueKey(
                      'subtask_circle_${widget.taskId ?? 'x'}_${widget.itemIndex}',
                    ),
                    duration: const Duration(milliseconds: 200),
                    curve: ZettaskSpringCurve.snappy,
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        _isCancelling ? 999 : 7,
                      ),
                      color: _isCancelling
                          ? cancelledFill
                          : (widget.item.isDone
                              ? widget.accentColor
                              : Colors.transparent),
                      border: Border.all(
                        color: _isCancelling
                            ? cancelledFill
                            : (widget.item.isDone
                                ? widget.accentColor
                                : colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.6)),
                        width: 1.75,
                      ),
                    ),
                    child: _isCancelling
                        ? Icon(
                            Icons.close_rounded,
                            size: 13,
                            color: cancelledIconColor,
                          )
                        : widget.item.isDone
                            ? Icon(
                                Icons.check_rounded,
                                size: 13,
                                color: checkColor,
                              )
                            : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.item.title,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13.5,
                      decoration: isMuted ? TextDecoration.lineThrough : null,
                      decorationColor: colorScheme.onSurfaceVariant,
                      color: isMuted
                          ? colorScheme.onSurfaceVariant.withValues(alpha: 0.65)
                          : colorScheme.onSurface,
                    ),
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
