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
import '../widgets/task_editor_sheet.dart';

class RepeatingTasksScreen extends StatelessWidget {
  const RepeatingTasksScreen({super.key});

  Future<void> _openRuleEditor(
    BuildContext context, {
    RepeatingTaskRule? rule,
  }) async {
    final taskProvider = context.read<TaskProvider>();
    final result = await TaskEditorSheet.show(
      context,
      initialRepeatingRule: rule,
      defaultDate: rule?.startDate ?? taskProvider.currentToday,
      allowRepeatPicker: true,
      requireRepeat: true,
      onRequestNotificationPermission:
          taskProvider.requestNotificationPermission,
    );

    if (!context.mounted || result == null) return;

    switch (result) {
      case TaskEditorSaved(:final task, :final repeatConfig):
        final frequency =
            repeatConfig?.frequency ?? rule?.frequency ?? RepeatFrequency.daily;
        final weekdays = frequency == RepeatFrequency.weekly
            ? (repeatConfig?.weekdays ??
                rule?.effectiveWeekdays ??
                [(task.date ?? taskProvider.currentToday).weekday])
            : const <int>[];
        final checklistTemplate = task.checklistItems
            .map((item) => ChecklistItem(title: item.title, isDone: false))
            .toList();

        if (rule == null) {
          final newRule = RepeatingTaskRule(
            title: task.title,
            description: task.description,
            startTime: task.startTime,
            priority: task.priority,
            colorHex: task.colorHex,
            checklistItems: checklistTemplate,
            reminderMinutesBefore: task.reminderMinutesBefore,
            frequency: frequency,
            weekdays: weekdays,
            startDate: task.date ?? taskProvider.currentToday,
            projectId: task.projectId,
            tagId: task.tagId,
          );
          await taskProvider.addRepeatingTask(newRule);
        } else {
          final updatedRule = rule.copyWith(
            title: task.title,
            description: task.description,
            startTime: task.startTime,
            clearStartTime: !task.hasStartTime,
            priority: task.priority,
            colorHex: task.colorHex,
            checklistItems: checklistTemplate,
            reminderMinutesBefore: task.reminderMinutesBefore,
            clearReminder: task.reminderMinutesBefore == null,
            frequency: frequency,
            weekdays: weekdays,
            startDate: task.date ?? rule.startDate,
            projectId: task.projectId,
            clearProject: task.projectId == null,
            tagId: task.tagId,
            clearTag: task.tagId == null,
          );
          await taskProvider.updateRepeatingRuleFromManager(updatedRule);
        }
      case TaskEditorDeleted():
        if (rule?.id != null) {
          await taskProvider.deleteRepeatingRuleFromManager(rule!.id!);
          if (context.mounted) {
            final l10n = AppLocalizations.of(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(l10n.repeatingTaskDeleted),
                ),
              );
          }
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        final rules = taskProvider.repeatingRules;
        final today = taskProvider.currentToday;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.repeatingTasksTitle),
          ),
          body: SafeArea(
            child: rules.isEmpty
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
                              Icons.repeat_rounded,
                              size: 26,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            l10n.noRepeatingTasks,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.noRepeatingTasksSubtitle,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
                    itemCount: rules.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final rule = rules[index];
                      final stats = rule.id != null
                          ? taskProvider.statsForRule(rule.id!)
                          : RepeatingTaskStats.empty();

                      return _RepeatingRuleCard(
                        rule: rule,
                        stats: stats,
                        today: today,
                        onTap: () => _openRuleEditor(context, rule: rule),
                      );
                    },
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'repeating_rules_fab',
            onPressed: () => _openRuleEditor(context),
            tooltip: l10n.addRepeatingTaskTooltip,
            child: const Icon(Icons.add_rounded),
          ),
        );
      },
    );
  }
}

class _RepeatingRuleCard extends StatelessWidget {
  const _RepeatingRuleCard({
    required this.rule,
    required this.stats,
    required this.today,
    required this.onTap,
  });

  final RepeatingTaskRule rule;
  final RepeatingTaskStats stats;
  final DateTime today;
  final VoidCallback onTap;

  String? _formatNextBadge(
    DateTime? nextDate,
    AppLocalizations l10n,
    String intlLocale,
  ) {
    if (nextDate == null) return null;
    final diff = TaskProvider.normalizeDate(nextDate)
        .difference(TaskProvider.normalizeDate(today))
        .inDays;
    if (diff == 0) return l10n.today;
    if (diff == 1) return l10n.tomorrow;
    try {
      return DateFormat('EEE, d MMM', intlLocale).format(nextDate);
    } catch (_) {
      return DateFormat('EEE, d MMM').format(nextDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
    final tagColor = AppTheme.resolveTagColor(rule.colorHex, theme.brightness);
    final nextDate = rule.nextOccurrenceFrom(today);
    final nextBadge = _formatNextBadge(nextDate, l10n, intlLocale);
    final isTodayBadge = nextDate != null &&
        TaskProvider.normalizeDate(nextDate) ==
            TaskProvider.normalizeDate(today);
    final reminderLabel =
        localizedReminderShortLabel(l10n, rule.reminderMinutesBefore);

    return Material(
      color: colorScheme.surface,
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
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            color: tagColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          rule.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 15.5,
                            height: 1.3,
                          ),
                        ),
                      ),
                      if (nextBadge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: isTodayBadge
                                ? colorScheme.primaryContainer
                                : colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isTodayBadge
                                  ? colorScheme.primary.withValues(alpha: 0.35)
                                  : colorScheme.outline,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            nextBadge,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isTodayBadge
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 4,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.repeat_rounded,
                            size: 13,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            localizedRuleScheduleSummary(
                              l10n,
                              intlLocale,
                              rule,
                            ),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      if (rule.hasActiveReminder && reminderLabel != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.notifications_none_rounded,
                              size: 13,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              reminderLabel,
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      if (rule.checklistItems.isNotEmpty)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.checklist_rounded,
                              size: 13,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              l10n.subtasksTotalCount(
                                rule.checklistItems.length,
                              ),
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: colorScheme.outline.withValues(alpha: 0.75),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              child: rule.frequency == RepeatFrequency.daily
                  ? _DailyProgressSection(
                      stats: stats,
                      accentColor: tagColor,
                    )
                  : _AllTimeProgressSection(
                      completedCount: stats.allTimeCompleted,
                      accentColor: tagColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyProgressSection extends StatelessWidget {
  const _DailyProgressSection({
    required this.stats,
    required this.accentColor,
  });

  final RepeatingTaskStats stats;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final statuses = stats.last30DaysStatus.length == 30
        ? stats.last30DaysStatus
        : List<bool>.filled(30, false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              l10n.last30DaysSubtitle,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              l10n.completedCountLabel(stats.last30DaysCompletedCount),
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          key: const ValueKey('thirty_day_dot_tracker'),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(statuses.length, (index) {
            final isDone = statuses[index];
            return Expanded(
              child: Center(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDone
                        ? accentColor
                        : colorScheme.outline.withValues(alpha: 0.75),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _AllTimeProgressSection extends StatelessWidget {
  const _AllTimeProgressSection({
    required this.completedCount,
    required this.accentColor,
  });

  final int completedCount;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Text(
          l10n.allTimeSubtitle,
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: completedCount > 0 ? accentColor : colorScheme.outline,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          l10n.completedCountLabel(completedCount),
          style: theme.textTheme.labelSmall?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
