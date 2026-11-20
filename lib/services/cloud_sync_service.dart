import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../models/note_model.dart';
import '../models/project_model.dart';
import '../models/repeating_task_model.dart';
import '../models/tag_model.dart';
import '../models/task_model.dart';
import '../models/task_template_model.dart';
import 'database_service.dart';

class SyncSummary {
  const SyncSummary({
    required this.uploadedCount,
    required this.downloadedCount,
    required this.syncedAt,
  });

  final int uploadedCount;
  final int downloadedCount;
  final DateTime syncedAt;
}

class SyncDataset {
  const SyncDataset({
    this.projects = const [],
    this.tags = const [],
    this.repeatingRules = const [],
    this.tasks = const [],
    this.notes = const [],
    this.templates = const [],
  });

  final List<ProjectModel> projects;
  final List<TagModel> tags;
  final List<RepeatingTaskRule> repeatingRules;
  final List<TaskModel> tasks;
  final List<NoteModel> notes;
  final List<TaskTemplateModel> templates;

  bool get isEmpty =>
      projects.isEmpty &&
      tags.isEmpty &&
      repeatingRules.isEmpty &&
      tasks.isEmpty &&
      notes.isEmpty &&
      templates.isEmpty;
}

class SyncMergePlan {
  const SyncMergePlan({
    required this.toSaveLocally,
    required this.toUploadToCloud,
    required this.merged,
  });

  final SyncDataset toSaveLocally;
  final SyncDataset toUploadToCloud;
  final SyncDataset merged;
}

class _CollectionMerge<T> {
  const _CollectionMerge({
    required this.toSaveLocally,
    required this.toUploadToCloud,
    required this.merged,
    required this.localIdRemap,
  });

  final List<T> toSaveLocally;
  final List<T> toUploadToCloud;
  final List<T> merged;
  final Map<int, int> localIdRemap;
}

class CloudSyncMerger {
  static SyncMergePlan merge({
    required SyncDataset local,
    required SyncDataset cloud,
    DateTime? lastSyncedAt,
  }) {
    final firstTimeMerge = lastSyncedAt == null && !cloud.isEmpty && !local.isEmpty;

    final projectsMerge = _mergeCollection<ProjectModel>(
      local: local.projects,
      cloud: cloud.projects,
      firstTimeMerge: firstTimeMerge,
      idOf: (p) => p.id,
      withId: (p, id) => p.copyWith(id: id),
      fingerprintOf: (p) => p.name.trim().toLowerCase(),
      areEqual: (a, b) =>
          a.name == b.name &&
          a.colorHex == b.colorHex &&
          a.createdAt.toIso8601String() == b.createdAt.toIso8601String(),
      pickWinner: (localItem, cloudItem) =>
          localItem.createdAt.isAfter(cloudItem.createdAt)
              ? localItem
              : cloudItem,
    );

    final tagsMerge = _mergeCollection<TagModel>(
      local: local.tags,
      cloud: cloud.tags,
      firstTimeMerge: firstTimeMerge,
      idOf: (t) => t.id,
      withId: (t, id) => t.copyWith(id: id),
      fingerprintOf: (t) => t.name.trim().toLowerCase(),
      areEqual: (a, b) => a.name == b.name && a.colorHex == b.colorHex,
      pickWinner: (localItem, cloudItem) => cloudItem,
    );

    final remappedLocalRules = local.repeatingRules
        .map(
          (r) => r.copyWith(
            projectId: r.projectId != null
                ? (projectsMerge.localIdRemap[r.projectId!] ?? r.projectId)
                : null,
            tagId: r.tagId != null
                ? (tagsMerge.localIdRemap[r.tagId!] ?? r.tagId)
                : null,
          ),
        )
        .toList();

    final rulesMerge = _mergeCollection<RepeatingTaskRule>(
      local: remappedLocalRules,
      cloud: cloud.repeatingRules,
      firstTimeMerge: firstTimeMerge,
      idOf: (r) => r.id,
      withId: (r, id) => r.copyWith(id: id),
      fingerprintOf: (r) =>
          '${r.title.trim().toLowerCase()}|${r.frequency.value}|${TaskModel.formatDateKey(r.startDate)}|${r.startTime ?? ''}',
      areEqual: (a, b) => _mapsShallowEqual(a.toMap(), b.toMap()),
      pickWinner: (localItem, cloudItem) {
        final mergedExcluded = {
          ...localItem.excludedDates,
          ...cloudItem.excludedDates,
        };
        return localItem.copyWith(
          id: cloudItem.id ?? localItem.id,
          excludedDates: mergedExcluded,
        );
      },
    );

    final remappedLocalTasks = local.tasks
        .map(
          (t) => t.copyWith(
            projectId: t.projectId != null
                ? (projectsMerge.localIdRemap[t.projectId!] ?? t.projectId)
                : null,
            tagId: t.tagId != null
                ? (tagsMerge.localIdRemap[t.tagId!] ?? t.tagId)
                : null,
            repeatingRuleId: t.repeatingRuleId != null
                ? (rulesMerge.localIdRemap[t.repeatingRuleId!] ??
                    t.repeatingRuleId)
                : null,
          ),
        )
        .toList();

    final tasksMerge = _mergeCollection<TaskModel>(
      local: remappedLocalTasks,
      cloud: cloud.tasks,
      firstTimeMerge: firstTimeMerge,
      idOf: (t) => t.id,
      withId: (t, id) => t.copyWith(id: id),
      fingerprintOf: (t) =>
          '${t.title.trim().toLowerCase()}|${t.date != null ? TaskModel.formatDateKey(t.date!) : 'unplanned'}|${t.startTime ?? ''}|${t.repeatingRuleId ?? ''}',
      areEqual: (a, b) => _mapsShallowEqual(a.toMap(), b.toMap()),
      pickWinner: _pickWinningTask,
    );

    final remappedLocalNotes = local.notes
        .map(
          (n) => n.copyWith(
            tagId: n.tagId != null
                ? (tagsMerge.localIdRemap[n.tagId!] ?? n.tagId)
                : null,
          ),
        )
        .toList();

    final notesMerge = _mergeCollection<NoteModel>(
      local: remappedLocalNotes,
      cloud: cloud.notes,
      firstTimeMerge: firstTimeMerge,
      idOf: (n) => n.id,
      withId: (n, id) => n.copyWith(id: id),
      fingerprintOf: (n) =>
          '${n.title.trim().toLowerCase()}|${n.content.trim()}',
      areEqual: (a, b) => _mapsShallowEqual(a.toMap(), b.toMap()),
      pickWinner: (localItem, cloudItem) =>
          localItem.updatedAt.isAfter(cloudItem.updatedAt)
              ? localItem.copyWith(id: cloudItem.id ?? localItem.id)
              : cloudItem,
    );

    final remappedLocalTemplates = local.templates
        .map(
          (tpl) => tpl.copyWith(
            projectId: tpl.projectId != null
                ? (projectsMerge.localIdRemap[tpl.projectId!] ?? tpl.projectId)
                : null,
            tagId: tpl.tagId != null
                ? (tagsMerge.localIdRemap[tpl.tagId!] ?? tpl.tagId)
                : null,
          ),
        )
        .toList();

    final templatesMerge = _mergeCollection<TaskTemplateModel>(
      local: remappedLocalTemplates,
      cloud: cloud.templates,
      firstTimeMerge: firstTimeMerge,
      idOf: (tpl) => tpl.id,
      withId: (tpl, id) => tpl.copyWith(id: id),
      fingerprintOf: (tpl) =>
          '${tpl.name.trim().toLowerCase()}|${tpl.title.trim().toLowerCase()}',
      areEqual: (a, b) => _mapsShallowEqual(a.toMap(), b.toMap()),
      pickWinner: (localItem, cloudItem) =>
          localItem.copyWith(id: cloudItem.id ?? localItem.id),
    );

    return SyncMergePlan(
      toSaveLocally: SyncDataset(
        projects: projectsMerge.toSaveLocally,
        tags: tagsMerge.toSaveLocally,
        repeatingRules: rulesMerge.toSaveLocally,
        tasks: tasksMerge.toSaveLocally,
        notes: notesMerge.toSaveLocally,
        templates: templatesMerge.toSaveLocally,
      ),
      toUploadToCloud: SyncDataset(
        projects: projectsMerge.toUploadToCloud,
        tags: tagsMerge.toUploadToCloud,
        repeatingRules: rulesMerge.toUploadToCloud,
        tasks: tasksMerge.toUploadToCloud,
        notes: notesMerge.toUploadToCloud,
        templates: templatesMerge.toUploadToCloud,
      ),
      merged: SyncDataset(
        projects: projectsMerge.merged,
        tags: tagsMerge.merged,
        repeatingRules: rulesMerge.merged,
        tasks: tasksMerge.merged,
        notes: notesMerge.merged,
        templates: templatesMerge.merged,
      ),
    );
  }

  static TaskModel _pickWinningTask(TaskModel localItem, TaskModel cloudItem) {
    final targetId = cloudItem.id ?? localItem.id;
    if (localItem.completedAt != null && cloudItem.completedAt != null) {
      return localItem.completedAt!.isAfter(cloudItem.completedAt!)
          ? localItem.copyWith(id: targetId)
          : cloudItem.copyWith(id: targetId);
    }
    if (localItem.isCompleted != cloudItem.isCompleted) {
      return localItem.isCompleted
          ? localItem.copyWith(id: targetId)
          : cloudItem.copyWith(id: targetId);
    }
    if (localItem.isCancelled != cloudItem.isCancelled) {
      return localItem.isCancelled
          ? localItem.copyWith(id: targetId)
          : cloudItem.copyWith(id: targetId);
    }
    final localChecked =
        localItem.checklistItems.where((item) => item.isDone).length;
    final cloudChecked =
        cloudItem.checklistItems.where((item) => item.isDone).length;
    if (localChecked != cloudChecked) {
      return localChecked > cloudChecked
          ? localItem.copyWith(id: targetId)
          : cloudItem.copyWith(id: targetId);
    }
    return localItem.copyWith(id: targetId);
  }

  static bool _mapsShallowEqual(
    Map<String, dynamic> a,
    Map<String, dynamic> b,
  ) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) {
        return false;
      }
    }
    return true;
  }

  static _CollectionMerge<T> _mergeCollection<T extends Object>({
    required List<T> local,
    required List<T> cloud,
    required bool firstTimeMerge,
    required int? Function(T item) idOf,
    required T Function(T item, int id) withId,
    required String Function(T item) fingerprintOf,
    required bool Function(T a, T b) areEqual,
    required T Function(T localItem, T cloudItem) pickWinner,
  }) {
    if (cloud.isEmpty) {
      return _CollectionMerge<T>(
        toSaveLocally: const [],
        toUploadToCloud: local,
        merged: local,
        localIdRemap: const {},
      );
    }

    if (local.isEmpty) {
      return _CollectionMerge<T>(
        toSaveLocally: cloud,
        toUploadToCloud: const [],
        merged: cloud,
        localIdRemap: const {},
      );
    }

    final toSaveLocally = <T>[];
    final toUploadToCloud = <T>[];
    final mergedById = <int, T>{};
    final localIdRemap = <int, int>{};

    var maxId = 0;
    for (final item in cloud) {
      final id = idOf(item);
      if (id != null) maxId = math.max(maxId, id);
    }
    for (final item in local) {
      final id = idOf(item);
      if (id != null) maxId = math.max(maxId, id);
    }

    if (firstTimeMerge) {
      final cloudById = <int, T>{};
      final cloudByFingerprint = <String, int>{};
      final matchedCloudIds = <int>{};

      for (final item in cloud) {
        final id = idOf(item);
        if (id == null) continue;
        cloudById[id] = item;
        cloudByFingerprint.putIfAbsent(fingerprintOf(item), () => id);
      }

      for (final localItem in local) {
        final localId = idOf(localItem);
        final fp = fingerprintOf(localItem);
        final matchedCloudId = cloudByFingerprint[fp];
        final cloudItem =
            matchedCloudId != null ? cloudById[matchedCloudId] : null;

        if (matchedCloudId != null && cloudItem != null) {
          matchedCloudIds.add(matchedCloudId);
          final winner = pickWinner(localItem, cloudItem);
          final normalizedWinner = withId(winner, matchedCloudId);
          mergedById[matchedCloudId] = normalizedWinner;
          if (localId != null && localId != matchedCloudId) {
            localIdRemap[localId] = matchedCloudId;
          }
          if (!areEqual(normalizedWinner, cloudItem)) {
            toUploadToCloud.add(normalizedWinner);
          }
          if (!areEqual(normalizedWinner, localItem) ||
              localId != matchedCloudId) {
            toSaveLocally.add(normalizedWinner);
          }
        } else {
          int targetId;
          if (localId != null && !cloudById.containsKey(localId)) {
            targetId = localId;
          } else {
            maxId += 1;
            targetId = maxId;
          }
          final assigned = withId(localItem, targetId);
          mergedById[targetId] = assigned;
          if (localId != null && localId != targetId) {
            localIdRemap[localId] = targetId;
            toSaveLocally.add(assigned);
          }
          toUploadToCloud.add(assigned);
        }
      }

      for (final entry in cloudById.entries) {
        if (matchedCloudIds.contains(entry.key)) continue;
        mergedById[entry.key] = entry.value;
        toSaveLocally.add(entry.value);
      }

      return _CollectionMerge<T>(
        toSaveLocally: toSaveLocally,
        toUploadToCloud: toUploadToCloud,
        merged: mergedById.values.toList(),
        localIdRemap: localIdRemap,
      );
    }

    final localById = <int, T>{};
    for (final item in local) {
      final id = idOf(item);
      if (id != null) localById[id] = item;
    }

    final cloudById = <int, T>{};
    for (final item in cloud) {
      final id = idOf(item);
      if (id != null) cloudById[id] = item;
    }

    final allIds = {...localById.keys, ...cloudById.keys};
    for (final id in allIds) {
      final localItem = localById[id];
      final cloudItem = cloudById[id];

      if (localItem != null && cloudItem == null) {
        mergedById[id] = localItem;
        toUploadToCloud.add(localItem);
      } else if (localItem == null && cloudItem != null) {
        mergedById[id] = cloudItem;
        toSaveLocally.add(cloudItem);
      } else if (localItem != null && cloudItem != null) {
        if (areEqual(localItem, cloudItem)) {
          mergedById[id] = localItem;
        } else {
          final winner = withId(pickWinner(localItem, cloudItem), id);
          mergedById[id] = winner;
          if (!areEqual(winner, localItem)) {
            toSaveLocally.add(winner);
          }
          if (!areEqual(winner, cloudItem)) {
            toUploadToCloud.add(winner);
          }
        }
      }
    }

    return _CollectionMerge<T>(
      toSaveLocally: toSaveLocally,
      toUploadToCloud: toUploadToCloud,
      merged: mergedById.values.toList(),
      localIdRemap: localIdRemap,
    );
  }
}

abstract class CloudSyncService {
  Future<SyncSummary> syncAll(
    String uid,
    DatabaseService db, {
    DateTime? lastSyncedAt,
  });

  Future<void> deleteAllUserData(String uid);
}

class FirestoreSyncService implements CloudSyncService {
  FirestoreSyncService._internal();

  static final FirestoreSyncService instance = FirestoreSyncService._internal();

  static const List<String> _collections = [
    'projects',
    'tags',
    'repeating_tasks',
    'tasks',
    'notes',
    'task_templates',
  ];

  static const int _maxBatchWrites = 400;

  FirebaseFirestore get _firestore {
    if (Firebase.apps.isEmpty) {
      throw StateError('Firebase belum diinisialisasi.');
    }
    return FirebaseFirestore.instance;
  }

  DocumentReference<Map<String, dynamic>> _userDoc(String uid) {
    return _firestore.collection('users').doc(uid);
  }

  @override
  Future<SyncSummary> syncAll(
    String uid,
    DatabaseService db, {
    DateTime? lastSyncedAt,
  }) async {
    final userRef = _userDoc(uid);
    final now = DateTime.now();

    final localFuture = Future.wait<Object>([
      db.getProjects(),
      db.getTags(),
      db.getRepeatingRules(),
      db.getAllTasks(),
      db.getNotes(),
      db.getTemplates(),
    ]);

    final cloudFuture = Future.wait<QuerySnapshot<Map<String, dynamic>>>([
      userRef.collection('projects').get(),
      userRef.collection('tags').get(),
      userRef.collection('repeating_tasks').get(),
      userRef.collection('tasks').get(),
      userRef.collection('notes').get(),
      userRef.collection('task_templates').get(),
    ]);

    final localResults = await localFuture;
    final cloudSnaps = await cloudFuture;

    final localData = SyncDataset(
      projects: localResults[0] as List<ProjectModel>,
      tags: localResults[1] as List<TagModel>,
      repeatingRules: localResults[2] as List<RepeatingTaskRule>,
      tasks: localResults[3] as List<TaskModel>,
      notes: localResults[4] as List<NoteModel>,
      templates: localResults[5] as List<TaskTemplateModel>,
    );

    final cloudData = SyncDataset(
      projects: _parseDocs(cloudSnaps[0], ProjectModel.fromMap),
      tags: _parseDocs(cloudSnaps[1], TagModel.fromMap),
      repeatingRules: _parseDocs(cloudSnaps[2], RepeatingTaskRule.fromMap),
      tasks: _parseDocs(cloudSnaps[3], TaskModel.fromMap),
      notes: _parseDocs(cloudSnaps[4], NoteModel.fromMap),
      templates: _parseDocs(cloudSnaps[5], TaskTemplateModel.fromMap),
    );

    final plan = CloudSyncMerger.merge(
      local: localData,
      cloud: cloudData,
      lastSyncedAt: lastSyncedAt,
    );

    final downloadedCount = await _applyLocalSaves(db, plan.toSaveLocally);
    final uploadedCount = await _uploadToCloud(
      userRef,
      plan.toUploadToCloud,
      now,
    );

    await userRef.set(
      {'lastSyncedAt': now.toIso8601String()},
      SetOptions(merge: true),
    );

    return SyncSummary(
      uploadedCount: uploadedCount,
      downloadedCount: downloadedCount,
      syncedAt: now,
    );
  }

  List<T> _parseDocs<T>(
    QuerySnapshot<Map<String, dynamic>> snapshot,
    T Function(Map<String, dynamic> map) fromMap,
  ) {
    final items = <T>[];
    for (final doc in snapshot.docs) {
      final data = Map<String, dynamic>.from(doc.data());
      data['id'] ??= int.tryParse(doc.id);
      items.add(fromMap(data));
    }
    return items;
  }

  Future<int> _applyLocalSaves(DatabaseService db, SyncDataset dataset) async {
    var count = 0;
    for (final project in dataset.projects) {
      await db.insertProject(project);
      count++;
    }
    for (final tag in dataset.tags) {
      await db.insertTag(tag);
      count++;
    }
    for (final rule in dataset.repeatingRules) {
      await db.insertRepeatingRule(rule);
      count++;
    }
    for (final task in dataset.tasks) {
      await db.insertTask(task);
      count++;
    }
    for (final note in dataset.notes) {
      await db.insertNote(note);
      count++;
    }
    for (final template in dataset.templates) {
      await db.insertTemplate(template);
      count++;
    }
    return count;
  }

  Future<int> _uploadToCloud(
    DocumentReference<Map<String, dynamic>> userRef,
    SyncDataset dataset,
    DateTime syncedAt,
  ) async {
    final syncedAtIso = syncedAt.toIso8601String();
    final pendingWrites = <(DocumentReference<Map<String, dynamic>>, Map<String, dynamic>)>[];

    void enqueue(String collection, int? id, Map<String, dynamic> payload) {
      if (id == null) return;
      final data = Map<String, dynamic>.from(payload)..['syncedAt'] = syncedAtIso;
      pendingWrites.add((userRef.collection(collection).doc('$id'), data));
    }

    for (final project in dataset.projects) {
      enqueue('projects', project.id, project.toMap());
    }
    for (final tag in dataset.tags) {
      enqueue('tags', tag.id, tag.toMap());
    }
    for (final rule in dataset.repeatingRules) {
      enqueue('repeating_tasks', rule.id, rule.toMap());
    }
    for (final task in dataset.tasks) {
      enqueue('tasks', task.id, task.toMap());
    }
    for (final note in dataset.notes) {
      enqueue('notes', note.id, note.toMap());
    }
    for (final template in dataset.templates) {
      enqueue('task_templates', template.id, template.toMap());
    }

    for (var i = 0; i < pendingWrites.length; i += _maxBatchWrites) {
      final batch = _firestore.batch();
      final end = math.min(i + _maxBatchWrites, pendingWrites.length);
      for (var j = i; j < end; j++) {
        final (ref, data) = pendingWrites[j];
        batch.set(ref, data, SetOptions(merge: true));
      }
      await batch.commit();
    }

    return pendingWrites.length;
  }

  @override
  Future<void> deleteAllUserData(String uid) async {
    final userRef = _userDoc(uid);

    for (final collectionName in _collections) {
      final snapshot = await userRef.collection(collectionName).get();
      final docs = snapshot.docs;
      for (var i = 0; i < docs.length; i += _maxBatchWrites) {
        final batch = _firestore.batch();
        final end = math.min(i + _maxBatchWrites, docs.length);
        for (var j = i; j < end; j++) {
          batch.delete(docs[j].reference);
        }
        await batch.commit();
      }
    }

    await userRef.delete();
  }
}
