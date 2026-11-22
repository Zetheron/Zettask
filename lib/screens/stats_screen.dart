import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/stats_model.dart';
import '../models/task_model.dart';
import '../providers/locale_provider.dart';
import '../providers/workspace_provider.dart';
import '../widgets/zettask_loaders.dart';
import '../widgets/zettask_motion.dart';

enum StatsRange {
  last7Days,
  last30Days,
}

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  StatsRange _range = StatsRange.last7Days;
  int _selectedDayIndex = 6;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _chart30ScrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    _chart30ScrollController.dispose();
    super.dispose();
  }

  void _switchRange(StatsRange nextRange) {
    if (_range == nextRange) return;
    setState(() {
      _range = nextRange;
      _selectedDayIndex = nextRange == StatsRange.last7Days ? 6 : 29;
    });
    if (nextRange == StatsRange.last30Days) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_chart30ScrollController.hasClients) return;
        _chart30ScrollController.jumpTo(
          _chart30ScrollController.position.maxScrollExtent,
        );
      });
    }
  }

  String _weekdayShort(DateTime date, String localeTag) {
    try {
      return DateFormat('EEE', localeTag).format(date);
    } catch (_) {
      return DateFormat('EEE').format(date);
    }
  }

  String _formatFullDay(DateTime date, String localeTag) {
    try {
      return DateFormat('EEE, d MMM yyyy', localeTag).format(date);
    } catch (_) {
      return DateFormat('EEE, d MMM yyyy').format(date);
    }
  }

  String _priorityLabel(TaskPriority priority, AppLocalizations l10n) {
    return switch (priority) {
      TaskPriority.low => l10n.priorityLow,
      TaskPriority.medium => l10n.priorityMedium,
      TaskPriority.high => l10n.priorityHigh,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final localeTag =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));

    return Consumer<WorkspaceProvider>(
      builder: (context, workspaceProvider, _) {
        final stats = workspaceProvider.stats;
        final is30Days = _range == StatsRange.last30Days;
        final days = is30Days ? stats.last30Days : stats.last7Days;
        final rangeTasks =
            is30Days ? stats.totalTasks30Days : stats.totalTasks7Days;
        final rangeChecklists =
            is30Days ? stats.totalChecklists30Days : stats.totalChecklists7Days;

        final safeIndex = days.isEmpty
            ? 0
            : _selectedDayIndex.clamp(0, days.length - 1);
        final selectedDay = days.isNotEmpty ? days[safeIndex] : null;
        final maxTasks = days.fold<int>(
          1,
          (prev, stat) => math.max(prev, stat.completedTasks),
        );
        final maxPriorityCount = stats.breakdownByPriority.values.fold<int>(
          1,
          (prev, count) => math.max(prev, count),
        );

        final isAmoled = AppTheme.isAmoled(theme);
        final cardDecoration = BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
          border: isAmoled
              ? Border.all(color: colorScheme.outline, width: 1)
              : null,
        );

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.statsTitle),
          ),
          body: SafeArea(
            child: workspaceProvider.isLoading
                ? const ZettaskTaskListSkeleton()
                : ListView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
              children: [
                SegmentedButton<StatsRange>(
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment<StatsRange>(
                      value: StatsRange.last7Days,
                      label: Text(l10n.range7Days),
                    ),
                    ButtonSegment<StatsRange>(
                      value: StatsRange.last30Days,
                      label: Text(l10n.range30Days),
                    ),
                  ],
                  selected: {_range},
                  onSelectionChanged: (selection) {
                    if (selection.isNotEmpty) {
                      _switchRange(selection.first);
                    }
                  },
                ),
                const SizedBox(height: 16),
                ZettaskStackingCard(
                  scrollController: _scrollController,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _MetricCard(
                              label: l10n.completedToday,
                              value: '${stats.completedToday}',
                              accentColor: isAmoled
                                  ? colorScheme.primary
                                  : colorScheme.onPrimaryContainer,
                              surfaceColor: isAmoled
                                  ? colorScheme.surfaceContainerLow
                                  : colorScheme.primaryContainer,
                              labelColor: isAmoled
                                  ? colorScheme.onSurfaceVariant
                                  : colorScheme.onPrimaryContainer
                                      .withValues(alpha: 0.8),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _MetricCard(
                              label: is30Days
                                  ? l10n.last30DaysLabel
                                  : l10n.last7DaysLabel,
                              value: '$rangeTasks',
                              accentColor: isAmoled
                                  ? colorScheme.secondary
                                  : colorScheme.onSecondaryContainer,
                              surfaceColor: isAmoled
                                  ? colorScheme.surfaceContainerLow
                                  : colorScheme.secondaryContainer,
                              labelColor: isAmoled
                                  ? colorScheme.onSurfaceVariant
                                  : colorScheme.onSecondaryContainer
                                      .withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _MetricCard(
                              label: l10n.allTimeLabel,
                              value: '${stats.allTimeCompletedTasks}',
                              accentColor: colorScheme.onSurface,
                              surfaceColor: colorScheme.surfaceContainerLow,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _MetricCard(
                              label: l10n.completionRateLabel,
                              value: '${stats.completionPercentage}%',
                              accentColor: colorScheme.primary,
                              surfaceColor: colorScheme.surfaceContainerLow,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _SectionLabel(
                  title: is30Days ? l10n.activity30Days : l10n.activity7Days,
                ),
                const SizedBox(height: 8),
                ZettaskStackingCard(
                  scrollController: _scrollController,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(14, 18, 14, 16),
                    decoration: cardDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (!is30Days)
                          _SevenDayBarChart(
                            days: days,
                            selectedIndex: safeIndex,
                            maxTasks: maxTasks,
                            weekdayBuilder: (date) =>
                                _weekdayShort(date, localeTag),
                            onSelectDay: (index) =>
                                setState(() => _selectedDayIndex = index),
                          )
                        else
                          _ThirtyDayBarChart(
                            controller: _chart30ScrollController,
                            days: days,
                            selectedIndex: safeIndex,
                            maxTasks: maxTasks,
                            onSelectDay: (index) =>
                                setState(() => _selectedDayIndex = index),
                          ),
                        if (selectedDay != null) ...[
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 11,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(16),
                              border: isAmoled
                                  ? Border.all(
                                      color: colorScheme.outline,
                                      width: 1,
                                    )
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _formatFullDay(selectedDay.date, localeTag),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        theme.textTheme.labelMedium?.copyWith(
                                      fontSize: 12.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    l10n.dayDetailSummary(
                                      selectedDay.completedTasks,
                                      selectedDay.completedChecklists,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: colorScheme.onSurface,
                                      fontFeatures: const [
                                        FontFeature.tabularFigures(),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 10),
                        Text(
                          l10n.totalRangeSummary(
                            is30Days ? 30 : 7,
                            rangeTasks,
                            rangeChecklists,
                          ),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _SectionLabel(title: l10n.completedByPriority),
                const SizedBox(height: 8),
                ZettaskStackingCard(
                  scrollController: _scrollController,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration,
                    child: Column(
                      children: [
                        for (final priority in const [
                          TaskPriority.high,
                          TaskPriority.medium,
                          TaskPriority.low,
                        ])
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: priority == TaskPriority.low ? 0 : 12,
                            ),
                            child: _BreakdownRow(
                              label: _priorityLabel(priority, l10n),
                              trailing: l10n.completedCountLabel(
                                stats.breakdownByPriority[priority] ?? 0,
                              ),
                              ratio:
                                  (stats.breakdownByPriority[priority] ?? 0) /
                                      maxPriorityCount,
                              accentColor: AppTheme.priorityColor(
                                priority,
                                theme.brightness,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _SectionLabel(title: l10n.progressByProject),
                const SizedBox(height: 8),
                ZettaskStackingCard(
                  scrollController: _scrollController,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration,
                    child: stats.breakdownByProject.isEmpty
                        ? Text(
                            l10n.noProjectsCreated,
                            style: theme.textTheme.bodySmall,
                          )
                        : Column(
                            children: List.generate(
                              stats.breakdownByProject.length,
                              (index) {
                                final item = stats.breakdownByProject[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index <
                                            stats.breakdownByProject.length - 1
                                        ? 12
                                        : 0,
                                  ),
                                  child: _BreakdownRow(
                                    label: item.project.name,
                                    trailing:
                                        '${item.completedCount}/${item.totalCount} · ${item.percentage}%',
                                    ratio: item.ratio,
                                    accentColor: AppTheme.resolveTagColor(
                                      item.project.colorHex,
                                      theme.brightness,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                _SectionLabel(title: l10n.breakdownByTag),
                const SizedBox(height: 8),
                ZettaskStackingCard(
                  scrollController: _scrollController,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration,
                    child: stats.breakdownByTag.isEmpty
                        ? Text(
                            l10n.noTagsCreated,
                            style: theme.textTheme.bodySmall,
                          )
                        : Column(
                            children: List.generate(
                              stats.breakdownByTag.length,
                              (index) {
                                final item = stats.breakdownByTag[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index <
                                            stats.breakdownByTag.length - 1
                                        ? 12
                                        : 0,
                                  ),
                                  child: _BreakdownRow(
                                    label: '#${item.tag.name}',
                                    trailing: l10n.tagBreakdownTrailing(
                                      item.completedCount,
                                      item.totalCount,
                                    ),
                                    ratio: item.ratio,
                                    accentColor: AppTheme.resolveTagColor(
                                      item.tag.colorHex,
                                      theme.brightness,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                _SectionLabel(title: l10n.habits30Days),
                const SizedBox(height: 8),
                ZettaskStackingCard(
                  scrollController: _scrollController,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: cardDecoration,
                    child: stats.habitStats.isEmpty
                        ? Text(
                            l10n.noActiveHabits,
                            style: theme.textTheme.bodySmall,
                          )
                        : Column(
                            children: List.generate(
                              stats.habitStats.length,
                              (index) {
                                final habit = stats.habitStats[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: index < stats.habitStats.length - 1
                                        ? 14
                                        : 0,
                                  ),
                                  child: _HabitStatRow(
                                    habit: habit,
                                    l10n: l10n,
                                  ),
                                );
                              },
                            ),
                          ),
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

class _SevenDayBarChart extends StatelessWidget {
  const _SevenDayBarChart({
    required this.days,
    required this.selectedIndex,
    required this.maxTasks,
    required this.weekdayBuilder,
    required this.onSelectDay,
  });

  final List<DailyCompletionStat> days;
  final int selectedIndex;
  final int maxTasks;
  final String Function(DateTime date) weekdayBuilder;
  final ValueChanged<int> onSelectDay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 132,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(days.length, (index) {
          final dayStat = days[index];
          final isSelected = index == selectedIndex;
          final ratio = dayStat.completedTasks / maxTasks;
          final barHeight =
              dayStat.completedTasks == 0 ? 6.0 : (14.0 + ratio * 58.0);
          final barColor = isSelected
              ? colorScheme.primary
              : dayStat.completedTasks == 0
                  ? colorScheme.outline
                  : colorScheme.primary.withValues(alpha: 0.45);

          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => onSelectDay(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${dayStat.completedTasks}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 10.5,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      curve: ZettaskSpringCurve.snappy,
                      width: 22,
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      weekdayBuilder(dayStat.date),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 10.5,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ThirtyDayBarChart extends StatelessWidget {
  const _ThirtyDayBarChart({
    required this.controller,
    required this.days,
    required this.selectedIndex,
    required this.maxTasks,
    required this.onSelectDay,
  });

  final ScrollController controller;
  final List<DailyCompletionStat> days;
  final int selectedIndex;
  final int maxTasks;
  final ValueChanged<int> onSelectDay;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      height: 132,
      child: ListView.builder(
        key: const ValueKey('stats_30_day_chart'),
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final dayStat = days[index];
          final isSelected = index == selectedIndex;
          final ratio = dayStat.completedTasks / maxTasks;
          final barHeight =
              dayStat.completedTasks == 0 ? 5.0 : (12.0 + ratio * 60.0);
          final barColor = isSelected
              ? colorScheme.primary
              : dayStat.completedTasks == 0
                  ? colorScheme.outline
                  : colorScheme.primary.withValues(alpha: 0.45);
          final showDayLabel = isSelected ||
              index == 0 ||
              index == days.length - 1 ||
              index % 5 == 0;

          return SizedBox(
            width: 24,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => onSelectDay(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 14,
                      child: isSelected
                          ? Text(
                              '${dayStat.completedTasks}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: colorScheme.primary,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 240),
                      curve: ZettaskSpringCurve.snappy,
                      width: isSelected ? 13 : 9,
                      height: barHeight,
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(6),
                          bottom: Radius.circular(3),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 15,
                      child: showDayLabel
                          ? Text(
                              '${dayStat.date.day}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.onSurfaceVariant,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HabitStatRow extends StatelessWidget {
  const _HabitStatRow({required this.habit, required this.l10n});

  final HabitStatItem habit;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final accent =
        AppTheme.resolveTagColor(habit.rule.colorHex, theme.brightness);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.rule.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    l10n.habitCompletedRatio(
                      habit.rule.scheduleSummary,
                      habit.completedLast30Days,
                      habit.scheduledLast30Days,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 11.5),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '${habit.consistencyPercentage}%',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(habit.last30DaysStatus.length, (i) {
            final done = habit.last30DaysStatus[i];
            return Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  end: i == habit.last30DaysStatus.length - 1 ? 0 : 2,
                ),
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: done ? accent : colorScheme.outline,
                    borderRadius: BorderRadius.circular(999),
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

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4),
      child: Text(
        title,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontSize: 12.5,
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.accentColor,
    required this.surfaceColor,
    this.labelColor,
  });

  final String label;
  final String value;
  final Color accentColor;
  final Color surfaceColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isAmoled = AppTheme.isAmoled(theme);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(24),
        border: isAmoled
            ? Border.all(color: colorScheme.outline, width: 1)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.8,
              color: accentColor,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: labelColor ?? colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.label,
    required this.trailing,
    required this.ratio,
    required this.accentColor,
  });

  final String label;
  final String trailing;
  final double ratio;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              trailing,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            minHeight: 7,
            backgroundColor: colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation<Color>(accentColor),
          ),
        ),
      ],
    );
  }
}
