import 'package:cupertino_ui/cupertino_ui.dart' as cupertino_ui;
import 'package:flutter_localizations/flutter_localizations.dart'
    show GlobalWidgetsLocalizations;
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart' as material_ui;

import '../models/calendar_event_model.dart';
import '../models/repeating_task_model.dart';
import '../models/task_model.dart';
import 'app_localizations.dart';

/// Localization delegates compatible with Flutter 3.50's standalone
/// `material_ui` and `cupertino_ui` packages alongside `AppLocalizations`.
const List<material_ui.LocalizationsDelegate<dynamic>>
    zettaskLocalizationsDelegates = <material_ui.LocalizationsDelegate<dynamic>>[
  AppLocalizations.delegate,
  material_ui.GlobalMaterialLocalizations.delegate,
  cupertino_ui.GlobalCupertinoLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];

String localizedPriorityLabel(AppLocalizations l10n, TaskPriority priority) {
  return switch (priority) {
    TaskPriority.low => l10n.priorityLow,
    TaskPriority.medium => l10n.priorityMedium,
    TaskPriority.high => l10n.priorityHigh,
  };
}

String localizedRepeatFrequencyLabel(
  AppLocalizations l10n,
  RepeatFrequency frequency,
) {
  return switch (frequency) {
    RepeatFrequency.daily => l10n.repeatDaily,
    RepeatFrequency.weekly => l10n.repeatWeekly,
    RepeatFrequency.monthly => l10n.repeatMonthly,
  };
}

String? localizedReminderShortLabel(AppLocalizations l10n, int? minutesBefore) {
  return switch (minutesBefore) {
    null => null,
    0 => l10n.atTime,
    10 => l10n.reminderShort10m,
    30 => l10n.reminderShort30m,
    60 => l10n.reminderShort1h,
    _ => '${minutesBefore}m',
  };
}

String localizedWeekdayShort(String intlLocale, int weekday) {
  // 2024-01-01 is a Monday (weekday == 1).
  final refDate = DateTime(2024, 1, weekday);
  try {
    return DateFormat('EEE', intlLocale).format(refDate);
  } catch (_) {
    return RepeatingTaskRule.weekdayShortLabels[weekday] ?? '';
  }
}

String localizedRuleScheduleSummary(
  AppLocalizations l10n,
  String intlLocale,
  RepeatingTaskRule rule,
) {
  final base = switch (rule.frequency) {
    RepeatFrequency.daily => l10n.repeatDaily,
    RepeatFrequency.weekly => () {
        final days = rule.effectiveWeekdays
            .map((d) => localizedWeekdayShort(intlLocale, d))
            .where((s) => s.isNotEmpty)
            .join(', ');
        return '${l10n.repeatWeekly} $days';
      }(),
    RepeatFrequency.monthly => l10n.repeatMonthlyDay(rule.startDate.day),
  };
  if (rule.hasStartTime) {
    return '$base · ${rule.startTime!.trim()}';
  }
  return base;
}

String localizedEventTimeRange(
  AppLocalizations l10n,
  CalendarEventModel event,
) {
  if (event.isAllDay) return l10n.allDay;
  return event.timeRangeFormatted;
}
