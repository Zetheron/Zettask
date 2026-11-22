import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/task_model.dart';
import '../providers/locale_provider.dart';
import '../providers/task_provider.dart';
import 'zettask_motion.dart';

class DateStrip extends StatefulWidget {
  const DateStrip({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.onPickDate,
    required this.onGoToToday,
    this.datesWithTasks = const {},
    this.firstDayOfWeek = DateTime.monday,
    this.showTopBorder = false,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onPickDate;
  final VoidCallback onGoToToday;
  final Set<String> datesWithTasks;
  final int firstDayOfWeek;
  final bool showTopBorder;

  static DateTime startOfWeek(DateTime date, int firstDayOfWeek) {
    final normalized = TaskProvider.normalizeDate(date);
    final normalizedStart =
        firstDayOfWeek == DateTime.sunday ? DateTime.sunday : DateTime.monday;
    final offset = (normalized.weekday - normalizedStart + 7) % 7;
    return DateTime(
      normalized.year,
      normalized.month,
      normalized.day - offset,
    );
  }

  static List<DateTime> weekDates(DateTime date, int firstDayOfWeek) {
    final start = startOfWeek(date, firstDayOfWeek);
    return List<DateTime>.generate(
      7,
      (i) => DateTime(start.year, start.month, start.day + i),
    );
  }

  @override
  State<DateStrip> createState() => _DateStripState();
}

class _DateStripState extends State<DateStrip> {
  static const int _initialWeekPage = 52;
  static const int _totalWeekPages = 105;

  late PageController _pageController;
  late DateTime _anchorWeekStart;
  int _currentPage = _initialWeekPage;

  @override
  void initState() {
    super.initState();
    _anchorWeekStart = DateStrip.startOfWeek(
      widget.selectedDate,
      widget.firstDayOfWeek,
    );
    _pageController = PageController(initialPage: _initialWeekPage);
  }

  @override
  void didUpdateWidget(covariant DateStrip oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.firstDayOfWeek != widget.firstDayOfWeek) {
      _anchorWeekStart = DateStrip.startOfWeek(
        widget.selectedDate,
        widget.firstDayOfWeek,
      );
      _currentPage = _initialWeekPage;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _pageController.hasClients) {
          _pageController.jumpToPage(_initialWeekPage);
        }
      });
      return;
    }

    if (!TaskProvider.isSameDay(oldWidget.selectedDate, widget.selectedDate)) {
      final targetWeekStart = DateStrip.startOfWeek(
        widget.selectedDate,
        widget.firstDayOfWeek,
      );
      final weekDelta =
          targetWeekStart.difference(_anchorWeekStart).inDays ~/ 7;
      final targetPage = _initialWeekPage + weekDelta;

      if (targetPage < 2 || targetPage > _totalWeekPages - 3) {
        _anchorWeekStart = targetWeekStart;
        _currentPage = _initialWeekPage;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _pageController.hasClients) {
            _pageController.jumpToPage(_initialWeekPage);
          }
        });
      } else if (targetPage != _currentPage) {
        _currentPage = targetPage;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _pageController.hasClients) {
            _pageController.animateToPage(
              targetPage,
              duration: const Duration(milliseconds: 240),
              curve: Curves.easeOutCubic,
            );
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime _weekStartForPage(int page) {
    final weekOffset = page - _initialWeekPage;
    return DateTime(
      _anchorWeekStart.year,
      _anchorWeekStart.month,
      _anchorWeekStart.day + (weekOffset * 7),
    );
  }

  void _stepWeek(int delta) {
    final targetPage = (_currentPage + delta).clamp(0, _totalWeekPages - 1);
    if (targetPage == _currentPage) return;
    _pageController.animateToPage(
      targetPage,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
  }

  String _formatMonthYear(DateTime date, String localeTag) {
    try {
      return DateFormat('MMMM yyyy', localeTag).format(date);
    } catch (_) {
      return DateFormat('MMMM yyyy').format(date);
    }
  }

  String _formatShortWeekday(DateTime date, String localeTag) {
    try {
      return DateFormat('EEE', localeTag).format(date);
    } catch (_) {
      return DateFormat('EEE').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final localeTag =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
    final today = TaskProvider.normalizeDate(DateTime.now());
    final isToday = TaskProvider.isSameDay(widget.selectedDate, today);

    final visibleWeekStart = _weekStartForPage(_currentPage);
    final headerDate = TaskProvider.isSameDay(
      DateStrip.startOfWeek(widget.selectedDate, widget.firstDayOfWeek),
      visibleWeekStart,
    )
        ? widget.selectedDate
        : visibleWeekStart;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 8, 2),
          child: Row(
            children: [
              Flexible(
                child: InkWell(
                  onTap: widget.onPickDate,
                  borderRadius: BorderRadius.circular(14),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              _formatMonthYear(headerDate, localeTag),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 20,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              if (!isToday)
                FilledButton.tonal(
                  onPressed: widget.onGoToToday,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(48, 36),
                    tapTargetSize: MaterialTapTargetSize.padded,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    shape: const StadiumBorder(),
                    textStyle: theme.textTheme.labelMedium?.copyWith(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: Text(l10n.today),
                ),
              IconButton(
                tooltip: l10n.prevWeekTooltip,
                onPressed: () => _stepWeek(-1),
                style: IconButton.styleFrom(
                  minimumSize: const Size(48, 48),
                ),
                icon: Icon(
                  Icons.chevron_left_rounded,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              IconButton(
                tooltip: l10n.nextWeekTooltip,
                onPressed: () => _stepWeek(1),
                style: IconButton.styleFrom(
                  minimumSize: const Size(48, 48),
                ),
                icon: Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 68,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _totalWeekPages,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
            itemBuilder: (context, page) {
              final weekStart = _weekStartForPage(page);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: List.generate(7, (dayIndex) {
                    final date = DateTime(
                      weekStart.year,
                      weekStart.month,
                      weekStart.day + dayIndex,
                    );
                    final isSelected =
                        TaskProvider.isSameDay(date, widget.selectedDate);
                    final isDateToday = TaskProvider.isSameDay(date, today);
                    final hasTasks = widget.datesWithTasks
                        .contains(TaskModel.formatDateKey(date));

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: _DateStripTile(
                          key: ValueKey(
                            'date_strip_cell_${dayIndex}_${TaskModel.formatDateKey(date)}',
                          ),
                          weekdayLabel: _formatShortWeekday(date, localeTag),
                          dayNumber: date.day.toString(),
                          isSelected: isSelected,
                          isToday: isDateToday,
                          hasTasks: hasTasks,
                          onTap: () => widget.onDateSelected(date),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
      ],
    );

    if (!widget.showTopBorder) {
      return content;
    }

    final isAmoled = AppTheme.isAmoled(theme);
    return Container(
      decoration: BoxDecoration(
        color: isAmoled
            ? AppTheme.amoledBackground
            : colorScheme.surfaceContainerLow,
        border: isAmoled
            ? Border(
                top: BorderSide(color: colorScheme.outline, width: 1),
              )
            : null,
      ),
      child: content,
    );
  }
}

class _DateStripTile extends StatelessWidget {
  const _DateStripTile({
    super.key,
    required this.weekdayLabel,
    required this.dayNumber,
    required this.isSelected,
    required this.isToday,
    required this.hasTasks,
    required this.onTap,
  });

  final String weekdayLabel;
  final String dayNumber;
  final bool isSelected;
  final bool isToday;
  final bool hasTasks;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isAmoled = AppTheme.isAmoled(theme);

    final backgroundColor = isSelected
        ? colorScheme.primary
        : isToday
            ? colorScheme.primaryContainer
            : (isAmoled ? AppTheme.amoledSurface : Colors.transparent);
    final borderSide = isSelected
        ? BorderSide.none
        : isToday
            ? (isAmoled
                ? BorderSide(color: colorScheme.primary, width: 1.2)
                : BorderSide.none)
            : (isAmoled
                ? BorderSide(color: colorScheme.outline, width: 1)
                : BorderSide.none);
    final weekdayColor = isSelected
        ? colorScheme.onPrimary.withValues(alpha: 0.85)
        : isToday
            ? colorScheme.onPrimaryContainer.withValues(alpha: 0.85)
            : colorScheme.onSurfaceVariant;
    final dayColor = isSelected
        ? colorScheme.onPrimary
        : isToday
            ? colorScheme.onPrimaryContainer
            : colorScheme.onSurface;

    return Semantics(
      button: true,
      selected: isSelected,
      label: '$weekdayLabel $dayNumber',
      child: ZettaskSpringTap(
        pressedScale: 0.92,
        child: Material(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: borderSide,
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 66,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weekdayLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: weekdayColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    dayNumber,
                    maxLines: 1,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: dayColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 4,
                    child: hasTasks
                        ? Container(
                            key: ValueKey('date_dot_$dayNumber'),
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? colorScheme.onPrimary
                                  : isToday
                                      ? colorScheme.onPrimaryContainer
                                      : colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
