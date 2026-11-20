import 'package:flutter/foundation.dart';

import '../models/note_model.dart';
import '../models/project_model.dart';
import '../models/repeating_task_model.dart';
import '../models/stats_model.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';
import '../models/task_template_model.dart';
import '../services/database_service.dart';
import '../services/export_service.dart';

class WorkspaceProvider extends ChangeNotifier {
  WorkspaceProvider({
    DatabaseService? databaseService,
    DataExportService? exportService,
    DateTime Function()? nowProvider,
  })  : _databaseService = databaseService ?? DatabaseService.instance,
        _exportService = exportService ?? CsvExportService.instance,
        _nowProvider = nowProvider ?? DateTime.now,
        _stats = WorkspaceStats.empty(
          today: nowProvider?.call() ?? DateTime.now(),
        );

  final DatabaseService _databaseService;
  final DataExportService _exportService;
  final DateTime Function() _nowProvider;

  List<ProjectModel> _projects = [];
  List<TagModel> _tags = [];
  List<NoteModel> _notes = [];
  List<TaskTemplateModel> _templates = [];
  Map<int, ProjectProgress> _projectProgress = {};
  Map<int, int> _tagTaskCounts = {};
  WorkspaceStats _stats;
  bool _isLoading = false;
  bool _isExporting = false;
  String? _errorMessage;

  List<ProjectModel> get projects => List.unmodifiable(_projects);
  List<TagModel> get tags => List.unmodifiable(_tags);
  List<NoteModel> get notes => List.unmodifiable(_notes);
  List<TaskTemplateModel> get templates => List.unmodifiable(_templates);
  WorkspaceStats get stats => _stats;
  bool get isLoading => _isLoading;
  bool get isExporting => _isExporting;
  String? get errorMessage => _errorMessage;

  ProjectModel? findProject(int? projectId) {
    if (projectId == null) return null;
    for (final project in _projects) {
      if (project.id == projectId) return project;
    }
    return null;
  }

  TagModel? findTag(int? tagId) {
    if (tagId == null) return null;
    for (final tag in _tags) {
      if (tag.id == tagId) return tag;
    }
    return null;
  }

  ProjectProgress progressForProject(int projectId) {
    return _projectProgress[projectId] ?? const ProjectProgress();
  }

  int taskCountForTag(int tagId) {
    return _tagTaskCounts[tagId] ?? 0;
  }

  Future<void> initialize() async {
    await refreshAll(showLoading: true);
  }

  Future<void> refreshAll({bool showLoading = false}) async {
    if (showLoading) {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
    }

    try {
      final results = await Future.wait<Object>([
        _databaseService.getProjects(),
        _databaseService.getTags(),
        _databaseService.getNotes(),
        _databaseService.getTemplates(),
        _databaseService.getProjectTaskCounts(),
        _databaseService.getTagTaskCounts(),
        _databaseService.getAllTasks(),
        _databaseService.getRepeatingRules(activeOnly: true),
      ]);

      _projects = results[0] as List<ProjectModel>;
      _tags = results[1] as List<TagModel>;
      _notes = results[2] as List<NoteModel>;
      _templates = results[3] as List<TaskTemplateModel>;
      _projectProgress = results[4] as Map<int, ProjectProgress>;
      _tagTaskCounts = results[5] as Map<int, int>;
      final allTasks = results[6] as List<TaskModel>;
      final activeRules = results[7] as List<RepeatingTaskRule>;
      _stats = WorkspaceStats.compute(
        tasks: allTasks,
        projects: _projects,
        tags: _tags,
        repeatingRules: activeRules,
        today: _nowProvider(),
      );
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Gagal memuat data workspace: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshCounts() async {
    try {
      final results = await Future.wait<Object>([
        _databaseService.getProjectTaskCounts(),
        _databaseService.getTagTaskCounts(),
        _databaseService.getAllTasks(),
        _databaseService.getRepeatingRules(activeOnly: true),
      ]);
      _projectProgress = results[0] as Map<int, ProjectProgress>;
      _tagTaskCounts = results[1] as Map<int, int>;
      final allTasks = results[2] as List<TaskModel>;
      final activeRules = results[3] as List<RepeatingTaskRule>;
      _stats = WorkspaceStats.compute(
        tasks: allTasks,
        projects: _projects,
        tags: _tags,
        repeatingRules: activeRules,
        today: _nowProvider(),
      );
      notifyListeners();
    } catch (e) {
      debugPrint('WorkspaceProvider.refreshCounts gagal: $e');
    }
  }

  Future<ExportResult> exportCsv(ExportTarget target) async {
    if (_isExporting) {
      return const ExportResult(
        success: false,
        fileCount: 0,
        message: 'Proses ekspor sedang berjalan.',
      );
    }

    _isExporting = true;
    notifyListeners();

    try {
      final allTasks = await _databaseService.getAllTasks();
      final allNotes = await _databaseService.getNotes();
      return await _exportService.exportData(
        target: target,
        tasks: allTasks,
        notes: allNotes,
        projects: _projects,
        tags: _tags,
        timestamp: _nowProvider(),
      );
    } finally {
      _isExporting = false;
      notifyListeners();
    }
  }

  Future<List<TaskModel>> getTasksByProject(int projectId) async {
    try {
      return await _databaseService.getTasksByProject(projectId);
    } catch (e) {
      debugPrint('WorkspaceProvider.getTasksByProject gagal: $e');
      return const [];
    }
  }

  Future<List<TaskModel>> getTasksByTag(int tagId) async {
    try {
      return await _databaseService.getTasksByTag(tagId);
    } catch (e) {
      debugPrint('WorkspaceProvider.getTasksByTag gagal: $e');
      return const [];
    }
  }

  Future<bool> addProject(ProjectModel project) async {
    try {
      _errorMessage = null;
      await _databaseService.insertProject(project);
      await refreshAll();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal membuat proyek: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProject(ProjectModel project) async {
    try {
      _errorMessage = null;
      await _databaseService.updateProject(project);
      await refreshAll();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui proyek: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> deleteProject(int id) async {
    try {
      _errorMessage = null;
      await _databaseService.deleteProject(id);
      await refreshAll();
    } catch (e) {
      _errorMessage = 'Gagal menghapus proyek: $e';
      notifyListeners();
    }
  }

  Future<bool> addTag(TagModel tag) async {
    try {
      _errorMessage = null;
      await _databaseService.insertTag(tag);
      await refreshAll();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal membuat tag: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTag(TagModel tag) async {
    try {
      _errorMessage = null;
      await _databaseService.updateTag(tag);
      await refreshAll();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui tag: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> deleteTag(int id) async {
    try {
      _errorMessage = null;
      await _databaseService.deleteTag(id);
      await refreshAll();
    } catch (e) {
      _errorMessage = 'Gagal menghapus tag: $e';
      notifyListeners();
    }
  }

  Future<bool> addNote(NoteModel note) async {
    try {
      _errorMessage = null;
      await _databaseService.insertNote(note);
      await refreshAll();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal menyimpan catatan: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateNote(NoteModel note) async {
    try {
      _errorMessage = null;
      await _databaseService.updateNote(note);
      await refreshAll();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui catatan: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> deleteNote(int id) async {
    final previous = List<NoteModel>.from(_notes);
    _notes = _notes.where((note) => note.id != id).toList();
    notifyListeners();

    try {
      await _databaseService.deleteNote(id);
    } catch (e) {
      _notes = previous;
      _errorMessage = 'Gagal menghapus catatan: $e';
      notifyListeners();
    }
  }

  Future<void> restoreNote(NoteModel note) async {
    try {
      _errorMessage = null;
      await _databaseService.insertNote(note);
      await refreshAll();
    } catch (e) {
      _errorMessage = 'Gagal mengembalikan catatan: $e';
      notifyListeners();
    }
  }

  Future<bool> addTemplate(TaskTemplateModel template) async {
    try {
      _errorMessage = null;
      await _databaseService.insertTemplate(template);
      await refreshAll();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal menyimpan template: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTemplate(TaskTemplateModel template) async {
    try {
      _errorMessage = null;
      await _databaseService.updateTemplate(template);
      await refreshAll();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal memperbarui template: $e';
      notifyListeners();
      return false;
    }
  }

  Future<void> deleteTemplate(int id) async {
    try {
      _errorMessage = null;
      await _databaseService.deleteTemplate(id);
      await refreshAll();
    } catch (e) {
      _errorMessage = 'Gagal menghapus template: $e';
      notifyListeners();
    }
  }
}
