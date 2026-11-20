import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zettask/l10n/app_localizations.dart';
import 'package:zettask/l10n/l10n_helpers.dart';
import 'package:zettask/models/calendar_event_model.dart';
import 'package:zettask/providers/calendar_provider.dart';
import 'package:zettask/services/calendar_service.dart';
import 'package:zettask/widgets/timeline_calendar_event_item.dart';

class _HolidayCalendarService implements DeviceCalendarService {
  _HolidayCalendarService({
    required this.calendars,
    required this.events,
    this.granted = true,
  });

  final List<DeviceCalendarInfo> calendars;
  final List<CalendarEventModel> events;
  bool granted;

  @override
  Future<bool> hasPermissions() async => granted;

  @override
  Future<bool> requestPermissions() async {
    granted = true;
    return true;
  }

  @override
  Future<bool> isPermissionPermanentlyDenied() async => false;

  @override
  Future<bool> openSettings() async => true;

  @override
  Future<List<DeviceCalendarInfo>> getCalendars() async => calendars;

  @override
  Future<List<CalendarEventModel>> getEventsForDate(
    DateTime date,
    Set<String> selectedCalendarIds,
  ) async {
    return events.where((e) {
      if (!selectedCalendarIds.contains(e.calendarId)) return false;
      return e.start.year == date.year &&
          e.start.month == date.month &&
          e.start.day == date.day;
    }).toList();
  }
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting();
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test(
      'normalizeEventForDate menangani all-day event (Hari Libur Nasional UTC) tanpa tergeser zona waktu',
      () {
    // Simulasi Android CalendarContract: Hari Kemerdekaan RI disimpan sebagai UTC midnight
    final utcStart = DateTime.utc(2026, 8, 17);
    final utcEnd = DateTime.utc(2026, 8, 18);

    // Tanggal 17 Agustus -> cocok
    final onHoliday = PlatformDeviceCalendarService.normalizeEventForDate(
      id: 'hol_17',
      calendarId: 'cal_holidays',
      calendarName: 'Hari Libur di Indonesia',
      title: 'Hari Kemerdekaan Republik Indonesia',
      description: 'Hari libur nasional',
      location: 'Indonesia',
      startDate: utcStart,
      endDate: utcEnd,
      isAllDay: true,
      colorHex: '#0F766E',
      targetDate: DateTime(2026, 8, 17),
    );
    expect(onHoliday, isNotNull);
    expect(onHoliday!.isAllDay, isTrue);
    expect(onHoliday.start, DateTime(2026, 8, 17));
    expect(onHoliday.calendarName, 'Hari Libur di Indonesia');

    // Tanggal 16 Agustus (sehari sebelumnya) -> tidak bocor
    final dayBefore = PlatformDeviceCalendarService.normalizeEventForDate(
      id: 'hol_17',
      calendarId: 'cal_holidays',
      calendarName: 'Hari Libur di Indonesia',
      title: 'Hari Kemerdekaan Republik Indonesia',
      description: 'Hari libur nasional',
      location: 'Indonesia',
      startDate: utcStart,
      endDate: utcEnd,
      isAllDay: true,
      colorHex: '#0F766E',
      targetDate: DateTime(2026, 8, 16),
    );
    expect(dayBefore, isNull);

    // Tanggal 18 Agustus (sehari sesudahnya, boundary eksklusif) -> tidak bocor
    final dayAfter = PlatformDeviceCalendarService.normalizeEventForDate(
      id: 'hol_17',
      calendarId: 'cal_holidays',
      calendarName: 'Hari Libur di Indonesia',
      title: 'Hari Kemerdekaan Republik Indonesia',
      description: 'Hari libur nasional',
      location: 'Indonesia',
      startDate: utcStart,
      endDate: utcEnd,
      isAllDay: true,
      colorHex: '#0F766E',
      targetDate: DateTime(2026, 8, 18),
    );
    expect(dayAfter, isNull);
  });

  test(
      'CalendarProvider otomatis memilih semua kalender termasuk Hari Libur Nasional dan memuat rentang Timeline',
      () async {
    final today = DateTime(2026, 8, 15);
    final holidayDate = DateTime(2026, 8, 17);

    final service = _HolidayCalendarService(
      granted: false,
      calendars: const [
        DeviceCalendarInfo(
          id: 'cal_primary',
          name: 'Pribadi',
          accountName: 'user@gmail.com',
          colorHex: '#2563EB',
          isPrimary: true,
        ),
        DeviceCalendarInfo(
          id: 'cal_holidays',
          name: 'Hari Libur di Indonesia',
          accountName: 'id.indonesian#holiday@group.v.calendar.google.com',
          colorHex: '#0F766E',
          isPrimary: false,
        ),
        DeviceCalendarInfo(
          id: 'cal_birthdays',
          name: 'Ulang Tahun',
          colorHex: '#D97706',
          isPrimary: false,
        ),
      ],
      events: [
        CalendarEventModel(
          id: 'ev_1',
          calendarId: 'cal_primary',
          calendarName: 'Pribadi',
          title: 'Sprint Review',
          start: DateTime(2026, 8, 15, 10, 0),
          end: DateTime(2026, 8, 15, 11, 0),
          isAllDay: false,
          colorHex: '#2563EB',
        ),
        CalendarEventModel(
          id: 'ev_holiday',
          calendarId: 'cal_holidays',
          calendarName: 'Hari Libur di Indonesia',
          title: 'Hari Kemerdekaan RI',
          start: holidayDate,
          end: DateTime(2026, 8, 18),
          isAllDay: true,
          colorHex: '#0F766E',
        ),
      ],
    );

    final provider = CalendarProvider(
      calendarService: service,
      initialDate: today,
    );
    await provider.initialize();
    await provider.setSyncEnabled(true);

    // Semua kalender (termasuk Hari Libur & Ulang Tahun) otomatis terpilih
    expect(
      provider.selectedCalendarIds,
      containsAll(['cal_primary', 'cal_holidays', 'cal_birthdays']),
    );
    expect(provider.scheduledEvents.length, 1);
    expect(provider.scheduledEvents.first.title, 'Sprint Review');

    // Timeline lookahead langsung memuat Hari Libur Nasional di tanggal mendatang
    expect(provider.upcomingDatesWithEvents, contains(holidayDate));
    final upcomingHolidays = provider.allDayEventsForDate(holidayDate);
    expect(upcomingHolidays.length, 1);
    expect(upcomingHolidays.first.title, 'Hari Kemerdekaan RI');
  });

  testWidgets(
      'TimelineCalendarEventItem menampilkan badge kalender tanpa centang dan membuka CalendarEventDetailSheet read-only',
      (WidgetTester tester) async {
    final holidayEvent = CalendarEventModel(
      id: 'hol_1',
      calendarId: 'cal_holidays',
      calendarName: 'Hari Libur di Indonesia',
      title: 'Hari Kemerdekaan RI',
      description: 'Libur nasional Republik Indonesia',
      location: 'Indonesia',
      start: DateTime(2026, 8, 17),
      end: DateTime(2026, 8, 18),
      isAllDay: true,
      colorHex: '#0F766E',
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('id'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: zettaskLocalizationsDelegates,
        home: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: TimelineCalendarEventItem(
              event: holidayEvent,
              calendarName: 'Hari Libur di Indonesia',
              calendarAccount: 'user@gmail.com',
              isFirstInSection: true,
              isLastInSection: true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Kartu menampilkan judul, badge nama kalender, dan tanpa bulatan status tugas
    expect(find.text('Hari Kemerdekaan RI'), findsOneWidget);
    expect(find.text('Hari Libur di Indonesia'), findsOneWidget);
    expect(find.byKey(const ValueKey('task_status_circle')), findsNothing);

    // Ketuk kartu -> buka CalendarEventDetailSheet read-only
    await tester.tap(find.text('Hari Kemerdekaan RI'));
    await tester.pumpAndSettle();

    final Finder sheetFinder = find.byType(CalendarEventDetailSheet);
    expect(sheetFinder, findsOneWidget);
    expect(
      find.descendant(
        of: sheetFinder,
        matching: find.text(
          'Disinkronkan dari kalender perangkat. Item ini hanya dapat dibaca dan tidak dapat diedit di Zettask.',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: sheetFinder,
        matching: find.text('Hari Libur di Indonesia\nuser@gmail.com'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: sheetFinder, matching: find.text('Indonesia')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: sheetFinder,
        matching: find.text('Libur nasional Republik Indonesia'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: sheetFinder, matching: find.text('Tutup')),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.delete_outline_rounded), findsNothing);
    expect(find.byIcon(Icons.edit_outlined), findsNothing);
  });
}
