import 'package:device_calendar_plus/device_calendar_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

import '../models/calendar_event_model.dart';

abstract class DeviceCalendarService {
  Future<bool> hasPermissions();
  Future<bool> requestPermissions();
  Future<bool> isPermissionPermanentlyDenied();
  Future<bool> openSettings();
  Future<List<DeviceCalendarInfo>> getCalendars();
  Future<List<CalendarEventModel>> getEventsForDate(
    DateTime date,
    Set<String> selectedCalendarIds,
  );
}

class PlatformDeviceCalendarService implements DeviceCalendarService {
  PlatformDeviceCalendarService({DeviceCalendar? plugin})
      : _plugin = plugin ?? DeviceCalendar.instance;

  static final PlatformDeviceCalendarService instance =
      PlatformDeviceCalendarService();

  static const String _defaultCalendarColorHex = '#0284C7';

  final DeviceCalendar _plugin;
  final Map<String, String> _calendarColorCache = {};
  final Map<String, String> _calendarNameCache = {};

  /// Normalizes a raw device calendar event for [targetDate], avoiding UTC-to-local
  /// day shift for floating all-day events (e.g., National Holidays).
  static CalendarEventModel? normalizeEventForDate({
    required String id,
    required String calendarId,
    String? calendarName,
    required String title,
    required String description,
    required String location,
    required DateTime startDate,
    required DateTime endDate,
    required bool isAllDay,
    required String colorHex,
    required DateTime targetDate,
  }) {
    final normalizedTarget = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );
    final nextTargetDay = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day + 1,
    );

    if (isAllDay) {
      // Android CalendarContract stores all-day dates as UTC midnight; keep the
      // calendar's wall-clock year/month/day intact without timezone offset shift.
      final startDay = DateTime(startDate.year, startDate.month, startDate.day);
      final rawEndDay = DateTime(endDate.year, endDate.month, endDate.day);
      final endDay = rawEndDay.isAfter(startDay)
          ? rawEndDay
          : DateTime(startDay.year, startDay.month, startDay.day + 1);

      if (normalizedTarget.isBefore(startDay) ||
          !normalizedTarget.isBefore(endDay)) {
        return null;
      }

      return CalendarEventModel(
        id: id,
        calendarId: calendarId,
        calendarName: calendarName,
        title: title.trim().isEmpty ? '(Tanpa judul)' : title.trim(),
        description: description.trim(),
        location: location.trim(),
        start: normalizedTarget,
        end: nextTargetDay,
        isAllDay: true,
        colorHex: colorHex,
      );
    }

    final localStart = startDate.isUtc ? startDate.toLocal() : startDate;
    final localEnd = endDate.isUtc ? endDate.toLocal() : endDate;

    final overlapsDay = localStart.isBefore(nextTargetDay) &&
        (localEnd.isAfter(normalizedTarget) ||
            localStart.isAtSameMomentAs(normalizedTarget));
    if (!overlapsDay) {
      return null;
    }

    return CalendarEventModel(
      id: id,
      calendarId: calendarId,
      calendarName: calendarName,
      title: title.trim().isEmpty ? '(Tanpa judul)' : title.trim(),
      description: description.trim(),
      location: location.trim(),
      start: localStart,
      end: localEnd,
      isAllDay: false,
      colorHex: colorHex,
    );
  }

  @override
  Future<bool> hasPermissions() async {
    try {
      final status = await ph.Permission.calendarFullAccess.status;
      if (status.isGranted) return true;
      final pluginStatus = await _plugin.hasPermissions();
      return pluginStatus == CalendarPermissionStatus.granted;
    } on MissingPluginException {
      return false;
    } catch (e) {
      debugPrint('CalendarService.hasPermissions gagal: $e');
      return false;
    }
  }

  @override
  Future<bool> requestPermissions() async {
    try {
      final status = await ph.Permission.calendarFullAccess.request();
      if (status.isGranted) return true;
      if (status.isPermanentlyDenied || status.isRestricted) return false;
      final pluginStatus = await _plugin.requestPermissions();
      return pluginStatus == CalendarPermissionStatus.granted;
    } on MissingPluginException {
      return false;
    } catch (e) {
      debugPrint('CalendarService.requestPermissions gagal: $e');
      return false;
    }
  }

  @override
  Future<bool> isPermissionPermanentlyDenied() async {
    try {
      final status = await ph.Permission.calendarFullAccess.status;
      if (status.isPermanentlyDenied || status.isRestricted) {
        return true;
      }
      final pluginStatus = await _plugin.hasPermissions();
      return pluginStatus == CalendarPermissionStatus.denied ||
          pluginStatus == CalendarPermissionStatus.restricted;
    } on MissingPluginException {
      return false;
    } catch (e) {
      debugPrint('CalendarService.isPermissionPermanentlyDenied gagal: $e');
      return false;
    }
  }

  @override
  Future<bool> openSettings() async {
    try {
      return await ph.openAppSettings();
    } on MissingPluginException {
      return false;
    } catch (e) {
      debugPrint('CalendarService.openSettings gagal: $e');
      return false;
    }
  }

  @override
  Future<List<DeviceCalendarInfo>> getCalendars() async {
    try {
      final rawCalendars = await _plugin.listCalendars();
      final result = <DeviceCalendarInfo>[];

      for (final calendar in rawCalendars) {
        final colorHex = _normalizeHex(calendar.colorHex);
        final resolvedName = calendar.name.trim().isEmpty
            ? (calendar.accountName?.trim().isNotEmpty == true
                ? calendar.accountName!.trim()
                : 'Kalender Tanpa Nama')
            : calendar.name.trim();

        _calendarColorCache[calendar.id] = colorHex;
        _calendarNameCache[calendar.id] = resolvedName;

        result.add(
          DeviceCalendarInfo(
            id: calendar.id,
            name: resolvedName,
            accountName: calendar.accountName,
            colorHex: colorHex,
            isPrimary: calendar.isPrimary,
          ),
        );
      }

      result.sort((a, b) {
        if (a.isPrimary != b.isPrimary) return a.isPrimary ? -1 : 1;
        return a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });

      return result;
    } on MissingPluginException {
      return const [];
    } on DeviceCalendarException catch (e) {
      debugPrint('CalendarService.getCalendars error: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('CalendarService.getCalendars gagal: $e');
      rethrow;
    }
  }

  @override
  Future<List<CalendarEventModel>> getEventsForDate(
    DateTime date,
    Set<String> selectedCalendarIds,
  ) async {
    if (selectedCalendarIds.isEmpty) {
      return const [];
    }

    try {
      if (_calendarColorCache.isEmpty || _calendarNameCache.isEmpty) {
        try {
          await getCalendars();
        } catch (_) {
          // Continue with default fallback metadata if calendar listing fails.
        }
      }

      // Query a +/-1 day buffer around target date so UTC-aligned all-day events
      // (such as National Holidays) are always retrieved before exact date filtering.
      final queryStart = DateTime(date.year, date.month, date.day - 1);
      final queryEnd = DateTime(date.year, date.month, date.day + 2);

      final rawEvents = await _plugin.listEvents(
        queryStart,
        queryEnd,
        calendarIds: selectedCalendarIds.toList(),
      );

      final seenKeys = <String>{};
      final events = <CalendarEventModel>[];

      for (final event in rawEvents) {
        if (!selectedCalendarIds.contains(event.calendarId)) continue;

        final colorHex = _normalizeHex(
          event.colorHex ?? _calendarColorCache[event.calendarId],
        );
        final normalized = normalizeEventForDate(
          id: event.instanceId,
          calendarId: event.calendarId,
          calendarName: _calendarNameCache[event.calendarId],
          title: event.title,
          description: event.description ?? '',
          location: event.location ?? '',
          startDate: event.startDate,
          endDate: event.endDate,
          isAllDay: event.isAllDay,
          colorHex: colorHex,
          targetDate: date,
        );
        if (normalized == null) continue;

        final dedupeKey =
            '${normalized.calendarId}|${normalized.title}|${normalized.isAllDay}|${normalized.start.toIso8601String()}';
        if (seenKeys.add(dedupeKey)) {
          events.add(normalized);
        }
      }

      events.sort((a, b) {
        if (a.isAllDay != b.isAllDay) return a.isAllDay ? -1 : 1;
        return a.start.compareTo(b.start);
      });

      return events;
    } on MissingPluginException {
      return const [];
    } on DeviceCalendarException catch (e) {
      debugPrint('CalendarService.getEventsForDate error: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('CalendarService.getEventsForDate gagal: $e');
      rethrow;
    }
  }

  static String _normalizeHex(String? rawHex) {
    if (rawHex == null || rawHex.trim().isEmpty) {
      return _defaultCalendarColorHex;
    }
    final trimmed = rawHex.trim().toUpperCase();
    final withoutHash = trimmed.replaceFirst('#', '');
    if (withoutHash.length == 6 && int.tryParse(withoutHash, radix: 16) != null) {
      return '#$withoutHash';
    }
    if (withoutHash.length == 8 && int.tryParse(withoutHash, radix: 16) != null) {
      return '#${withoutHash.substring(2)}';
    }
    return _defaultCalendarColorHex;
  }
}
