import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../l10n/l10n_helpers.dart';
import '../models/calendar_event_model.dart';
import '../providers/locale_provider.dart';

class TimelineCalendarEventItem extends StatelessWidget {
  const TimelineCalendarEventItem({
    super.key,
    required this.event,
    required this.isFirstInSection,
    required this.isLastInSection,
    this.calendarName,
    this.calendarAccount,
    this.onTap,
  });

  final CalendarEventModel event;
  final bool isFirstInSection;
  final bool isLastInSection;
  final String? calendarName;
  final String? calendarAccount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final eventColor = AppTheme.resolveTagColor(
      event.colorHex,
      theme.brightness,
    );
    final bottomGap = isLastInSection ? 4.0 : 12.0;
    final resolvedCalendarName = (calendarName ?? event.calendarName)?.trim();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _EventTimeColumn(
            timeLabel: event.isAllDay ? null : event.startTimeFormatted,
          ),
          _EventTimelineRail(
            nodeColor: eventColor,
            lineColor: colorScheme.outline,
            showTopLine: !isFirstInSection,
            showBottomLine: !isLastInSection,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: bottomGap),
              child: _CalendarEventCard(
                event: event,
                calendarName: resolvedCalendarName,
                accentColor: eventColor,
                onTap: onTap ??
                    () => CalendarEventDetailSheet.show(
                          context,
                          event: event,
                          calendarName: resolvedCalendarName,
                          calendarAccount: calendarAccount,
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventTimeColumn extends StatelessWidget {
  const _EventTimeColumn({required this.timeLabel});

  final String? timeLabel;

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
                    color: colorScheme.onSurfaceVariant,
                  ),
                )
              : Icon(
                  Icons.event_outlined,
                  size: 15,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                ),
        ),
      ),
    );
  }
}

class _EventTimelineRail extends StatelessWidget {
  const _EventTimelineRail({
    required this.nodeColor,
    required this.lineColor,
    required this.showTopLine,
    required this.showBottomLine,
  });

  final Color nodeColor;
  final Color lineColor;
  final bool showTopLine;
  final bool showBottomLine;

  @override
  Widget build(BuildContext context) {
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
              borderRadius: BorderRadius.circular(3),
              color: nodeColor.withValues(alpha: 0.2),
              border: Border.all(
                color: nodeColor,
                width: 1.75,
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

class _CalendarEventCard extends StatelessWidget {
  const _CalendarEventCard({
    required this.event,
    required this.calendarName,
    required this.accentColor,
    required this.onTap,
  });

  final CalendarEventModel event;
  final String? calendarName;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final hasLocation = event.location.trim().isNotEmpty;
    final badgeText = (calendarName != null && calendarName!.isNotEmpty)
        ? calendarName!
        : l10n.calendarBadgeLabel;

    return Material(
      color: colorScheme.surfaceContainer,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: AppTheme.cardBorderSide(theme),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4,
                color: accentColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(14, 12, 14, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 12,
                            color: accentColor,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              localizedEventTimeRange(l10n, event),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.5,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 140),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: accentColor.withValues(alpha: 0.14),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: accentColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      badgeText,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        color: accentColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        event.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.5,
                          height: 1.35,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      if (hasLocation) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 13,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                event.location.trim(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}

class CalendarEventDetailSheet extends StatelessWidget {
  const CalendarEventDetailSheet({
    super.key,
    required this.event,
    this.calendarName,
    this.calendarAccount,
  });

  final CalendarEventModel event;
  final String? calendarName;
  final String? calendarAccount;

  static Future<void> show(
    BuildContext context, {
    required CalendarEventModel event,
    String? calendarName,
    String? calendarAccount,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => CalendarEventDetailSheet(
        event: event,
        calendarName: calendarName,
        calendarAccount: calendarAccount,
      ),
    );
  }

  String _formatEventDate(DateTime date, String intlLocale) {
    try {
      return DateFormat('EEEE, d MMMM yyyy', intlLocale).format(date);
    } catch (_) {
      return DateFormat('EEEE, d MMMM yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final intlLocale =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
    final accentColor = AppTheme.resolveTagColor(
      event.colorHex,
      theme.brightness,
    );
    final resolvedCalendarName = (calendarName ?? event.calendarName)?.trim();
    final resolvedAccount = calendarAccount?.trim();
    final hasCalendarSource =
        resolvedCalendarName != null && resolvedCalendarName.isNotEmpty;
    final hasSeparateAccount = resolvedAccount != null &&
        resolvedAccount.isNotEmpty &&
        resolvedAccount != resolvedCalendarName;
    final hasLocation = event.location.trim().isNotEmpty;
    final hasDescription = event.description.trim().isNotEmpty;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.8;

    return SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
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
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.eventDetailTitle,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 13,
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
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      event.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _DetailInfoRow(
                      icon: Icons.schedule_rounded,
                      text:
                          '${_formatEventDate(event.start, intlLocale)}\n${localizedEventTimeRange(l10n, event)}',
                    ),
                    if (hasCalendarSource) ...[
                      const SizedBox(height: 12),
                      _DetailInfoRow(
                        icon: Icons.calendar_month_outlined,
                        iconColor: accentColor,
                        label: l10n.calendarSourceLabel,
                        text: hasSeparateAccount
                            ? '$resolvedCalendarName\n$resolvedAccount'
                            : resolvedCalendarName,
                      ),
                    ],
                    if (hasLocation) ...[
                      const SizedBox(height: 12),
                      _DetailInfoRow(
                        icon: Icons.location_on_outlined,
                        label: l10n.calendarLocationLabel,
                        text: event.location.trim(),
                      ),
                    ],
                    if (hasDescription) ...[
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 14),
                      Text(
                        l10n.eventNotesLabel,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        event.description.trim(),
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(18),
                        border: AppTheme.isAmoled(theme)
                            ? Border.all(color: colorScheme.outline, width: 1)
                            : null,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 1),
                            child: Icon(
                              Icons.lock_outline_rounded,
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l10n.calendarReadOnlyInfo,
                              style: theme.textTheme.bodySmall?.copyWith(
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: Text(l10n.close),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailInfoRow extends StatelessWidget {
  const _DetailInfoRow({
    required this.icon,
    required this.text,
    this.label,
    this.iconColor,
  });

  final IconData icon;
  final String text;
  final String? label;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(
            icon,
            size: 18,
            color: iconColor ?? colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (label != null) ...[
                Text(
                  label!,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
              ],
              Text(
                text,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
