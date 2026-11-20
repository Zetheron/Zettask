import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/task_provider.dart';

class TimelineOptionsSheet extends StatelessWidget {
  const TimelineOptionsSheet({
    super.key,
    required this.onOpenOverdue,
  });

  final VoidCallback onOpenOverdue;

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onOpenOverdue,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => TimelineOptionsSheet(onOpenOverdue: onOpenOverdue),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Consumer<TaskProvider>(
      builder: (context, taskProvider, _) {
        final overdueCount = taskProvider.overdueCount;

        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.outline,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 8, 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.timelineOptionsTitle,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 19,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: l10n.close,
                        onPressed: () => Navigator.of(context).pop(),
                        style: IconButton.styleFrom(
                          minimumSize: const Size(48, 48),
                        ),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.viewModeLabel,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _ViewModeSegmentedControl(
                        selectedMode: taskProvider.viewMode,
                        onChanged: taskProvider.setViewMode,
                      ),
                      const SizedBox(height: 14),
                      Text(
                        l10n.firstDayOfWeek,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 12.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _FirstDaySegmentedControl(
                        firstDayOfWeek: taskProvider.firstDayOfWeek,
                        onChanged: taskProvider.setFirstDayOfWeek,
                      ),
                      const SizedBox(height: 14),
                      Material(
                        color: colorScheme.surfaceContainerHighest,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(color: colorScheme.outline, width: 1),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: SwitchListTile(
                          value: taskProvider.showCompletedTasks,
                          onChanged: taskProvider.setShowCompletedTasks,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 2,
                          ),
                          title: Text(
                            l10n.showCompletedTasks,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 14.5,
                            ),
                          ),
                          subtitle: Text(
                            l10n.showCompletedTasksSubtitle,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Material(
                        color: colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(color: colorScheme.outline, width: 1),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            onOpenOverdue();
                          },
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(minHeight: 56),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.history_rounded,
                                    size: 20,
                                    color: overdueCount > 0
                                        ? colorScheme.error
                                        : colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      l10n.overdueTasksTitle,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(fontSize: 14.5),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 9,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: overdueCount > 0
                                          ? colorScheme.error
                                              .withValues(alpha: 0.14)
                                          : colorScheme.surfaceContainerHighest,
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      '$overdueCount',
                                      style: theme.textTheme.labelMedium
                                          ?.copyWith(
                                        color: overdueCount > 0
                                            ? colorScheme.error
                                            : colorScheme.onSurfaceVariant,
                                        fontFeatures: const [
                                          FontFeature.tabularFigures(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    size: 20,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ViewModeSegmentedControl extends StatelessWidget {
  const _ViewModeSegmentedControl({
    required this.selectedMode,
    required this.onChanged,
  });

  final TimelineViewMode selectedMode;
  final ValueChanged<TimelineViewMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.outline, width: 1),
      ),
      child: Row(
        children: TimelineViewMode.values.map((mode) {
          final isSelected = selectedMode == mode;
          final label = mode == TimelineViewMode.timeline
              ? l10n.modeTimeline
              : l10n.modeDaily;
          return Expanded(
            child: Material(
              color: isSelected ? colorScheme.surface : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: isSelected
                    ? BorderSide(color: colorScheme.outline, width: 1)
                    : BorderSide.none,
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => onChanged(mode),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 44),
                  child: Center(
                    child: Text(
                      label,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontSize: 13.5,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FirstDaySegmentedControl extends StatelessWidget {
  const _FirstDaySegmentedControl({
    required this.firstDayOfWeek,
    required this.onChanged,
  });

  final int firstDayOfWeek;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.outline, width: 1),
      ),
      child: Row(
        children: [
          for (final option in [
            (DateTime.monday, l10n.monday),
            (DateTime.sunday, l10n.sunday),
          ])
            Expanded(
              child: Material(
                color: firstDayOfWeek == option.$1
                    ? colorScheme.surface
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: firstDayOfWeek == option.$1
                      ? BorderSide(color: colorScheme.outline, width: 1)
                      : BorderSide.none,
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => onChanged(option.$1),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 44),
                    child: Center(
                      child: Text(
                        option.$2,
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontSize: 13.5,
                          fontWeight: firstDayOfWeek == option.$1
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: firstDayOfWeek == option.$1
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
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
