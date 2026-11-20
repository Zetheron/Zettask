import 'calendar_event_model.dart';
import 'task_model.dart';

sealed class TimelineEntry {
  const TimelineEntry();

  int get sortMinutes;
  String get sortTitle;
}

final class TaskTimelineEntry extends TimelineEntry {
  const TaskTimelineEntry(this.task);

  final TaskModel task;

  @override
  int get sortMinutes {
    final scheduled = task.scheduledDateTime;
    if (scheduled == null) return 0;
    return scheduled.hour * 60 + scheduled.minute;
  }

  @override
  String get sortTitle => task.title;
}

final class CalendarEventTimelineEntry extends TimelineEntry {
  const CalendarEventTimelineEntry(this.event);

  final CalendarEventModel event;

  @override
  int get sortMinutes => event.startMinutesOfDay;

  @override
  String get sortTitle => event.title;
}

class TimelineMerger {
  TimelineMerger._();

  static List<TimelineEntry> mergeAllDay({
    required List<TaskModel> tasks,
    required List<CalendarEventModel> events,
  }) {
    return [
      for (final event in events) CalendarEventTimelineEntry(event),
      for (final task in tasks) TaskTimelineEntry(task),
    ];
  }

  static List<TimelineEntry> mergeScheduled({
    required List<TaskModel> tasks,
    required List<CalendarEventModel> events,
  }) {
    final merged = <TimelineEntry>[
      for (final event in events) CalendarEventTimelineEntry(event),
      for (final task in tasks) TaskTimelineEntry(task),
    ];

    merged.sort((a, b) {
      final timeCompare = a.sortMinutes.compareTo(b.sortMinutes);
      if (timeCompare != 0) return timeCompare;

      // Place calendar events before tasks when both start at the exact same minute.
      final typeA = a is CalendarEventTimelineEntry ? 0 : 1;
      final typeB = b is CalendarEventTimelineEntry ? 0 : 1;
      if (typeA != typeB) return typeA.compareTo(typeB);

      return a.sortTitle.toLowerCase().compareTo(b.sortTitle.toLowerCase());
    });

    return merged;
  }
}
