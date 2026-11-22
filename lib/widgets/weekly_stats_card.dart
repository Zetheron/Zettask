import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/stats_model.dart';
import '../providers/locale_provider.dart';
import 'zettask_motion.dart';

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

    return ZettaskSpringTap(
      pressedScale: 0.98,
      child: Material(
        color: colorScheme.surfaceContainerLow,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: AppTheme.cardBorderSide(theme),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(18, 14, 16, 14),
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.7,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${stats.totalTasks7Days}',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.8,
                              height: 1.08,
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHigh,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 19,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 80,
                  child: Row(
                    key: const ValueKey('weekly_stats_bars'),
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(days.length, (index) {
                      final dayStat = days[index];
                      final isToday = index == days.length - 1;
                      final ratio = dayStat.completedTasks / maxTasks;
                      final barHeight = dayStat.completedTasks == 0
                          ? 6.0
                          : (10.0 + ratio * 42.0);
                      final barColor = dayStat.completedTasks == 0
                          ? colorScheme.surfaceContainerHighest
                          : isToday
                              ? colorScheme.primary
                              : colorScheme.primary.withValues(alpha: 0.55);

                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 280),
                              curve: ZettaskSpringCurve.snappy,
                              width: 18,
                              height: barHeight,
                              decoration: BoxDecoration(
                                color: barColor,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                  bottom: Radius.circular(3),
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
      ),
    );
  }
}
