import 'dart:convert';

enum TaskPriority {
  low(0, 'Rendah'),
  medium(1, 'Sedang'),
  high(2, 'Tinggi');

  const TaskPriority(this.value, this.label);

  final int value;
  final String label;

  static TaskPriority fromValue(int value) {
    return TaskPriority.values.firstWhere(
      (priority) => priority.value == value,
      orElse: () => TaskPriority.medium,
    );
  }
}

enum SubtaskStatus {
  pending('pending'),
  completed('completed'),
  cancelled('cancelled');

  const SubtaskStatus(this.value);

  final String value;

  static SubtaskStatus fromStorage(
    Object? raw, {
    bool fallbackDone = false,
    bool fallbackCancelled = false,
  }) {
    if (raw is String) {
      for (final status in SubtaskStatus.values) {
        if (status.value == raw) return status;
      }
    }
    if (fallbackCancelled) return SubtaskStatus.cancelled;
    if (fallbackDone) return SubtaskStatus.completed;
    return SubtaskStatus.pending;
  }
}

class ChecklistItem {
  const ChecklistItem({
    required this.title,
    this.isDone = false,
    this.isCancelled = false,
  });

  final String title;
  final bool isDone;
  final bool isCancelled;

  SubtaskStatus get status {
    if (isCancelled) return SubtaskStatus.cancelled;
    if (isDone) return SubtaskStatus.completed;
    return SubtaskStatus.pending;
  }

  bool get isPending => !isDone && !isCancelled;

  ChecklistItem copyWith({
    String? title,
    bool? isDone,
    bool? isCancelled,
  }) {
    final nextCancelled = isCancelled ?? (isDone == true ? false : this.isCancelled);
    final nextDone = nextCancelled ? false : (isDone ?? this.isDone);
    return ChecklistItem(
      title: title ?? this.title,
      isDone: nextDone,
      isCancelled: nextCancelled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'isCancelled': isCancelled,
      'status': status.value,
    };
  }

  factory ChecklistItem.fromMap(Map<String, dynamic> map) {
    final rawDone = map['isDone'] ?? map['is_done'];
    final rawCancelled = map['isCancelled'] ?? map['is_cancelled'];
    final parsedDone = rawDone == true || rawDone == 1;
    final parsedCancelled = rawCancelled == true || rawCancelled == 1;
    final resolvedStatus = SubtaskStatus.fromStorage(
      map['status'],
      fallbackDone: parsedDone,
      fallbackCancelled: parsedCancelled,
    );
    return ChecklistItem(
      title: (map['title'] as String?) ?? '',
      isDone: resolvedStatus == SubtaskStatus.completed,
      isCancelled: resolvedStatus == SubtaskStatus.cancelled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChecklistItem &&
        other.title == title &&
        other.isDone == isDone &&
        other.isCancelled == isCancelled;
  }

  @override
  int get hashCode => Object.hash(title, isDone, isCancelled);
}

class TaskModel {
  const TaskModel({
    this.id,
    required this.title,
    this.description = '',
    this.date,
    this.startTime,
    this.isCompleted = false,
    this.isCancelled = false,
    this.priority = TaskPriority.medium,
    this.colorHex = '#0D9488',
    this.checklistItems = const [],
    this.reminderMinutesBefore,
    this.repeatingRuleId,
    this.projectId,
    this.tagId,
    this.completedAt,
  });

  final int? id;
  final String title;
  final String description;
  final DateTime? date;
  final String? startTime; // Format "HH:mm", opsional
  final bool isCompleted;
  final bool isCancelled;
  final TaskPriority priority;
  final String colorHex;
  final List<ChecklistItem> checklistItems;
  final int? reminderMinutesBefore;
  final int? repeatingRuleId;
  final int? projectId;
  final int? tagId;
  final DateTime? completedAt;

  bool get isActive => !isCompleted && !isCancelled;

  bool get isUnplanned => date == null;

  bool get isRepeating => repeatingRuleId != null;

  List<ChecklistItem> get activeChecklistItems =>
      checklistItems.where((item) => !item.isCancelled).toList();

  int get totalActiveSubtasksCount =>
      checklistItems.where((item) => !item.isCancelled).length;

  int get completedSubtasksCount =>
      checklistItems.where((item) => item.isDone && !item.isCancelled).length;

  int get cancelledSubtasksCount =>
      checklistItems.where((item) => item.isCancelled).length;

  bool get allActiveSubtasksCompleted =>
      totalActiveSubtasksCount > 0 &&
      completedSubtasksCount == totalActiveSubtasksCount;

  DateTime? get effectiveCompletionDate {
    final source = completedAt ?? date;
    if (source == null) return null;
    return DateTime(source.year, source.month, source.day);
  }

  bool get hasStartTime => startTime != null && startTime!.trim().isNotEmpty;

  bool get hasActiveReminder =>
      date != null && hasStartTime && reminderMinutesBefore != null;

  bool get shouldScheduleReminder =>
      !isCompleted && !isCancelled && hasActiveReminder;

  DateTime? get scheduledDateTime {
    final taskDate = date;
    if (taskDate == null || !hasStartTime) return null;
    final parts = startTime!.trim().split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59) {
      return null;
    }
    return DateTime(taskDate.year, taskDate.month, taskDate.day, hour, minute);
  }

  DateTime? get reminderDateTime {
    final scheduled = scheduledDateTime;
    final minutesBefore = reminderMinutesBefore;
    if (scheduled == null || minutesBefore == null) return null;
    return scheduled.subtract(Duration(minutes: minutesBefore));
  }

  String? get reminderShortLabel =>
      formatReminderShortLabel(reminderMinutesBefore);

  static String? formatReminderShortLabel(int? minutesBefore) {
    if (minutesBefore == null) return null;
    if (minutesBefore == 0) return 'Tepat';
    if (minutesBefore % 60 == 0) return '${minutesBefore ~/ 60}j';
    return '${minutesBefore}m';
  }

  static String formatDateKey(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static DateTime parseDateKey(String dateString) {
    final parts = dateString.split('-');
    if (parts.length == 3) {
      final year = int.tryParse(parts[0]);
      final month = int.tryParse(parts[1]);
      final day = int.tryParse(parts[2]);
      if (year != null && month != null && day != null) {
        return DateTime(year, month, day);
      }
    }
    return DateTime.tryParse(dateString) ?? DateTime.now();
  }

  TaskModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? date,
    bool clearDate = false,
    String? startTime,
    bool clearStartTime = false,
    bool? isCompleted,
    bool? isCancelled,
    TaskPriority? priority,
    String? colorHex,
    List<ChecklistItem>? checklistItems,
    int? reminderMinutesBefore,
    bool clearReminder = false,
    int? repeatingRuleId,
    bool clearRepeatingRule = false,
    int? projectId,
    bool clearProject = false,
    int? tagId,
    bool clearTag = false,
    DateTime? completedAt,
    bool clearCompletedAt = false,
  }) {
    final resolvedDate = clearDate ? null : (date ?? this.date);
    final resolvedStartTime = (clearDate || clearStartTime)
        ? null
        : (startTime ?? this.startTime);
    final resolvedReminder = (clearDate || clearStartTime || clearReminder)
        ? null
        : (reminderMinutesBefore ?? this.reminderMinutesBefore);
    final resolvedRepeatingRuleId =
        clearRepeatingRule ? null : (repeatingRuleId ?? this.repeatingRuleId);
    final resolvedProjectId =
        clearProject ? null : (projectId ?? this.projectId);
    final resolvedTagId = clearTag ? null : (tagId ?? this.tagId);
    final resolvedCompletedAt =
        clearCompletedAt ? null : (completedAt ?? this.completedAt);

    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: resolvedDate,
      startTime: resolvedStartTime,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled,
      priority: priority ?? this.priority,
      colorHex: colorHex ?? this.colorHex,
      checklistItems: checklistItems ?? this.checklistItems,
      reminderMinutesBefore: resolvedReminder,
      repeatingRuleId: resolvedRepeatingRuleId,
      projectId: resolvedProjectId,
      tagId: resolvedTagId,
      completedAt: resolvedCompletedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'date': date != null ? formatDateKey(date!) : null,
      'startTime': startTime,
      'isCompleted': isCompleted ? 1 : 0,
      'is_cancelled': isCancelled ? 1 : 0,
      'priority': priority.value,
      'colorHex': colorHex,
      'checklistItems': jsonEncode(
        checklistItems.map((item) => item.toMap()).toList(),
      ),
      'reminderMinutesBefore': reminderMinutesBefore,
      'repeatingRuleId': repeatingRuleId,
      'projectId': projectId,
      'tagId': tagId,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    final rawChecklist = map['checklistItems'];
    final List<ChecklistItem> parsedChecklist = [];

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
      } catch (_) {
        // Biarkan kosong jika format JSON lama tidak valid.
      }
    }

    final rawDate = map['date'] as String?;
    final parsedDate = (rawDate == null || rawDate.trim().isEmpty)
        ? null
        : parseDateKey(rawDate);

    final rawCompletedAt = map['completedAt'] as String?;
    final parsedCompletedAt =
        (rawCompletedAt == null || rawCompletedAt.trim().isEmpty)
            ? null
            : DateTime.tryParse(rawCompletedAt);

    return TaskModel(
      id: map['id'] as int?,
      title: (map['title'] as String?) ?? '',
      description: (map['description'] as String?) ?? '',
      date: parsedDate,
      startTime: map['startTime'] as String?,
      isCompleted: (map['isCompleted'] as int? ?? 0) == 1,
      isCancelled:
          ((map['is_cancelled'] ?? map['isCancelled']) as int? ?? 0) == 1,
      priority: TaskPriority.fromValue(
        (map['priority'] as int?) ?? TaskPriority.medium.value,
      ),
      colorHex: (map['colorHex'] as String?) ?? '#0D9488',
      checklistItems: parsedChecklist,
      reminderMinutesBefore: (map['reminderMinutesBefore'] as num?)?.toInt(),
      repeatingRuleId: (map['repeatingRuleId'] as num?)?.toInt(),
      projectId: (map['projectId'] as num?)?.toInt(),
      tagId: (map['tagId'] as num?)?.toInt(),
      completedAt: parsedCompletedAt,
    );
  }
}
