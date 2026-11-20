import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/calendar_event_model.dart';
import '../models/task_model.dart';
import '../services/calendar_service.dart';
import 'task_provider.dart';

class CalendarProvider extends ChangeNotifier {
  CalendarProvider({
    DeviceCalendarService? calendarService,
    DateTime? initialDate,
  })  : _calendarService =
            calendarService ?? PlatformDeviceCalendarService.instance,
        _currentDate = TaskProvider.normalizeDate(initialDate ?? DateTime.now());

  static const String prefSyncEnabled = 'zettask_calendar_sync_enabled';
  static const String prefSelectedCalendarIds = 'zettask_calendar_selected_ids';
  static const String prefKnownCalendarIds = 'zettask_calendar_known_ids';
  static const String prefSelectionInitialized =
      'zettask_calendar_selection_initialized';

  final DeviceCalendarService _calendarService;

  bool _isInitialized = false;
  bool _isSyncEnabled = false;
  bool _hasPermission = false;
  bool _isPermissionPermanentlyDenied = false;
  bool _isRequestingPermission = false;
  bool _hasAttemptedPermissionRequest = false;
  bool _enableAfterPermissionGranted = false;
  bool _isLoadingCalendars = false;
  bool _isLoadingEvents = false;
  bool _selectionInitialized = false;
  String? _errorMessage;

  List<DeviceCalendarInfo> _calendars = [];
  Set<String> _selectedCalendarIds = {};
  Set<String> _knownCalendarIds = {};
  List<CalendarEventModel> _events = [];
  Map<String, List<CalendarEventModel>> _timelineEventsByDate = {};
  DateTime _currentDate;

  bool get isInitialized => _isInitialized;
  bool get isSyncEnabled => _isSyncEnabled;
  bool get hasPermission => _hasPermission;
  bool get isPermissionPermanentlyDenied => _isPermissionPermanentlyDenied;
  bool get isRequestingPermission => _isRequestingPermission;
  bool get shouldShowOpenSettings =>
      !_hasPermission &&
      (_isPermissionPermanentlyDenied || _hasAttemptedPermissionRequest);
  bool get isLoadingCalendars => _isLoadingCalendars;
  bool get isLoadingEvents => _isLoadingEvents;
  String? get errorMessage => _errorMessage;

  List<DeviceCalendarInfo> get calendars => List.unmodifiable(_calendars);
  Set<String> get selectedCalendarIds => Set.unmodifiable(_selectedCalendarIds);
  List<CalendarEventModel> get events => List.unmodifiable(_events);
  DateTime get currentDate => _currentDate;

  DeviceCalendarInfo? findCalendar(String calendarId) {
    for (final calendar in _calendars) {
      if (calendar.id == calendarId) return calendar;
    }
    return null;
  }

  List<CalendarEventModel> get allDayEvents {
    if (!_isSyncEnabled || !_hasPermission) return const [];
    return _events.where((event) => event.isAllDay).toList();
  }

  List<CalendarEventModel> get scheduledEvents {
    if (!_isSyncEnabled || !_hasPermission) return const [];
    final list = _events.where((event) => !event.isAllDay).toList();
    list.sort((a, b) => a.start.compareTo(b.start));
    return list;
  }

  List<CalendarEventModel> allDayEventsForDate(DateTime date) {
    if (!_isSyncEnabled || !_hasPermission) return const [];
    final bucket = _eventsBucketForDate(date);
    return bucket.where((event) => event.isAllDay).toList();
  }

  List<CalendarEventModel> scheduledEventsForDate(DateTime date) {
    if (!_isSyncEnabled || !_hasPermission) return const [];
    final bucket = _eventsBucketForDate(date);
    final list = bucket.where((event) => !event.isAllDay).toList();
    list.sort((a, b) => a.start.compareTo(b.start));
    return list;
  }

  List<DateTime> get upcomingDatesWithEvents {
    if (!_isSyncEnabled || !_hasPermission) return const [];
    final dates = <DateTime>[];
    for (var offset = 1; offset <= TaskProvider.timelineLookaheadDays; offset++) {
      final candidate = DateTime(
        _currentDate.year,
        _currentDate.month,
        _currentDate.day + offset,
      );
      final key = TaskModel.formatDateKey(candidate);
      final dayEvents = _timelineEventsByDate[key];
      if (dayEvents != null && dayEvents.isNotEmpty) {
        dates.add(candidate);
      }
    }
    return dates;
  }

  List<CalendarEventModel> _eventsBucketForDate(DateTime date) {
    if (TaskProvider.isSameDay(date, _currentDate)) {
      return _events;
    }
    return _timelineEventsByDate[TaskModel.formatDateKey(date)] ?? const [];
  }

  Future<void> initialize({DateTime? initialDate}) async {
    if (initialDate != null) {
      _currentDate = TaskProvider.normalizeDate(initialDate);
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      _isSyncEnabled = prefs.getBool(prefSyncEnabled) ?? false;
      _selectionInitialized = prefs.getBool(prefSelectionInitialized) ?? false;
      final savedIds = prefs.getStringList(prefSelectedCalendarIds);
      if (savedIds != null) {
        _selectedCalendarIds = savedIds.toSet();
      }
      final knownIds = prefs.getStringList(prefKnownCalendarIds);
      if (knownIds != null) {
        _knownCalendarIds = knownIds.toSet();
      }
    } catch (e) {
      debugPrint('CalendarProvider gagal membaca preferensi: $e');
    }

    await _refreshPermissionStatus();
    _isInitialized = true;
    notifyListeners();

    if (_isSyncEnabled && _hasPermission) {
      await _loadCalendarsAndEvents();
    }
  }

  Future<void> _refreshPermissionStatus() async {
    try {
      _hasPermission = await _calendarService.hasPermissions();
      _isPermissionPermanentlyDenied = _hasPermission
          ? false
          : await _calendarService.isPermissionPermanentlyDenied();
    } catch (_) {
      _hasPermission = false;
      _isPermissionPermanentlyDenied = false;
    }
  }

  Future<void> _savePreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(prefSyncEnabled, _isSyncEnabled);
      await prefs.setBool(prefSelectionInitialized, _selectionInitialized);
      await prefs.setStringList(
        prefSelectedCalendarIds,
        _selectedCalendarIds.toList(),
      );
      await prefs.setStringList(
        prefKnownCalendarIds,
        _knownCalendarIds.toList(),
      );
    } catch (e) {
      debugPrint('CalendarProvider gagal menyimpan preferensi: $e');
    }
  }

  Future<void> setSyncEnabled(bool enabled) async {
    if (_isRequestingPermission) return;
    _errorMessage = null;

    if (!enabled) {
      _isSyncEnabled = false;
      _enableAfterPermissionGranted = false;
      _events = [];
      _timelineEventsByDate = {};
      await _savePreferences();
      notifyListeners();
      return;
    }

    await _refreshPermissionStatus();
    if (!_hasPermission) {
      _isRequestingPermission = true;
      notifyListeners();

      bool granted = false;
      try {
        granted = await _calendarService.requestPermissions();
      } catch (e) {
        _errorMessage = 'Gagal meminta izin kalender: $e';
      }

      _isRequestingPermission = false;
      _hasPermission = granted;
      _hasAttemptedPermissionRequest = !granted;
      _isPermissionPermanentlyDenied = granted
          ? false
          : await _calendarService.isPermissionPermanentlyDenied();

      if (!granted) {
        _isSyncEnabled = false;
        _enableAfterPermissionGranted = true;
        _errorMessage ??= _isPermissionPermanentlyDenied
            ? 'Izin akses kalender ditolak permanen. Aktifkan melalui Pengaturan perangkat.'
            : 'Izin akses kalender diperlukan untuk menampilkan acara.';
        await _savePreferences();
        notifyListeners();
        return;
      }
    }

    _hasAttemptedPermissionRequest = false;
    _enableAfterPermissionGranted = false;
    _isSyncEnabled = true;
    await _savePreferences();
    notifyListeners();
    await _loadCalendarsAndEvents();
  }

  Future<bool> requestCalendarPermission() async {
    if (_isRequestingPermission) return false;
    _errorMessage = null;
    _isRequestingPermission = true;
    notifyListeners();

    try {
      final granted = await _calendarService.requestPermissions();
      _isRequestingPermission = false;
      _hasPermission = granted;
      _hasAttemptedPermissionRequest = !granted;
      _isPermissionPermanentlyDenied = granted
          ? false
          : await _calendarService.isPermissionPermanentlyDenied();

      if (granted) {
        _enableAfterPermissionGranted = false;
        _isSyncEnabled = true;
        await _savePreferences();
        notifyListeners();
        await _loadCalendarsAndEvents();
        return true;
      }

      _enableAfterPermissionGranted = true;
      _errorMessage = _isPermissionPermanentlyDenied
          ? 'Izin akses kalender ditolak permanen. Aktifkan melalui Pengaturan perangkat.'
          : 'Izin akses kalender belum diberikan.';
      notifyListeners();
      return false;
    } catch (e) {
      _isRequestingPermission = false;
      _hasAttemptedPermissionRequest = true;
      _errorMessage = 'Gagal meminta izin kalender: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> refreshPermissionAndCalendars() async {
    _errorMessage = null;
    await _refreshPermissionStatus();
    if (_hasPermission) {
      _hasAttemptedPermissionRequest = false;
      if (_enableAfterPermissionGranted && !_isSyncEnabled) {
        _isSyncEnabled = true;
        _enableAfterPermissionGranted = false;
        await _savePreferences();
      }
    }
    notifyListeners();

    if (_hasPermission && _isSyncEnabled) {
      await _loadCalendarsAndEvents();
    } else if (_hasPermission && _calendars.isEmpty) {
      await _loadCalendars();
    }
  }

  Future<bool> openAppSettings() {
    _enableAfterPermissionGranted = true;
    return _calendarService.openSettings();
  }

  Future<void> _loadCalendarsAndEvents() async {
    await _loadCalendars();
    await loadEventsForDate(_currentDate);
  }

  Future<void> _loadCalendars() async {
    _isLoadingCalendars = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetched = await _calendarService.getCalendars();
      _calendars = fetched;

      final availableIds = fetched.map((calendar) => calendar.id).toSet();
      if (!_selectionInitialized) {
        // Auto-select every available device calendar (primary, holidays, birthdays,
        // subscribed calendars) on first activation.
        _selectedCalendarIds = Set<String>.from(availableIds);
        _knownCalendarIds = Set<String>.from(availableIds);
        _selectionInitialized = true;
        await _savePreferences();
      } else {
        final newlyDiscovered = availableIds.difference(_knownCalendarIds);
        final pruned = _selectedCalendarIds.intersection(availableIds);
        final updatedSelection = {...pruned, ...newlyDiscovered};
        final updatedKnown = _knownCalendarIds.union(availableIds);
        if (updatedSelection.length != _selectedCalendarIds.length ||
            !_selectedCalendarIds.containsAll(updatedSelection) ||
            updatedKnown.length != _knownCalendarIds.length) {
          _selectedCalendarIds = updatedSelection;
          _knownCalendarIds = updatedKnown;
          await _savePreferences();
        }
      }
    } catch (e) {
      _errorMessage = 'Gagal memuat daftar kalender: $e';
    } finally {
      _isLoadingCalendars = false;
      notifyListeners();
    }
  }

  Future<void> toggleCalendarSelection(String calendarId) async {
    final updated = Set<String>.from(_selectedCalendarIds);
    if (updated.contains(calendarId)) {
      updated.remove(calendarId);
    } else {
      updated.add(calendarId);
    }

    _selectedCalendarIds = updated;
    _selectionInitialized = true;
    _knownCalendarIds = _knownCalendarIds
        .union(_calendars.map((c) => c.id).toSet())
      ..add(calendarId);
    await _savePreferences();
    notifyListeners();

    if (_isSyncEnabled && _hasPermission) {
      await loadEventsForDate(_currentDate);
    }
  }

  Future<void> loadEventsForDate(DateTime date) async {
    _currentDate = TaskProvider.normalizeDate(date);

    if (!_isSyncEnabled || !_hasPermission || _selectedCalendarIds.isEmpty) {
      if (_events.isNotEmpty || _timelineEventsByDate.isNotEmpty) {
        _events = [];
        _timelineEventsByDate = {};
        notifyListeners();
      }
      return;
    }

    _isLoadingEvents = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final windowDates = List<DateTime>.generate(
        TaskProvider.timelineLookaheadDays + 1,
        (offset) => DateTime(
          _currentDate.year,
          _currentDate.month,
          _currentDate.day + offset,
        ),
      );

      final fetchedByDay = await Future.wait(
        windowDates.map(
          (day) => _calendarService.getEventsForDate(day, _selectedCalendarIds),
        ),
      );

      final grouped = <String, List<CalendarEventModel>>{};
      for (var i = 0; i < windowDates.length; i++) {
        grouped[TaskModel.formatDateKey(windowDates[i])] = fetchedByDay[i];
      }

      _events = fetchedByDay.first;
      _timelineEventsByDate = grouped;
    } catch (e) {
      _events = [];
      _timelineEventsByDate = {};
      _errorMessage = 'Gagal memuat acara kalender: $e';
    } finally {
      _isLoadingEvents = false;
      notifyListeners();
    }
  }
}
