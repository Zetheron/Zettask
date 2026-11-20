import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../l10n/app_localizations.dart';
import '../models/stats_model.dart';
import '../providers/locale_provider.dart';

class WeeklyStatsCard extends StatelessWidget {
  const WeeklyStatsCard({
    super.key,
    required this.stats,
    required this.onTap,
  });

  final WorkspaceStats stats;
  final VoidCallback onTap;

  String _weekdayInitial(DateTime date, String localeTag) {
    try {
      return DateFormat('EEEEE', localeTag).format(date).toUpperCase();
    } catch (_) {
      return DateFormat('EEEEE').format(date).toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final localeTag =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
    final days = stats.last7Days;
    final maxTasks = days.fold<int>(
      1,
      (prev, stat) => math.max(prev, stat.completedTasks),
    );

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
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 14, 14, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.last7DaysUpper,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.7,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${stats.totalTasks7Days}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 20,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 84,
                child: Row(
                  key: const ValueKey('weekly_stats_bars'),
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(days.length, (index) {
                    final dayStat = days[index];
                    final isToday = index == days.length - 1;
                    final ratio = dayStat.completedTasks / maxTasks;
                    final barHeight = dayStat.completedTasks == 0
                        ? 4.0
                        : (8.0 + ratio * 44.0);
                    final barColor = dayStat.completedTasks == 0
                        ? colorScheme.outline
                        : isToday
                            ? colorScheme.primary
                            : colorScheme.primary.withValues(alpha: 0.6);

                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 220),
                            curve: Curves.easeOutCubic,
                            width: 16,
                            height: barHeight,
                            decoration: BoxDecoration(
                              color: barColor,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(5),
                                bottom: Radius.circular(2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _weekdayInitial(dayStat.date, localeTag),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 11,
                              fontWeight:
                                  isToday ? FontWeight.w700 : FontWeight.w500,
                              color: isToday
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.weeklySummary(
                  stats.totalTasks7Days,
                  stats.totalChecklists7Days,
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
