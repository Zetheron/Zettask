import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import '../models/note_model.dart';
import '../models/project_model.dart';
import '../models/repeating_task_model.dart';
import '../models/stats_model.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';
import '../models/task_template_model.dart';

class DatabaseService {
  DatabaseService._internal();

  static final DatabaseService instance = DatabaseService._internal();

  static const String _databaseName = 'zettask.db';
  static const int _databaseVersion = 7;
  static const String tableTasks = 'tasks';
  static const String tableRepeatingTasks = 'repeating_tasks';
  static const String tableProjects = 'projects';
  static const String tableTags = 'tags';
  static const String tableNotes = 'notes';
  static const String tableTaskTemplates = 'task_templates';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = p.join(databasesPath, _databaseName);

    return openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableTasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL DEFAULT '',
        date TEXT,
        startTime TEXT,
        isCompleted INTEGER NOT NULL DEFAULT 0,
        is_cancelled INTEGER NOT NULL DEFAULT 0,
        priority INTEGER NOT NULL DEFAULT 1,
        colorHex TEXT NOT NULL DEFAULT '#0D9488',
        checklistItems TEXT NOT NULL DEFAULT '[]',
        reminderMinutesBefore INTEGER,
        repeatingRuleId INTEGER,
        projectId INTEGER,
        tagId INTEGER,
        completedAt TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableRepeatingTasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL DEFAULT '',
        startTime TEXT,
        priority INTEGER NOT NULL DEFAULT 1,
        colorHex TEXT NOT NULL DEFAULT '#0D9488',
        checklistItems TEXT NOT NULL DEFAULT '[]',
        reminderMinutesBefore INTEGER,
        frequency TEXT NOT NULL DEFAULT 'daily',
        weekdays TEXT NOT NULL DEFAULT '[]',
        startDate TEXT NOT NULL,
        isActive INTEGER NOT NULL DEFAULT 1,
        excludedDates TEXT NOT NULL DEFAULT '[]',
        projectId INTEGER,
        tagId INTEGER
      )
    ''');

    await _createOrganizeTables(db);

    await db.execute('CREATE INDEX idx_tasks_date ON $tableTasks (date)');
    await db.execute(
      'CREATE INDEX idx_tasks_repeating_rule ON $tableTasks (repeatingRuleId, date)',
    );
    await db.execute(
      'CREATE INDEX idx_tasks_project ON $tableTasks (projectId)',
    );
    await db.execute('CREATE INDEX idx_tasks_tag ON $tableTasks (tagId)');
  }

  Future<void> _createOrganizeTables(Database db) async {
    await db.execute('''
      CREATE TABLE $tableProjects (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        colorHex TEXT NOT NULL DEFAULT '#0D9488',
        createdAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableTags (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        colorHex TEXT NOT NULL DEFAULT '#2563EB'
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableNotes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL DEFAULT '',
        colorHex TEXT NOT NULL DEFAULT '#0D9488',
        tagId INTEGER,
        updatedAt TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableTaskTemplates (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT NOT NULL DEFAULT '',
        startTime TEXT,
        priority INTEGER NOT NULL DEFAULT 1,
        colorHex TEXT NOT NULL DEFAULT '#0D9488',
        checklistItems TEXT NOT NULL DEFAULT '[]',
        tagId INTEGER,
        projectId INTEGER
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE $tableTasks ADD COLUMN reminderMinutesBefore INTEGER',
      );
    }

    if (oldVersion < 3) {
      // SQLite cannot drop NOT NULL in place; rebuild the table safely without losing rows.
      await db.transaction((txn) async {
        await txn.execute('''
          CREATE TABLE ${tableTasks}_v3 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL DEFAULT '',
            date TEXT,
            startTime TEXT,
            isCompleted INTEGER NOT NULL DEFAULT 0,
            priority INTEGER NOT NULL DEFAULT 1,
            colorHex TEXT NOT NULL DEFAULT '#0D9488',
            checklistItems TEXT NOT NULL DEFAULT '[]',
            reminderMinutesBefore INTEGER
          )
        ''');

        await txn.execute('''
          INSERT INTO ${tableTasks}_v3 (
            id, title, description, date, startTime, isCompleted,
            priority, colorHex, checklistItems, reminderMinutesBefore
          )
          SELECT
            id, title, description, date, startTime, isCompleted,
            priority, colorHex, checklistItems, reminderMinutesBefore
          FROM $tableTasks
        ''');

        await txn.execute('DROP TABLE $tableTasks');
        await txn.execute(
          'ALTER TABLE ${tableTasks}_v3 RENAME TO $tableTasks',
        );
        await txn.execute(
          'CREATE INDEX idx_tasks_date ON $tableTasks (date)',
        );
      });
    }

    if (oldVersion < 4) {
      await db.execute(
        'ALTER TABLE $tableTasks ADD COLUMN repeatingRuleId INTEGER',
      );
      await db.execute('''
        CREATE TABLE $tableRepeatingTasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT NOT NULL DEFAULT '',
          startTime TEXT,
          priority INTEGER NOT NULL DEFAULT 1,
          colorHex TEXT NOT NULL DEFAULT '#0D9488',
          checklistItems TEXT NOT NULL DEFAULT '[]',
          reminderMinutesBefore INTEGER,
          frequency TEXT NOT NULL DEFAULT 'daily',
          weekdays TEXT NOT NULL DEFAULT '[]',
          startDate TEXT NOT NULL,
          isActive INTEGER NOT NULL DEFAULT 1,
          excludedDates TEXT NOT NULL DEFAULT '[]'
        )
      ''');
      await db.execute(
        'CREATE INDEX idx_tasks_repeating_rule ON $tableTasks (repeatingRuleId, date)',
      );
    }

    if (oldVersion < 5) {
      await db.execute('ALTER TABLE $tableTasks ADD COLUMN projectId INTEGER');
      await db.execute('ALTER TABLE $tableTasks ADD COLUMN tagId INTEGER');
      await db.execute(
        'ALTER TABLE $tableRepeatingTasks ADD COLUMN projectId INTEGER',
      );
      await db.execute(
        'ALTER TABLE $tableRepeatingTasks ADD COLUMN tagId INTEGER',
      );
      await _createOrganizeTables(db);
      await db.execute(
        'CREATE INDEX idx_tasks_project ON $tableTasks (projectId)',
      );
      await db.execute('CREATE INDEX idx_tasks_tag ON $tableTasks (tagId)');
    }

    if (oldVersion < 6) {
      await db.execute('ALTER TABLE $tableTasks ADD COLUMN completedAt TEXT');
    }

    if (oldVersion < 7) {
      await db.execute(
        'ALTER TABLE $tableTasks ADD COLUMN is_cancelled INTEGER NOT NULL DEFAULT 0',
      );
    }
  }

  Future<int> insertTask(TaskModel task) async {
    final db = await database;
    return db.insert(
      tableTasks,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TaskModel>> getTasksByDate(DateTime date) async {
    final db = await database;
    final dateKey = TaskModel.formatDateKey(date);

    final maps = await db.query(
      tableTasks,
      where: 'date = ?',
      whereArgs: [dateKey],
      orderBy: '''
        CASE WHEN startTime IS NULL OR startTime = '' THEN 0 ELSE 1 END ASC,
        startTime ASC,
        priority DESC,
        id ASC
      ''',
    );

    return maps.map(TaskModel.fromMap).toList();
  }

  Future<List<TaskModel>> getTasksInDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final db = await database;
    final startKey = TaskModel.formatDateKey(start);
    final endKey = TaskModel.formatDateKey(end);

    final maps = await db.query(
      tableTasks,
      where: 'date IS NOT NULL AND date >= ? AND date <= ?',
      whereArgs: [startKey, endKey],
      orderBy: '''
        date ASC,
        CASE WHEN startTime IS NULL OR startTime = '' THEN 0 ELSE 1 END ASC,
        startTime ASC,
        priority DESC,
        id ASC
      ''',
    );

    return maps.map(TaskModel.fromMap).toList();
  }

  Future<List<TaskModel>> getUnplannedTasks() async {
    final db = await database;
    final maps = await db.query(
      tableTasks,
      where: "date IS NULL OR date = ''",
      orderBy: '''
        CASE WHEN isCompleted = 1 OR is_cancelled = 1 THEN 1 ELSE 0 END ASC,
        priority DESC,
        id DESC
      ''',
    );

    return maps.map(TaskModel.fromMap).toList();
  }

  Future<List<TaskModel>> getOverdueTasks(DateTime today) async {
    final db = await database;
    final todayKey = TaskModel.formatDateKey(today);

    final maps = await db.query(
      tableTasks,
      where:
          "date IS NOT NULL AND date != '' AND date < ? AND isCompleted = 0 AND is_cancelled = 0",
      whereArgs: [todayKey],
      orderBy: '''
        date ASC,
        CASE WHEN startTime IS NULL OR startTime = '' THEN 0 ELSE 1 END ASC,
        startTime ASC,
        priority DESC,
        id ASC
      ''',
    );

    return maps.map(TaskModel.fromMap).toList();
  }

  Future<Set<String>> getDatesWithTasks(DateTime start, DateTime end) async {
    final db = await database;
    final startKey = TaskModel.formatDateKey(start);
    final endKey = TaskModel.formatDateKey(end);

    final rows = await db.rawQuery(
      '''
      SELECT DISTINCT date FROM $tableTasks
      WHERE date IS NOT NULL AND date != '' AND date >= ? AND date <= ?
      ''',
      [startKey, endKey],
    );

    return rows
        .map((row) => row['date'] as String?)
        .whereType<String>()
        .toSet();
  }

  Future<List<TaskModel>> searchTasks(String query) async {
    final trimmed = query.trim().toLowerCase();
    if (trimmed.isEmpty) return const [];

    final db = await database;
    final pattern = '%$trimmed%';
    final maps = await db.query(
      tableTasks,
      where:
          'LOWER(title) LIKE ? OR LOWER(description) LIKE ? OR LOWER(checklistItems) LIKE ?',
      whereArgs: [pattern, pattern, pattern],
      orderBy: '''
        isCompleted ASC,
        CASE WHEN date IS NULL OR date = '' THEN 1 ELSE 0 END ASC,
        date DESC,
        startTime ASC,
        id DESC
      ''',
    );

    return maps.map(TaskModel.fromMap).toList();
  }

  Future<int> updateTask(TaskModel task) async {
    if (task.id == null) {
      throw ArgumentError('Task id tidak boleh null saat memperbarui tugas.');
    }

    final db = await database;
    return db.update(
      tableTasks,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> toggleTaskComplete(
    int id,
    bool isCompleted, {
    DateTime? completedAt,
  }) async {
    final db = await database;
    return db.update(
      tableTasks,
      {
        'isCompleted': isCompleted ? 1 : 0,
        'is_cancelled': 0,
        'completedAt': isCompleted
            ? (completedAt ?? DateTime.now()).toIso8601String()
            : null,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await database;
    final maps = await db.query(
      tableTasks,
      orderBy: '''
        CASE WHEN date IS NULL OR date = '' THEN 1 ELSE 0 END ASC,
        date DESC,
        startTime ASC,
        id DESC
      ''',
    );
    return maps.map(TaskModel.fromMap).toList();
  }

  Future<List<DailyCompletionStat>> getLast7DaysCompletionStats(
    DateTime today,
  ) async {
    final allTasks = await getAllTasks();
    final computed = WorkspaceStats.compute(
      tasks: allTasks,
      projects: const [],
      today: today,
    );
    return computed.last7Days;
  }

  Future<List<DailyCompletionStat>> getLast30DaysCompletionStats(
    DateTime today,
  ) async {
    final allTasks = await getAllTasks();
    final computed = WorkspaceStats.compute(
      tasks: allTasks,
      projects: const [],
      today: today,
    );
    return computed.last30Days;
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return db.delete(
      tableTasks,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> insertRepeatingRule(RepeatingTaskRule rule) async {
    final db = await database;
    return db.insert(
      tableRepeatingTasks,
      rule.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<RepeatingTaskRule>> getRepeatingRules({
    bool activeOnly = false,
  }) async {
    final db = await database;
    final maps = await db.query(
      tableRepeatingTasks,
      where: activeOnly ? 'isActive = 1' : null,
      orderBy: 'isActive DESC, id DESC',
    );
    return maps.map(RepeatingTaskRule.fromMap).toList();
  }

  Future<RepeatingTaskRule?> getRepeatingRuleById(int id) async {
    final db = await database;
    final maps = await db.query(
      tableRepeatingTasks,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return RepeatingTaskRule.fromMap(maps.first);
  }

  Future<int> updateRepeatingRule(RepeatingTaskRule rule) async {
    if (rule.id == null) {
      throw ArgumentError('Rule id tidak boleh null saat memperbarui aturan.');
    }
    final db = await database;
    return db.update(
      tableRepeatingTasks,
      rule.toMap(),
      where: 'id = ?',
      whereArgs: [rule.id],
    );
  }

  Future<int> deleteRepeatingRule(int id) async {
    final db = await database;
    return db.delete(
      tableRepeatingTasks,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<bool> hasTaskForRepeatingRuleOnDate(int ruleId, DateTime date) async {
    final db = await database;
    final dateKey = TaskModel.formatDateKey(date);
    final rows = await db.rawQuery(
      '''
      SELECT 1 FROM $tableTasks
      WHERE repeatingRuleId = ? AND date = ?
      LIMIT 1
      ''',
      [ruleId, dateKey],
    );
    return rows.isNotEmpty;
  }

  Future<List<TaskModel>> getIncompleteFutureTasksForRule(
    int ruleId,
    DateTime fromDate,
  ) async {
    final db = await database;
    final fromKey = TaskModel.formatDateKey(fromDate);
    final maps = await db.query(
      tableTasks,
      where:
          'repeatingRuleId = ? AND date IS NOT NULL AND date >= ? AND isCompleted = 0 AND is_cancelled = 0',
      whereArgs: [ruleId, fromKey],
      orderBy: 'date ASC, id ASC',
    );
    return maps.map(TaskModel.fromMap).toList();
  }

  Future<int> deleteIncompleteFutureTasksForRule(
    int ruleId,
    DateTime fromDate,
  ) async {
    final db = await database;
    final fromKey = TaskModel.formatDateKey(fromDate);
    return db.delete(
      tableTasks,
      where:
          'repeatingRuleId = ? AND date IS NOT NULL AND date >= ? AND isCompleted = 0 AND is_cancelled = 0',
      whereArgs: [ruleId, fromKey],
    );
  }

  Future<int> getCompletedCountForRule(int ruleId) async {
    final db = await database;
    final rows = await db.rawQuery(
      '''
      SELECT COUNT(*) AS cnt FROM $tableTasks
      WHERE repeatingRuleId = ? AND isCompleted = 1 AND is_cancelled = 0
      ''',
      [ruleId],
    );
    return (rows.first['cnt'] as num?)?.toInt() ?? 0;
  }

  Future<Set<String>> getCompletedDatesForRuleInRange(
    int ruleId,
    DateTime start,
    DateTime end,
  ) async {
    final db = await database;
    final startKey = TaskModel.formatDateKey(start);
    final endKey = TaskModel.formatDateKey(end);
    final rows = await db.rawQuery(
      '''
      SELECT DISTINCT date FROM $tableTasks
      WHERE repeatingRuleId = ? AND isCompleted = 1 AND is_cancelled = 0
        AND date IS NOT NULL AND date >= ? AND date <= ?
      ''',
      [ruleId, startKey, endKey],
    );
    return rows
        .map((row) => row['date'] as String?)
        .whereType<String>()
        .toSet();
  }

  Future<int> insertProject(ProjectModel project) async {
    final db = await database;
    return db.insert(
      tableProjects,
      project.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ProjectModel>> getProjects() async {
    final db = await database;
    final maps = await db.query(tableProjects, orderBy: 'id DESC');
    return maps.map(ProjectModel.fromMap).toList();
  }

  Future<int> updateProject(ProjectModel project) async {
    if (project.id == null) {
      throw ArgumentError('Project id tidak boleh null.');
    }
    final db = await database;
    return db.update(
      tableProjects,
      project.toMap(),
      where: 'id = ?',
      whereArgs: [project.id],
    );
  }

  Future<int> deleteProject(int id) async {
    final db = await database;
    return db.transaction((txn) async {
      await txn.update(
        tableTasks,
        {'projectId': null},
        where: 'projectId = ?',
        whereArgs: [id],
      );
      await txn.update(
        tableRepeatingTasks,
        {'projectId': null},
        where: 'projectId = ?',
        whereArgs: [id],
      );
      await txn.update(
        tableTaskTemplates,
        {'projectId': null},
        where: 'projectId = ?',
        whereArgs: [id],
      );
      return txn.delete(tableProjects, where: 'id = ?', whereArgs: [id]);
    });
  }

  Future<int> insertTag(TagModel tag) async {
    final db = await database;
    return db.insert(
      tableTags,
      tag.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TagModel>> getTags() async {
    final db = await database;
    final maps = await db.query(tableTags, orderBy: 'LOWER(name) ASC');
    return maps.map(TagModel.fromMap).toList();
  }

  Future<int> updateTag(TagModel tag) async {
    if (tag.id == null) {
      throw ArgumentError('Tag id tidak boleh null.');
    }
    final db = await database;
    return db.update(
      tableTags,
      tag.toMap(),
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  Future<int> deleteTag(int id) async {
    final db = await database;
    return db.transaction((txn) async {
      await txn.update(
        tableTasks,
        {'tagId': null},
        where: 'tagId = ?',
        whereArgs: [id],
      );
      await txn.update(
        tableRepeatingTasks,
        {'tagId': null},
        where: 'tagId = ?',
        whereArgs: [id],
      );
      await txn.update(
        tableNotes,
        {'tagId': null},
        where: 'tagId = ?',
        whereArgs: [id],
      );
      await txn.update(
        tableTaskTemplates,
        {'tagId': null},
        where: 'tagId = ?',
        whereArgs: [id],
      );
      return txn.delete(tableTags, where: 'id = ?', whereArgs: [id]);
    });
  }

  Future<int> insertNote(NoteModel note) async {
    final db = await database;
    return db.insert(
      tableNotes,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<NoteModel>> getNotes() async {
    final db = await database;
    final maps = await db.query(tableNotes, orderBy: 'updatedAt DESC, id DESC');
    return maps.map(NoteModel.fromMap).toList();
  }

  Future<int> updateNote(NoteModel note) async {
    if (note.id == null) {
      throw ArgumentError('Note id tidak boleh null.');
    }
    final db = await database;
    return db.update(
      tableNotes,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return db.delete(tableNotes, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertTemplate(TaskTemplateModel template) async {
    final db = await database;
    return db.insert(
      tableTaskTemplates,
      template.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TaskTemplateModel>> getTemplates() async {
    final db = await database;
    final maps = await db.query(
      tableTaskTemplates,
      orderBy: 'LOWER(name) ASC, id DESC',
    );
    return maps.map(TaskTemplateModel.fromMap).toList();
  }

  Future<int> updateTemplate(TaskTemplateModel template) async {
    if (template.id == null) {
      throw ArgumentError('Template id tidak boleh null.');
    }
    final db = await database;
    return db.update(
      tableTaskTemplates,
      template.toMap(),
      where: 'id = ?',
      whereArgs: [template.id],
    );
  }

  Future<int> deleteTemplate(int id) async {
    final db = await database;
    return db.delete(tableTaskTemplates, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TaskModel>> getTasksByProject(int projectId) async {
    final db = await database;
    final maps = await db.query(
      tableTasks,
      where: 'projectId = ?',
      whereArgs: [projectId],
      orderBy: '''
        isCompleted ASC,
        CASE WHEN date IS NULL OR date = '' THEN 1 ELSE 0 END ASC,
        date ASC,
        startTime ASC,
        id DESC
      ''',
    );
    return maps.map(TaskModel.fromMap).toList();
  }

  Future<List<TaskModel>> getTasksByTag(int tagId) async {
    final db = await database;
    final maps = await db.query(
      tableTasks,
      where: 'tagId = ?',
      whereArgs: [tagId],
      orderBy: '''
        isCompleted ASC,
        CASE WHEN date IS NULL OR date = '' THEN 1 ELSE 0 END ASC,
        date ASC,
        startTime ASC,
        id DESC
      ''',
    );
    return maps.map(TaskModel.fromMap).toList();
  }

  Future<Map<int, ProjectProgress>> getProjectTaskCounts() async {
    final db = await database;
    final rows = await db.rawQuery('''
      SELECT
        projectId,
        SUM(CASE WHEN is_cancelled = 0 THEN 1 ELSE 0 END) AS totalCount,
        SUM(CASE WHEN isCompleted = 1 AND is_cancelled = 0 THEN 1 ELSE 0 END) AS completedCount
      FROM $tableTasks
      WHERE projectId IS NOT NULL
      GROUP BY projectId
    ''');

    final result = <int, ProjectProgress>{};
    for (final row in rows) {
      final projectId = (row['projectId'] as num?)?.toInt();
      if (projectId == null) continue;
      result[projectId] = ProjectProgress(
        completedCount: (row['completedCount'] as num?)?.toInt() ?? 0,
        totalCount: (row['totalCount'] as num?)?.toInt() ?? 0,
      );
    }
    return result;
  }

  Future<Map<int, int>> getTagTaskCounts() async {
    final db = await database;
    final rows = await db.rawQuery('''
      SELECT tagId, COUNT(*) AS totalCount
      FROM $tableTasks
      WHERE tagId IS NOT NULL
      GROUP BY tagId
    ''');

    final result = <int, int>{};
    for (final row in rows) {
      final tagId = (row['tagId'] as num?)?.toInt();
      if (tagId == null) continue;
      result[tagId] = (row['totalCount'] as num?)?.toInt() ?? 0;
    }
    return result;
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
