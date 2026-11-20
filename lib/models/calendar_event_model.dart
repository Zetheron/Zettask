class DeviceCalendarInfo {
  const DeviceCalendarInfo({
    required this.id,
    required this.name,
    this.accountName,
    this.colorHex = '#0284C7',
    this.isPrimary = false,
  });

  final String id;
  final String name;
  final String? accountName;
  final String colorHex;
  final bool isPrimary;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DeviceCalendarInfo &&
        other.id == id &&
        other.name == name &&
        other.accountName == accountName &&
        other.colorHex == colorHex &&
        other.isPrimary == isPrimary;
  }

  @override
  int get hashCode => Object.hash(id, name, accountName, colorHex, isPrimary);
}

class CalendarEventModel {
  const CalendarEventModel({
    required this.id,
    required this.calendarId,
    this.calendarName,
    required this.title,
    this.description = '',
    this.location = '',
    required this.start,
    required this.end,
    this.isAllDay = false,
    this.colorHex = '#0284C7',
  });

  final String id;
  final String calendarId;
  final String? calendarName;
  final String title;
  final String description;
  final String location;
  final DateTime start;
  final DateTime end;
  final bool isAllDay;
  final String colorHex;

  int get startMinutesOfDay => start.hour * 60 + start.minute;

  String get startTimeFormatted => _formatTime(start);

  String get endTimeFormatted => _formatTime(end);

  String get timeRangeFormatted {
    if (isAllDay) return 'Sepanjang Hari';
    if (start.hour == end.hour &&
        start.minute == end.minute &&
        start.day == end.day) {
      return startTimeFormatted;
    }
    return '$startTimeFormatted – $endTimeFormatted';
  }

  static String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CalendarEventModel &&
        other.id == id &&
        other.calendarId == calendarId &&
        other.calendarName == calendarName &&
        other.title == title &&
        other.description == description &&
        other.location == location &&
        other.start == start &&
        other.end == end &&
        other.isAllDay == isAllDay &&
        other.colorHex == colorHex;
  }

  @override
  int get hashCode => Object.hash(
        id,
        calendarId,
        calendarName,
        title,
        description,
        location,
        start,
        end,
        isAllDay,
        colorHex,
      );
}
