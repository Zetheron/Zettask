import 'dart:async';
import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zettask/l10n/app_localizations.dart';
import 'package:zettask/main.dart';
import 'package:zettask/models/calendar_event_model.dart';
import 'package:zettask/models/note_model.dart';
import 'package:zettask/models/project_model.dart';
import 'package:zettask/models/repeating_task_model.dart';
import 'package:zettask/models/stats_model.dart';
import 'package:zettask/models/tag_model.dart';
import 'package:zettask/models/task_model.dart';
import 'package:zettask/models/task_template_model.dart';
import 'package:zettask/providers/task_provider.dart';
import 'package:zettask/services/calendar_service.dart';
import 'package:zettask/services/database_service.dart';
import 'package:zettask/services/export_service.dart';
import 'package:zettask/services/home_widget_service.dart';
import 'package:zettask/services/notification_service.dart';
import 'package:zettask/widgets/task_editor_sheet.dart';
import 'package:zettask/widgets/timeline_task_item.dart';

class _SubtaskFakeDatabase implements DatabaseService {
  _SubtaskFakeDatabase([List<TaskModel>? seed]) {
    if (seed != null) {
      for (final task in seed) {
        final id = task.id ?? _nextId++;
        if (id >= _nextId) _nextId = id + 1;
        // Round-trip through SQLite map representation to verify persistence fidelity.
        final stored = Map<String, dynamic>.from(task.copyWith(id: id).toMap());
        _taskRows[id] = stored;
      }
    }
  }

  final Map<int, Map<String, dynamic>> _taskRows = {};
  int _nextId = 1;

  List<TaskModel> get _all => _taskRows.values.map(TaskModel.fromMap).toList();

  TaskModel? storedTaskById(int id) {
    final row = _taskRows[id];
    return row == null ? null : TaskModel.fromMap(row);
  }

  @override
  Future<Database> get database => throw UnimplementedError();

  @override
  Future<int> insertTask(TaskModel task) async {
    final id = task.id ?? _nextId++;
    _taskRows[id] = Map<String, dynamic>.from(task.copyWith(id: id).toMap());
    return id;
  }

  @override
  Future<List<TaskModel>> getTasksByDate(DateTime date) async {
    final key = TaskModel.formatDateKey(date);
    return _all
        .where((t) => t.date != null && TaskModel.formatDateKey(t.date!) == key)
        .toList();
  }

  @override
  Future<List<TaskModel>> getTasksInDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final startKey = TaskModel.formatDateKey(start);
    final endKey = TaskModel.formatDateKey(end);
    return _all.where((t) {
      if (t.date == null) return false;
      final key = TaskModel.formatDateKey(t.date!);
      return key.compareTo(startKey) >= 0 && key.compareTo(endKey) <= 0;
    }).toList();
  }

  @override
  Future<List<TaskModel>> getUnplannedTasks() async =>
      _all.where((t) => t.date == null).toList();

  @override
  Future<List<TaskModel>> getOverdueTasks(DateTime today) async {
    final todayKey = TaskModel.formatDateKey(today);
    return _all
        .where(
          (t) =>
              !t.isCompleted &&
              !t.isCancelled &&
              t.date != null &&
              TaskModel.formatDateKey(t.date!).compareTo(todayKey) < 0,
        )
        .toList();
  }

  @override
  Future<Set<String>> getDatesWithTasks(DateTime start, DateTime end) async {
    final list = await getTasksInDateRange(start, end);
    return list
        .where((t) => t.date != null)
        .map((t) => TaskModel.formatDateKey(t.date!))
        .toSet();
  }

  @override
  Future<List<TaskModel>> searchTasks(String query) async => const [];

  @override
  Future<int> updateTask(TaskModel task) async {
    if (task.id == null) throw ArgumentError('Task id null');
    _taskRows[task.id!] = Map<String, dynamic>.from(task.toMap());
    return 1;
  }

  @override
  Future<int> toggleTaskComplete(
    int id,
    bool isCompleted, {
    DateTime? completedAt,
  }) async {
    final existing = storedTaskById(id);
    if (existing == null) return 0;
    _taskRows[id] = Map<String, dynamic>.from(
      existing
          .copyWith(
            isCompleted: isCompleted,
            isCancelled: false,
            completedAt: isCompleted ? (completedAt ?? DateTime.now()) : null,
            clearCompletedAt: !isCompleted,
          )
          .toMap(),
    );
    return 1;
  }

  @override
  Future<List<TaskModel>> getAllTasks() async => _all;

  @override
  Future<List<DailyCompletionStat>> getLast7DaysCompletionStats(
    DateTime today,
  ) async =>
      WorkspaceStats.empty(today: today).last7Days;

  @override
  Future<List<DailyCompletionStat>> getLast30DaysCompletionStats(
    DateTime today,
  ) async =>
      WorkspaceStats.empty(today: today).last30Days;

  @override
  Future<int> deleteTask(int id) async {
    _taskRows.remove(id);
    return 1;
  }

  @override
  Future<int> insertRepeatingRule(RepeatingTaskRule rule) async => 1;

  @override
  Future<List<RepeatingTaskRule>> getRepeatingRules({
    bool activeOnly = true,
  }) async =>
      const [];

  @override
  Future<RepeatingTaskRule?> getRepeatingRuleById(int id) async => null;

  @override
  Future<int> updateRepeatingRule(RepeatingTaskRule rule) async => 1;

  @override
  Future<int> deleteRepeatingRule(int id) async => 1;

  @override
  Future<bool> hasTaskForRepeatingRuleOnDate(
    int ruleId,
    DateTime date,
  ) async =>
      false;

  @override
  Future<List<TaskModel>> getIncompleteFutureTasksForRule(
    int ruleId,
    DateTime fromDate,
  ) async =>
      const [];

  @override
  Future<int> deleteIncompleteFutureTasksForRule(
    int ruleId,
    DateTime fromDate,
  ) async =>
      0;

  @override
  Future<int> getCompletedCountForRule(int ruleId) async => 0;

  @override
  Future<Set<String>> getCompletedDatesForRuleInRange(
    int ruleId,
    DateTime start,
    DateTime end,
  ) async =>
      const {};

  @override
  Future<int> insertProject(ProjectModel project) async => 1;

  @override
  Future<List<ProjectModel>> getProjects() async => const [];

  @override
  Future<int> updateProject(ProjectModel project) async => 1;

  @override
  Future<int> deleteProject(int id) async => 1;

  @override
  Future<int> insertTag(TagModel tag) async => 1;

  @override
  Future<List<TagModel>> getTags() async => const [];

  @override
  Future<int> updateTag(TagModel tag) async => 1;

  @override
  Future<int> deleteTag(int id) async => 1;

  @override
  Future<int> insertNote(NoteModel note) async => 1;

  @override
  Future<List<NoteModel>> getNotes() async => const [];

  @override
  Future<int> updateNote(NoteModel note) async => 1;

  @override
  Future<int> deleteNote(int id) async => 1;

  @override
  Future<int> insertTemplate(TaskTemplateModel template) async => 1;

  @override
  Future<List<TaskTemplateModel>> getTemplates() async => const [];

  @override
  Future<int> updateTemplate(TaskTemplateModel template) async => 1;

  @override
  Future<int> deleteTemplate(int id) async => 1;

  @override
  Future<List<TaskModel>> getTasksByProject(int projectId) async =>
      _all.where((t) => t.projectId == projectId).toList();

  @override
  Future<List<TaskModel>> getTasksByTag(int tagId) async =>
      _all.where((t) => t.tagId == tagId).toList();

  @override
  Future<Map<int, ProjectProgress>> getProjectTaskCounts() async => const {};

  @override
  Future<Map<int, int>> getTagTaskCounts() async => const {};

  @override
  Future<void> close() async {}
}

class _SpyInteractiveNotificationService
    implements InteractiveNotificationService {
  final StreamController<NotificationResponse> _controller =
      StreamController<NotificationResponse>.broadcast();
  final List<TaskModel> scheduledTasks = [];
  final List<TaskModel> snoozedTasks = [];
  final List<int> cancelledTaskIds = [];
  NotificationStrings? lastStrings;

  void emitResponse(NotificationResponse response) {
    _controller.add(response);
  }

  void dispose() {
    _controller.close();
  }

  @override
  Stream<NotificationResponse> get notificationResponses => _controller.stream;

  @override
  Future<NotificationResponse?> getInitialNotificationResponse() async => null;

  @override
  Future<void> init() async {}

  @override
  Future<bool> requestPermissions() async => true;

  @override
  Future<void> scheduleTaskReminder(TaskModel task) async {
    scheduledTasks.add(task);
  }

  @override
  Future<void> cancelTaskReminder(int taskId) async {
    cancelledTaskIds.add(taskId);
  }

  @override
  Future<void> snoozeTaskReminder(
    TaskModel task, {
    Duration delay = NotificationService.defaultSnoozeDuration,
  }) async {
    snoozedTasks.add(task);
  }

  @override
  void updateLocalization(AppLocalizations l10n) {
    lastStrings = NotificationStrings.fromLocalizations(l10n);
  }
}

class _NoopCalendarService implements DeviceCalendarService {
  @override
  Future<bool> hasPermissions() async => false;

  @override
  Future<bool> requestPermissions() async => false;

  @override
  Future<bool> isPermissionPermanentlyDenied() async => false;

  @override
  Future<bool> openSettings() async => false;

  @override
  Future<List<DeviceCalendarInfo>> getCalendars() async => const [];

  @override
  Future<List<CalendarEventModel>> getEventsForDate(
    DateTime date,
    Set<String> selectedCalendarIds,
  ) async =>
      const [];
}

class _NoopHomeWidgetService implements HomeWidgetSyncService {
  @override
  Future<void> updateTodayTasks(
    List<TaskModel> todayTasks, {
    String? widgetTitle,
    String? widgetEmptyText,
  }) async {}

  @override
  Future<void> updateWidgetLabels({
    required String widgetTitle,
    required String widgetEmptyText,
  }) async {}

  @override
  Future<Uri?> getInitiallyLaunchedUri() async => null;

  @override
  Stream<Uri?> get widgetClicked => const Stream<Uri?>.empty();
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting('id_ID');
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    final dispatcher = TestWidgetsFlutterBinding.instance.platformDispatcher;
    dispatcher.localeTestValue = const Locale('id', 'ID');
    dispatcher.localesTestValue = const [Locale('id', 'ID')];
  });

  tearDown(() {
    final dispatcher = TestWidgetsFlutterBinding.instance.platformDispatcher;
    dispatcher.clearLocaleTestValue();
    dispatcher.clearLocalesTestValue();
  });

  group('Subtask Cancelled Model, Migrasi v8, & Persistensi Provider', () {
    test(
      'ChecklistItem serialisasi pending/completed/cancelled, migrasi JSON lama v7 -> v8 non-destruktif, dan persistensi di TaskProvider',
      () async {
        expect(DatabaseService.databaseVersion, 8);

        // 1. Legacy v7 JSON tanpa kolom isCancelled/status tetap ter-migrasi aman tanpa kehilangan data
        const legacyJson =
            '[{"title":"Beli kopi","isDone":false},{"title":"Kirim laporan","isDone":true}]';
        final migratedJson =
            DatabaseService.normalizeChecklistItemsJson(legacyJson);
        final decoded = jsonDecode(migratedJson) as List<dynamic>;
        expect(decoded.length, 2);

        final first = ChecklistItem.fromMap(
          Map<String, dynamic>.from(decoded[0] as Map),
        );
        final second = ChecklistItem.fromMap(
          Map<String, dynamic>.from(decoded[1] as Map),
        );
        expect(first.title, 'Beli kopi');
        expect(first.status, SubtaskStatus.pending);
        expect(first.isCancelled, isFalse);
        expect(second.title, 'Kirim laporan');
        expect(second.status, SubtaskStatus.completed);
        expect(second.isCancelled, isFalse);

        // 2. Round-trip status cancelled & mutual exclusivity
        final cancelledItem = first.copyWith(isCancelled: true);
        expect(cancelledItem.status, SubtaskStatus.cancelled);
        expect(cancelledItem.isDone, isFalse);
        expect(cancelledItem.isCancelled, isTrue);

        final restoredFromMap = ChecklistItem.fromMap(cancelledItem.toMap());
        expect(restoredFromMap.status, SubtaskStatus.cancelled);
        expect(restoredFromMap.isCancelled, isTrue);
        expect(restoredFromMap.isDone, isFalse);

        // 3. Persistensi di TaskProvider + penjadwalan ulang pengingat otomatis
        final today = DateTime(2026, 11, 23, 8, 0);
        final db = _SubtaskFakeDatabase([
          TaskModel(
            id: 42,
            title: 'Rilis versi baru',
            date: DateTime(2026, 11, 23),
            startTime: '14:00',
            reminderMinutesBefore: 10,
            checklistItems: const [
              ChecklistItem(title: 'Jalankan analyze', isDone: true),
              ChecklistItem(title: 'Siapkan changelog', isDone: false),
              ChecklistItem(title: 'Upload APK', isDone: false),
            ],
          ),
        ]);
        final notif = _SpyInteractiveNotificationService();
        addTearDown(notif.dispose);

        final provider = TaskProvider(
          databaseService: db,
          notificationService: notif,
          homeWidgetService: _NoopHomeWidgetService(),
          initialDate: today,
          nowProvider: () => today,
        );
        await provider.initialize();

        final initialTask = provider.tasks.first;
        expect(initialTask.completedSubtasksCount, 1);
        expect(initialTask.totalActiveSubtasksCount, 3);

        // Cancel sub-tugas indeks 1
        final cancelledOk = await provider.cancelChecklistItem(initialTask, 1);
        expect(cancelledOk, isTrue);

        final persistedAfterCancel = db.storedTaskById(42)!;
        expect(persistedAfterCancel.checklistItems[1].isCancelled, isTrue);
        expect(
          persistedAfterCancel.checklistItems[1].status,
          SubtaskStatus.cancelled,
        );
        expect(persistedAfterCancel.totalActiveSubtasksCount, 2);
        expect(persistedAfterCancel.completedSubtasksCount, 1);
        expect(notif.scheduledTasks.length, 1);
        expect(notif.scheduledTasks.last.activeChecklistItems.length, 2);

        // Centang sub-tugas indeks 2 -> semua sub-tugas aktif selesai (2/2) & notifikasi dijadwalkan ulang
        await provider.toggleChecklistItem(persistedAfterCancel, 2);
        final persistedAfterCheck = db.storedTaskById(42)!;
        expect(persistedAfterCheck.completedSubtasksCount, 2);
        expect(persistedAfterCheck.totalActiveSubtasksCount, 2);
        expect(persistedAfterCheck.allActiveSubtasksCompleted, isTrue);
        expect(notif.scheduledTasks.length, 2);

        // Pulihkan sub-tugas indeks 1 -> kembali ke pending & notifikasi dijadwalkan ulang
        final restoredOk = await provider.restoreChecklistItem(
          persistedAfterCheck,
          1,
        );
        expect(restoredOk, isTrue);
        final persistedAfterRestore = db.storedTaskById(42)!;
        expect(persistedAfterRestore.checklistItems[1].isCancelled, isFalse);
        expect(persistedAfterRestore.checklistItems[1].isDone, isFalse);
        expect(
          persistedAfterRestore.checklistItems[1].status,
          SubtaskStatus.pending,
        );
        expect(persistedAfterRestore.totalActiveSubtasksCount, 3);
        expect(notif.scheduledTasks.length, 3);

        // Verifikasi Stats & CSV mengecualikan sub-tugas yang di-cancel
        final statsTask = persistedAfterCancel;
        final stats = WorkspaceStats.compute(
          tasks: [statsTask],
          projects: const [],
          today: today,
        );
        expect(stats.totalChecklists7Days, 1);
        final csv = CsvExportService.buildTasksCsv(
          tasks: [statsTask],
          projectNames: const {},
          tagNames: const {},
        );
        expect(csv, contains(',2,'));
      },
    );
  });

  group('Interaksi UI Sub-tugas Cancelled + Undo & Restore di Detail Tugas', () {
    testWidgets(
      'Long-press sub-tugas menampilkan ikon ✕ singkat, menyembunyikannya dengan SnackBar Undo, dan Undo memulihkan ke pending',
      (WidgetTester tester) async {
        final today = DateTime(2026, 11, 23);
        final db = _SubtaskFakeDatabase([
          TaskModel(
            id: 7,
            title: 'Persiapan presentasi',
            date: today,
            startTime: '10:00',
            reminderMinutesBefore: 15,
            checklistItems: const [
              ChecklistItem(title: 'Buat slide utama', isDone: true),
              ChecklistItem(title: 'Cetak handout', isDone: false),
              ChecklistItem(title: 'Tes proyektor', isDone: false),
            ],
          ),
        ]);
        final notif = _SpyInteractiveNotificationService();
        addTearDown(notif.dispose);

        await tester.pumpWidget(
          ZettaskApp(
            databaseService: db,
            notificationService: notif,
            calendarService: _NoopCalendarService(),
            homeWidgetService: _NoopHomeWidgetService(),
            initialLocale: const Locale('id'),
            initialDate: today,
            nowProvider: () => DateTime(2026, 11, 23, 8, 0),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(TimelineTaskItem), findsOneWidget);
        expect(find.text('1/3 sub-tugas'), findsOneWidget);
        expect(find.text('Cetak handout'), findsOneWidget);

        // Long-press baris sub-tugas indeks 1 ("Cetak handout")
        final rowFinder = find.byKey(const ValueKey('subtask_row_7_1'));
        expect(rowFinder, findsOneWidget);
        await tester.ensureVisible(rowFinder);
        await tester.pumpAndSettle();
        await tester.longPress(rowFinder);
        await tester.pump(const Duration(milliseconds: 60));

        // Animasi singkat ikon ✕ muncul pada lingkaran sub-tugas sebelum disembunyikan
        expect(
          find.descendant(
            of: find.byKey(const ValueKey('subtask_circle_7_1')),
            matching: find.byIcon(Icons.close_rounded),
          ),
          findsOneWidget,
        );

        // Tunggu animasi singkat selesai -> item hilang dari daftar aktif & SnackBar Undo tampil
        await tester.pumpAndSettle();
        expect(find.text('Cetak handout'), findsNothing);
        expect(find.text('1/2 sub-tugas'), findsOneWidget);
        expect(find.text('Sub-tugas dibatalkan'), findsOneWidget);
        expect(find.text('Urungkan'), findsOneWidget);
        expect(db.storedTaskById(7)!.checklistItems[1].isCancelled, isTrue);

        // Ketuk tombol Undo ("Urungkan") -> sub-tugas kembali aktif (pending)
        await tester.tap(find.text('Urungkan'));
        await tester.pumpAndSettle();

        expect(find.text('Cetak handout'), findsOneWidget);
        expect(find.text('1/3 sub-tugas'), findsOneWidget);
        final restored = db.storedTaskById(7)!.checklistItems[1];
        expect(restored.isCancelled, isFalse);
        expect(restored.isDone, isFalse);
      },
    );

    testWidgets(
      'Di TaskEditorSheet, sub-tugas cancelled tetap terlihat dengan badge Dibatalkan & ikon ✕ serta dapat di-restore',
      (WidgetTester tester) async {
        final today = DateTime(2026, 11, 23);
        final db = _SubtaskFakeDatabase([
          TaskModel(
            id: 8,
            title: 'Belanja mingguan',
            date: today,
            checklistItems: const [
              ChecklistItem(title: 'Beras', isDone: false),
              ChecklistItem(title: 'Soda manis', isDone: false, isCancelled: true),
            ],
          ),
        ]);
        final notif = _SpyInteractiveNotificationService();
        addTearDown(notif.dispose);

        await tester.pumpWidget(
          ZettaskApp(
            databaseService: db,
            notificationService: notif,
            calendarService: _NoopCalendarService(),
            homeWidgetService: _NoopHomeWidgetService(),
            initialLocale: const Locale('id'),
            initialDate: today,
            nowProvider: () => today,
          ),
        );
        await tester.pumpAndSettle();

        // Di Timeline, sub-tugas yang dibatalkan tersembunyi
        expect(find.text('Beras'), findsOneWidget);
        expect(find.text('Soda manis'), findsNothing);
        expect(find.text('0/1 sub-tugas'), findsOneWidget);

        // Ketuk kartu tugas untuk membuka TaskEditorSheet
        await tester.tap(find.text('Belanja mingguan'));
        await tester.pumpAndSettle();

        expect(find.byType(TaskEditorSheet), findsOneWidget);
        final cancelledRow = find.byKey(const ValueKey('editor_subtask_row_1'));
        await tester.scrollUntilVisible(
          cancelledRow,
          200,
          scrollable: find.descendant(
            of: find.byType(TaskEditorSheet),
            matching: find.byType(Scrollable),
          ).first,
        );
        await tester.pumpAndSettle();

        expect(find.text('Soda manis'), findsOneWidget);
        expect(find.text('Dibatalkan'), findsOneWidget);
        expect(
          find.descendant(
            of: cancelledRow,
            matching: find.byIcon(Icons.close_rounded),
          ),
          findsWidgets,
        );

        // Ketuk tombol restore pada sub-tugas yang dibatalkan
        await tester.tap(
          find.byKey(const ValueKey('editor_subtask_cancel_toggle_1')),
        );
        await tester.pumpAndSettle();

        expect(find.text('Dibatalkan'), findsNothing);

        // Simpan perubahan dan pastikan sub-tugas muncul kembali di Timeline
        await tester.tap(find.text('Simpan Perubahan'));
        await tester.pumpAndSettle();

        expect(find.text('Soda manis'), findsOneWidget);
        expect(find.text('0/2 sub-tugas'), findsOneWidget);
        expect(db.storedTaskById(8)!.checklistItems[1].isCancelled, isFalse);
      },
    );
  });

  group('Notifikasi Pengingat Layar Kunci + Daftar Sub-tugas & Navigasi Tap', () {
    test(
      'buildReminderContent memakai NotificationVisibility.public, InboxStyleInformation, simbol ○/✓, batas 5 + "+N lainnya", dan mengecualikan sub-tugas cancelled',
      () {
        final taskWithSubtasks = TaskModel(
          id: 101,
          title: 'Sprint Review',
          description: 'Catatan cadangan',
          date: DateTime(2026, 11, 23),
          startTime: '15:00',
          reminderMinutesBefore: 10,
          checklistItems: const [
            ChecklistItem(title: 'Demo fitur A', isDone: true),
            ChecklistItem(title: 'Sub-tugas batal', isCancelled: true),
            ChecklistItem(title: 'Demo fitur B', isDone: false),
            ChecklistItem(title: 'Review metrik', isDone: true),
            ChecklistItem(title: 'Cek bug minor', isDone: false),
            ChecklistItem(title: 'Diskusi roadmap', isDone: false),
            ChecklistItem(title: 'Catat tindak lanjut', isDone: false),
            ChecklistItem(title: 'Bagikan rekaman', isDone: false),
          ],
        );

        final content = NotificationService.buildReminderContent(
          taskWithSubtasks,
          strings: NotificationStrings.indonesian,
        );

        expect(content.title, 'Sprint Review');
        expect(content.payload, '101');
        expect(
          content.androidDetails.visibility,
          NotificationVisibility.public,
        );
        expect(content.androidDetails.importance, Importance.high);
        expect(content.androidDetails.priority, Priority.high);

        // Pertahankan 3 tombol aksi notifikasi (Selesai, Tunda, Tutup)
        final actions = content.androidDetails.actions!;
        expect(actions.length, 3);
        expect(
          actions.map((a) => a.id).toList(),
          [
            NotificationService.actionCompleteId,
            NotificationService.actionSnoozeId,
            NotificationService.actionDismissId,
          ],
        );
        expect(actions.map((a) => a.title).toList(), ['Selesai', 'Tunda', 'Tutup']);

        // Style InboxStyleInformation dengan 5 baris aktif + "+2 lainnya" (7 aktif, 1 cancelled dikecualikan)
        expect(content.androidDetails.styleInformation, isA<InboxStyleInformation>());
        final inboxStyle =
            content.androidDetails.styleInformation! as InboxStyleInformation;
        expect(inboxStyle.summaryText, '2/7 selesai');
        expect(inboxStyle.lines, [
          '✓ Demo fitur A',
          '○ Demo fitur B',
          '✓ Review metrik',
          '○ Cek bug minor',
          '○ Diskusi roadmap',
          '+2 lainnya',
        ]);
        expect(
          inboxStyle.lines.any((line) => line.contains('Sub-tugas batal')),
          isFalse,
        );

        // Tugas tanpa sub-tugas aktif (semua cancelled atau kosong) fallback ke catatan/deskripsi
        final taskNoActiveSubtasks = TaskModel(
          id: 102,
          title: 'Telepon klien',
          description: 'Konfirmasi jadwal pengiriman pekan depan',
          date: DateTime(2026, 11, 23),
          startTime: '16:00',
          reminderMinutesBefore: 0,
          checklistItems: const [
            ChecklistItem(title: 'Sudah dibatalkan', isCancelled: true),
          ],
        );
        final noteContent = NotificationService.buildReminderContent(
          taskNoActiveSubtasks,
          strings: NotificationStrings.indonesian,
        );
        expect(
          noteContent.androidDetails.visibility,
          NotificationVisibility.public,
        );
        expect(noteContent.inboxLines, isEmpty);
        expect(noteContent.body, 'Konfirmasi jadwal pengiriman pekan depan');
        expect(
          noteContent.androidDetails.styleInformation,
          isA<BigTextStyleInformation>(),
        );
      },
    );

    test('Seluruh 16 bahasa memiliki terjemahan lengkap untuk fitur sub-tugas batal & notifikasi', () {
      expect(AppLocalizations.supportedLocales.length, greaterThanOrEqualTo(15));
      for (final locale in AppLocalizations.supportedLocales) {
        final l10n = lookupAppLocalizations(locale);
        expect(l10n.subtaskMarkedCancelled, isNotEmpty);
        expect(l10n.subtaskCancelledBadge, isNotEmpty);
        expect(l10n.cancelSubtaskTooltip, isNotEmpty);
        expect(l10n.restoreSubtaskTooltip, isNotEmpty);
        expect(l10n.notificationActionComplete, isNotEmpty);
        expect(l10n.notificationActionSnooze, isNotEmpty);
        expect(l10n.notificationActionDismiss, isNotEmpty);
        expect(l10n.notificationSubtasksMore(3), contains('3'));
        expect(l10n.notificationSubtasksSummary(1, 4), contains('1'));
        expect(l10n.notificationSubtasksSummary(1, 4), contains('4'));
      }
    });

    testWidgets(
      'Mengetuk notifikasi pengingat langsung membuka tugas terkait di TaskEditorSheet',
      (WidgetTester tester) async {
        final today = DateTime(2026, 11, 23);
        final tomorrow = DateTime(2026, 11, 24);
        final db = _SubtaskFakeDatabase([
          TaskModel(
            id: 55,
            title: 'Cek kesiapan deploy',
            date: tomorrow,
            startTime: '09:00',
            reminderMinutesBefore: 10,
            checklistItems: const [
              ChecklistItem(title: 'Backup database', isDone: false),
            ],
          ),
        ]);
        final notif = _SpyInteractiveNotificationService();
        addTearDown(notif.dispose);

        await tester.pumpWidget(
          ZettaskApp(
            databaseService: db,
            notificationService: notif,
            calendarService: _NoopCalendarService(),
            homeWidgetService: _NoopHomeWidgetService(),
            initialLocale: const Locale('id'),
            initialDate: today,
            nowProvider: () => today,
          ),
        );
        await tester.pumpAndSettle();

        // Simulasikan pengguna mengetuk notifikasi tugas #55
        notif.emitResponse(
          const NotificationResponse(
            notificationResponseType:
                NotificationResponseType.selectedNotification,
            payload: '55',
          ),
        );
        await tester.pumpAndSettle();

        // Langsung berpindah ke tanggal tugas & terbuka di TaskEditorSheet dengan sub-tugas terkait
        expect(find.byType(TaskEditorSheet), findsOneWidget);
        expect(find.text('Cek kesiapan deploy'), findsWidgets);
        expect(
          find.descendant(
            of: find.byType(TaskEditorSheet),
            matching: find.text('Backup database'),
          ),
          findsOneWidget,
        );
      },
    );
  });
}
