import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../models/note_model.dart';
import '../models/project_model.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';

enum ExportTarget {
  tasks('Tugas'),
  notes('Catatan'),
  both('Tugas & Catatan');

  const ExportTarget(this.label);

  final String label;
}

class ExportResult {
  const ExportResult({
    required this.success,
    required this.fileCount,
    required this.message,
  });

  final bool success;
  final int fileCount;
  final String message;
}

abstract class DataExportService {
  Future<ExportResult> exportData({
    required ExportTarget target,
    required List<TaskModel> tasks,
    required List<NoteModel> notes,
    required List<ProjectModel> projects,
    required List<TagModel> tags,
    DateTime? timestamp,
  });
}

class CsvExportService implements DataExportService {
  CsvExportService._internal();

  static final CsvExportService instance = CsvExportService._internal();

  static String escapeCsvField(String value) {
    final needsQuotes = value.contains(',') ||
        value.contains('"') ||
        value.contains('\n') ||
        value.contains('\r');
    if (!needsQuotes) return value;
    final escaped = value.replaceAll('"', '""');
    return '"$escaped"';
  }

  static String encodeCsvRow(List<String> fields) {
    return fields.map(escapeCsvField).join(',');
  }

  static String buildTasksCsv({
    required List<TaskModel> tasks,
    required Map<int, String> projectNames,
    required Map<int, String> tagNames,
  }) {
    final buffer = StringBuffer();
    buffer.writeln(
      encodeCsvRow([
        'id',
        'judul',
        'deskripsi',
        'tanggal',
        'jam',
        'status',
        'prioritas',
        'proyek',
        'tag',
        'jumlah_sub_tugas',
        'selesai_pada',
      ]),
    );

    for (final task in tasks) {
      final projectName =
          task.projectId != null ? (projectNames[task.projectId!] ?? '') : '';
      final tagName = task.tagId != null ? (tagNames[task.tagId!] ?? '') : '';
      buffer.writeln(
        encodeCsvRow([
          task.id?.toString() ?? '',
          task.title,
          task.description,
          task.date != null ? TaskModel.formatDateKey(task.date!) : '',
          task.startTime ?? '',
          task.isCancelled
              ? 'Dibatalkan'
              : (task.isCompleted ? 'Selesai' : 'Aktif'),
          task.priority.label,
          projectName,
          tagName,
          task.totalActiveSubtasksCount.toString(),
          task.completedAt?.toIso8601String() ?? '',
        ]),
      );
    }

    return buffer.toString();
  }

  static String buildNotesCsv({
    required List<NoteModel> notes,
    required Map<int, String> tagNames,
  }) {
    final buffer = StringBuffer();
    buffer.writeln(
      encodeCsvRow([
        'id',
        'judul',
        'isi',
        'tag',
        'diperbarui_pada',
      ]),
    );

    for (final note in notes) {
      final tagName = note.tagId != null ? (tagNames[note.tagId!] ?? '') : '';
      buffer.writeln(
        encodeCsvRow([
          note.id?.toString() ?? '',
          note.title,
          note.content,
          tagName,
          note.updatedAt.toIso8601String(),
        ]),
      );
    }

    return buffer.toString();
  }

  @override
  Future<ExportResult> exportData({
    required ExportTarget target,
    required List<TaskModel> tasks,
    required List<NoteModel> notes,
    required List<ProjectModel> projects,
    required List<TagModel> tags,
    DateTime? timestamp,
  }) async {
    try {
      final now = timestamp ?? DateTime.now();
      final dateStamp = DateFormat('yyyyMMdd').format(now);
      final tempDir = await getTemporaryDirectory();

      final projectNames = <int, String>{
        for (final project in projects)
          if (project.id != null) project.id!: project.name,
      };
      final tagNames = <int, String>{
        for (final tag in tags)
          if (tag.id != null) tag.id!: tag.name,
      };

      final files = <XFile>[];

      if (target == ExportTarget.tasks || target == ExportTarget.both) {
        final csv = buildTasksCsv(
          tasks: tasks,
          projectNames: projectNames,
          tagNames: tagNames,
        );
        final filePath = p.join(tempDir.path, 'zettask_tasks_$dateStamp.csv');
        await File(filePath).writeAsString(csv);
        files.add(XFile(filePath, mimeType: 'text/csv'));
      }

      if (target == ExportTarget.notes || target == ExportTarget.both) {
        final csv = buildNotesCsv(
          notes: notes,
          tagNames: tagNames,
        );
        final filePath = p.join(tempDir.path, 'zettask_notes_$dateStamp.csv');
        await File(filePath).writeAsString(csv);
        files.add(XFile(filePath, mimeType: 'text/csv'));
      }

      if (files.isEmpty) {
        return const ExportResult(
          success: false,
          fileCount: 0,
          message: 'Tidak ada berkas yang diekspor.',
        );
      }

      await SharePlus.instance.share(
        ShareParams(
          files: files,
          subject: 'Ekspor CSV Zettask',
        ),
      );

      return ExportResult(
        success: true,
        fileCount: files.length,
        message: 'Berhasil menyiapkan ${files.length} berkas CSV.',
      );
    } on MissingPluginException {
      return const ExportResult(
        success: false,
        fileCount: 0,
        message: 'Fitur berbagi tidak tersedia di platform ini.',
      );
    } catch (e) {
      debugPrint('CsvExportService.exportData gagal: $e');
      return ExportResult(
        success: false,
        fileCount: 0,
        message: 'Gagal mengekspor CSV: $e',
      );
    }
  }
}
