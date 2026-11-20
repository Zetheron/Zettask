import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

import '../models/task_model.dart';

abstract class HomeWidgetSyncService {
  Future<void> updateTodayTasks(
    List<TaskModel> todayTasks, {
    String? widgetTitle,
    String? widgetEmptyText,
  });

  Future<void> updateWidgetLabels({
    required String widgetTitle,
    required String widgetEmptyText,
  });

  Future<Uri?> getInitiallyLaunchedUri();

  Stream<Uri?> get widgetClicked;
}

class AndroidHomeWidgetService implements HomeWidgetSyncService {
  AndroidHomeWidgetService._internal();

  static final AndroidHomeWidgetService instance =
      AndroidHomeWidgetService._internal();

  static const String keyActiveCount = 'today_active_count';
  static const String keyTasksJson = 'today_tasks_json';
  static const String keyWidgetTitle = 'widget_title';
  static const String keyWidgetEmptyText = 'widget_empty_text';
  static const String androidWidgetName = 'ZettaskWidgetProvider';
  static const int maxDisplayTasks = 5;

  static ({int activeCount, String tasksJson}) buildPayload(
    List<TaskModel> todayTasks,
  ) {
    final activeTasks = todayTasks
        .where((task) => !task.isCompleted && !task.isCancelled)
        .toList()
      ..sort((a, b) {
        if (a.hasStartTime != b.hasStartTime) {
          return a.hasStartTime ? 1 : -1;
        }
        if (a.hasStartTime && b.hasStartTime) {
          final timeCompare =
              a.startTime!.trim().compareTo(b.startTime!.trim());
          if (timeCompare != 0) return timeCompare;
        }
        final priorityCompare = b.priority.value.compareTo(a.priority.value);
        if (priorityCompare != 0) return priorityCompare;
        return (a.id ?? 0).compareTo(b.id ?? 0);
      });

    final topItems = activeTasks.take(maxDisplayTasks).map((task) {
      return {
        'time': task.hasStartTime ? task.startTime!.trim() : '',
        'title': task.title.trim(),
      };
    }).toList();

    return (
      activeCount: activeTasks.length,
      tasksJson: jsonEncode(topItems),
    );
  }

  bool get _isAndroidRuntime => !kIsWeb && Platform.isAndroid;

  @override
  Future<void> updateTodayTasks(
    List<TaskModel> todayTasks, {
    String? widgetTitle,
    String? widgetEmptyText,
  }) async {
    if (!_isAndroidRuntime) {
      return;
    }

    try {
      final payload = buildPayload(todayTasks);
      await HomeWidget.saveWidgetData<int>(keyActiveCount, payload.activeCount);
      await HomeWidget.saveWidgetData<String>(keyTasksJson, payload.tasksJson);
      if (widgetTitle != null) {
        await HomeWidget.saveWidgetData<String>(keyWidgetTitle, widgetTitle);
      }
      if (widgetEmptyText != null) {
        await HomeWidget.saveWidgetData<String>(
          keyWidgetEmptyText,
          widgetEmptyText,
        );
      }
      await HomeWidget.updateWidget(androidName: androidWidgetName);
    } on MissingPluginException {
      // Ignore in widget tests or unsupported platforms.
    } on PlatformException catch (e) {
      debugPrint('AndroidHomeWidgetService.updateTodayTasks gagal: ${e.code}');
    } catch (e) {
      debugPrint('AndroidHomeWidgetService.updateTodayTasks gagal: $e');
    }
  }

  @override
  Future<void> updateWidgetLabels({
    required String widgetTitle,
    required String widgetEmptyText,
  }) async {
    if (!_isAndroidRuntime) {
      return;
    }
    try {
      await HomeWidget.saveWidgetData<String>(keyWidgetTitle, widgetTitle);
      await HomeWidget.saveWidgetData<String>(
        keyWidgetEmptyText,
        widgetEmptyText,
      );
      await HomeWidget.updateWidget(androidName: androidWidgetName);
    } on MissingPluginException {
      // Ignore in widget tests or unsupported platforms.
    } on PlatformException catch (e) {
      debugPrint('AndroidHomeWidgetService.updateWidgetLabels gagal: ${e.code}');
    } catch (e) {
      debugPrint('AndroidHomeWidgetService.updateWidgetLabels gagal: $e');
    }
  }

  @override
  Future<Uri?> getInitiallyLaunchedUri() async {
    if (!_isAndroidRuntime) {
      return null;
    }
    try {
      return await HomeWidget.initiallyLaunchedFromHomeWidget();
    } on MissingPluginException {
      return null;
    } on PlatformException {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<Uri?> get widgetClicked {
    if (!_isAndroidRuntime) {
      return const Stream<Uri?>.empty();
    }
    return HomeWidget.widgetClicked.handleError((Object _) {
      // Ignore platform channel errors when widget listener is unavailable.
    });
  }
}
