import 'dart:convert';
import 'dart:math' as math;

import 'task_model.dart';

enum RepeatFrequency {
  daily('daily', 'Setiap hari'),
  weekly('weekly', 'Setiap minggu'),
  monthly('monthly', 'Setiap bulan');

  const RepeatFrequency(this.value, this.label);

  final String value;
  final String label;

  static RepeatFrequency fromValue(String? rawValue) {
    return RepeatFrequency.values.firstWhere(
      (freq) => freq.value == rawValue,
      orElse: () => RepeatFrequency.daily,
    );
  }
}

class RepeatConfig {
  const RepeatConfig({
    required this.frequency,
    this.weekdays = const [],
  });

  final RepeatFrequency frequency;
  final List<int> weekdays;
}

class RepeatingTaskStats {
  const RepeatingTaskStats({
    this.allTimeCompleted = 0,
    this.last30DaysStatus = const [],
  });

  final int allTimeCompleted;
  final List<bool> last30DaysStatus;

  int get last30DaysCompletedCount =>
      last30DaysStatus.where((done) => done).length;

  static RepeatingTaskStats empty() => RepeatingTaskStats(
        allTimeCompleted: 0,
        last30DaysStatus: List<bool>.filled(30, false),
      );
}

class RepeatingTaskRule {
  RepeatingTaskRule({
    this.id,
    required this.title,
    this.description = '',
    this.startTime,
    this.priority = TaskPriority.medium,
    this.colorHex = '#0D9488',
    this.checklistItems = const [],
    this.reminderMinutesBefore,
    this.frequency = RepeatFrequency.daily,
    List<int> weekdays = const [],
    required DateTime startDate,
    this.isActive = true,
    Set<String> excludedDates = const {},
    this.projectId,
    this.tagId,
  })  : startDate = DateTime(startDate.year, startDate.month, startDate.day),
        weekdays = _normalizeWeekdays(weekdays),
        excludedDates = Set<String>.unmodifiable(excludedDates);

  final int? id;
  final String title;
  final String description;
  final String? startTime;
  final TaskPriority priority;
  final String colorHex;
  final List<ChecklistItem> checklistItems;
  final int? reminderMinutesBefore;
  final RepeatFrequency frequency;
  final List<int> weekdays;
  final DateTime startDate;
  final bool isActive;
  final Set<String> excludedDates;
  final int? projectId;
  final int? tagId;

  static const Map<int, String> weekdayShortLabels = {
    1: 'Sen',
    2: 'Sel',
    3: 'Rab',
    4: 'Kam',
    5: 'Jum',
    6: 'Sab',
    7: 'Min',
  };

  static List<int> _normalizeWeekdays(List<int> raw) {
    final cleaned = raw.where((day) => day >= 1 && day <= 7).toSet().toList()
      ..sort();
    return List<int>.unmodifiable(cleaned);
  }

  static int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  bool get hasStartTime => startTime != null && startTime!.trim().isNotEmpty;

  bool get hasActiveReminder => hasStartTime && reminderMinutesBefore != null;

  List<int> get effectiveWeekdays =>
      weekdays.isEmpty ? [startDate.weekday] : weekdays;

  bool matchesDate(DateTime date) {
    if (!isActive) return false;

    final target = DateTime(date.year, date.month, date.day);
    if (target.isBefore(startDate)) return false;

    if (excludedDates.contains(TaskModel.formatDateKey(target))) {
      return false;
    }

    return switch (frequency) {
      RepeatFrequency.daily => true,
      RepeatFrequency.weekly => effectiveWeekdays.contains(target.weekday),
      RepeatFrequency.monthly => target.day ==
          math.min(startDate.day, _daysInMonth(target.year, target.month)),
    };
  }

  DateTime? nextOccurrenceFrom(DateTime from) {
    if (!isActive) return null;

    var cursor = DateTime(from.year, from.month, from.day);
    if (cursor.isBefore(startDate)) {
      cursor = startDate;
    }

    for (var offset = 0; offset <= 400; offset++) {
      final candidate = DateTime(
        cursor.year,
        cursor.month,
        cursor.day + offset,
      );
      if (matchesDate(candidate)) {
        return candidate;
      }
    }
    return null;
  }

  String get scheduleSummary {
    final base = switch (frequency) {
      RepeatFrequency.daily => 'Setiap hari',
      RepeatFrequency.weekly =>
        'Setiap minggu ${effectiveWeekdays.map((d) => weekdayShortLabels[d] ?? '').join(', ')}',
      RepeatFrequency.monthly => 'Setiap bulan tgl ${startDate.day}',
    };

    if (hasStartTime) {
      return '$base · ${startTime!.trim()}';
    }
    return base;
  }

  TaskModel buildTaskInstance(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    return TaskModel(
      title: title,
      description: description,
      date: normalized,
      startTime: startTime,
      isCompleted: false,
      priority: priority,
      colorHex: colorHex,
      checklistItems: checklistItems
          .map((item) => ChecklistItem(title: item.title, isDone: false))
          .toList(),
      reminderMinutesBefore: hasStartTime ? reminderMinutesBefore : null,
      repeatingRuleId: id,
      projectId: projectId,
      tagId: tagId,
    );
  }

  RepeatingTaskRule copyWith({
    int? id,
    String? title,
    String? description,
    String? startTime,
    bool clearStartTime = false,
    TaskPriority? priority,
    String? colorHex,
    List<ChecklistItem>? checklistItems,
    int? reminderMinutesBefore,
    bool clearReminder = false,
    RepeatFrequency? frequency,
    List<int>? weekdays,
    DateTime? startDate,
    bool? isActive,
    Set<String>? excludedDates,
    int? projectId,
    bool clearProject = false,
    int? tagId,
    bool clearTag = false,
  }) {
    final resolvedStartTime =
        clearStartTime ? null : (startTime ?? this.startTime);
    final resolvedReminder = (clearStartTime || clearReminder)
        ? null
        : (reminderMinutesBefore ?? this.reminderMinutesBefore);

    return RepeatingTaskRule(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: resolvedStartTime,
      priority: priority ?? this.priority,
      colorHex: colorHex ?? this.colorHex,
      checklistItems: checklistItems ?? this.checklistItems,
      reminderMinutesBefore: resolvedReminder,
      frequency: frequency ?? this.frequency,
      weekdays: weekdays ?? this.weekdays,
      startDate: startDate ?? this.startDate,
      isActive: isActive ?? this.isActive,
      excludedDates: excludedDates ?? this.excludedDates,
      projectId: clearProject ? null : (projectId ?? this.projectId),
      tagId: clearTag ? null : (tagId ?? this.tagId),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'startTime': startTime,
      'priority': priority.value,
      'colorHex': colorHex,
      'checklistItems': jsonEncode(
        checklistItems.map((item) => item.toMap()).toList(),
      ),
      'reminderMinutesBefore': reminderMinutesBefore,
      'frequency': frequency.value,
      'weekdays': jsonEncode(weekdays),
      'startDate': TaskModel.formatDateKey(startDate),
      'isActive': isActive ? 1 : 0,
      'excludedDates': jsonEncode(excludedDates.toList()..sort()),
      'projectId': projectId,
      'tagId': tagId,
    };
  }

  factory RepeatingTaskRule.fromMap(Map<String, dynamic> map) {
    final parsedChecklist = <ChecklistItem>[];
    final rawChecklist = map['checklistItems'];
    if (rawChecklist is String && rawChecklist.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawChecklist);
        if (decoded is List) {
          for (final entry in decoded) {
            if (entry is Map<String, dynamic>) {
              parsedChecklist.add(ChecklistItem.fromMap(entry));
            } else if (entry is Map) {
              parsedChecklist.add(
                ChecklistItem.fromMap(Map<String, dynamic>.from(entry)),
              );
            }
          }
        }
      } catch (_) {}
    }

    final parsedWeekdays = <int>[];
    final rawWeekdays = map['weekdays'];
    if (rawWeekdays is String && rawWeekdays.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawWeekdays);
        if (decoded is List) {
          for (final entry in decoded) {
            if (entry is num) parsedWeekdays.add(entry.toInt());
          }
        }
      } catch (_) {}
    }

    final parsedExcluded = <String>{};
    final rawExcluded = map['excludedDates'];
    if (rawExcluded is String && rawExcluded.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawExcluded);
        if (decoded is List) {
          for (final entry in decoded) {
            if (entry is String && entry.trim().isNotEmpty) {
              parsedExcluded.add(entry.trim());
            }
          }
        }
      } catch (_) {}
    }

    return RepeatingTaskRule(
      id: (map['id'] as num?)?.toInt(),
      title: (map['title'] as String?) ?? '',
      description: (map['description'] as String?) ?? '',
      startTime: map['startTime'] as String?,
      priority: TaskPriority.fromValue(
        (map['priority'] as num?)?.toInt() ?? TaskPriority.medium.value,
      ),
      colorHex: (map['colorHex'] as String?) ?? '#0D9488',
      checklistItems: parsedChecklist,
      reminderMinutesBefore: (map['reminderMinutesBefore'] as num?)?.toInt(),
      frequency: RepeatFrequency.fromValue(map['frequency'] as String?),
      weekdays: parsedWeekdays,
      startDate: TaskModel.parseDateKey((map['startDate'] as String?) ?? ''),
      isActive: ((map['isActive'] as num?)?.toInt() ?? 1) == 1,
      excludedDates: parsedExcluded,
      projectId: (map['projectId'] as num?)?.toInt(),
      tagId: (map['tagId'] as num?)?.toInt(),
    );
  }
}
