import 'dart:convert';

import 'task_model.dart';

class TaskTemplateModel {
  const TaskTemplateModel({
    this.id,
    required this.name,
    required this.title,
    this.description = '',
    this.startTime,
    this.priority = TaskPriority.medium,
    this.colorHex = '#0D9488',
    this.checklistItems = const [],
    this.tagId,
    this.projectId,
  });

  final int? id;
  final String name;
  final String title;
  final String description;
  final String? startTime;
  final TaskPriority priority;
  final String colorHex;
  final List<ChecklistItem> checklistItems;
  final int? tagId;
  final int? projectId;

  bool get hasStartTime => startTime != null && startTime!.trim().isNotEmpty;

  TaskModel toDraftTask({DateTime? date}) {
    return TaskModel(
      title: title,
      description: description,
      date: date,
      startTime: date != null ? startTime : null,
      priority: priority,
      colorHex: colorHex,
      checklistItems: checklistItems
          .map((item) => ChecklistItem(title: item.title, isDone: false))
          .toList(),
      tagId: tagId,
      projectId: projectId,
    );
  }

  TaskTemplateModel copyWith({
    int? id,
    String? name,
    String? title,
    String? description,
    String? startTime,
    bool clearStartTime = false,
    TaskPriority? priority,
    String? colorHex,
    List<ChecklistItem>? checklistItems,
    int? tagId,
    bool clearTag = false,
    int? projectId,
    bool clearProject = false,
  }) {
    return TaskTemplateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: clearStartTime ? null : (startTime ?? this.startTime),
      priority: priority ?? this.priority,
      colorHex: colorHex ?? this.colorHex,
      checklistItems: checklistItems ?? this.checklistItems,
      tagId: clearTag ? null : (tagId ?? this.tagId),
      projectId: clearProject ? null : (projectId ?? this.projectId),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'title': title,
      'description': description,
      'startTime': startTime,
      'priority': priority.value,
      'colorHex': colorHex,
      'checklistItems': jsonEncode(
        checklistItems.map((item) => item.toMap()).toList(),
      ),
      'tagId': tagId,
      'projectId': projectId,
    };
  }

  factory TaskTemplateModel.fromMap(Map<String, dynamic> map) {
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

    return TaskTemplateModel(
      id: (map['id'] as num?)?.toInt(),
      name: (map['name'] as String?) ?? '',
      title: (map['title'] as String?) ?? '',
      description: (map['description'] as String?) ?? '',
      startTime: map['startTime'] as String?,
      priority: TaskPriority.fromValue(
        (map['priority'] as num?)?.toInt() ?? TaskPriority.medium.value,
      ),
      colorHex: (map['colorHex'] as String?) ?? '#0D9488',
      checklistItems: parsedChecklist,
      tagId: (map['tagId'] as num?)?.toInt(),
      projectId: (map['projectId'] as num?)?.toInt(),
    );
  }
}
