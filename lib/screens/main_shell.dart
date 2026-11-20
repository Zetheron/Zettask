import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/repeating_task_model.dart';
import '../models/subscription_model.dart';
import '../models/task_model.dart';
import '../providers/auth_provider.dart';
import '../providers/calendar_provider.dart';
import '../providers/subscription_provider.dart';
import '../providers/task_provider.dart';
import '../providers/workspace_provider.dart';
import '../services/home_widget_service.dart';
import '../widgets/quick_add_task_sheet.dart';
import '../widgets/task_editor_sheet.dart';
import 'board_screen.dart';
import 'home_screen.dart';
import 'unplanned_screen.dart';
import 'workspace_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    this.themeMode = ThemeMode.system,
    this.onToggleTheme,
    this.onSelectThemeMode,
    this.autoLoad = true,
    this.homeWidgetService,
  });

  final ThemeMode themeMode;
  final VoidCallback? onToggleTheme;
  final ValueChanged<ThemeMode>? onSelectThemeMode;
  final bool autoLoad;
  final HomeWidgetSyncService? homeWidgetService;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  TaskProvider? _taskProvider;
  WorkspaceProvider? _workspaceProvider;
  AuthProvider? _authProvider;
  StreamSubscription<Uri?>? _widgetClickSubscription;
  bool _handlingWidgetQuickAdd = false;

  HomeWidgetSyncService get _homeWidgetService =>
      widget.homeWidgetService ?? AndroidHomeWidgetService.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _taskProvider = context.read<TaskProvider>();
      _workspaceProvider = context.read<WorkspaceProvider>();
      _authProvider = context.read<AuthProvider>();
      _taskProvider?.addListener(_onTaskStateChanged);
      _authProvider?.attachDataSyncedCallback(_handleCloudDataSynced);

      if (widget.autoLoad) {
        final calendarProvider = context.read<CalendarProvider>();
        final subscriptionProvider = context.read<SubscriptionProvider?>();
        final allowCalendarSync = subscriptionProvider == null ||
            !subscriptionProvider.isInitialized ||
            subscriptionProvider.hasAccess(ProFeature.calendarSync);
        _taskProvider!.initialize();
        _workspaceProvider!.initialize();
        calendarProvider.initialize(
          initialDate: _taskProvider!.selectedDate,
          allowSync: allowCalendarSync,
        );
      }

      _initHomeWidgetListener();
    });
  }

  Future<void> _initHomeWidgetListener() async {
    final initialUri = await _homeWidgetService.getInitiallyLaunchedUri();
    if (mounted && initialUri != null) {
      await _handleWidgetUri(initialUri);
    }
    if (!mounted) return;
    _widgetClickSubscription = _homeWidgetService.widgetClicked.listen((uri) {
      if (mounted && uri != null) {
        _handleWidgetUri(uri);
      }
    });
  }

  bool _isQuickAddUri(Uri uri) {
    return uri.host == 'quick-add' ||
        uri.path.contains('quick-add') ||
        uri.toString().contains('quick-add');
  }

  Future<void> _handleWidgetUri(Uri uri) async {
    if (!_isQuickAddUri(uri) || _handlingWidgetQuickAdd || !mounted) return;
    _handlingWidgetQuickAdd = true;
    try {
      if (_currentIndex != 0) {
        setState(() => _currentIndex = 0);
      }
      final taskProvider = _taskProvider ?? context.read<TaskProvider>();
      await taskProvider.goToToday();
      if (!mounted) return;

      final quickResult = await QuickAddTaskSheet.show(
        context,
        defaultDate: taskProvider.currentToday,
        onRequestNotificationPermission:
            taskProvider.requestNotificationPermission,
      );
      if (!mounted || quickResult == null) return;

      switch (quickResult) {
        case QuickAddSaved(:final task):
          await taskProvider.addTask(task);
        case QuickAddExpand(:final draftTask):
          final editorResult = await TaskEditorSheet.show(
            context,
            initialTask: draftTask,
            defaultDate: draftTask.date,
            onRequestNotificationPermission:
                taskProvider.requestNotificationPermission,
          );
          if (!mounted || editorResult == null) return;
          if (editorResult case TaskEditorSaved(:final task, :final repeatConfig)) {
            if (repeatConfig != null && task.date != null) {
              await taskProvider.addRepeatingTask(
                RepeatingTaskRule(
                  title: task.title,
                  description: task.description,
                  startTime: task.startTime,
                  priority: task.priority,
                  colorHex: task.colorHex,
                  checklistItems: task.checklistItems
                      .map((i) => ChecklistItem(title: i.title, isDone: false))
                      .toList(),
                  reminderMinutesBefore: task.reminderMinutesBefore,
                  frequency: repeatConfig.frequency,
                  weekdays: repeatConfig.weekdays,
                  startDate: task.date!,
                  projectId: task.projectId,
                  tagId: task.tagId,
                ),
              );
            } else {
              await taskProvider.addTask(task);
            }
          }
      }
    } finally {
      _handlingWidgetQuickAdd = false;
    }
  }

  Future<void> _handleCloudDataSynced() async {
    if (!mounted) return;
    await _taskProvider?.loadTasksForSelectedDate(showLoading: false);
    await _workspaceProvider?.refreshAll();
  }

  void _onTaskStateChanged() {
    final taskProvider = _taskProvider;
    final workspaceProvider = _workspaceProvider;
    if (!mounted || taskProvider == null || workspaceProvider == null) return;
    if (!taskProvider.isLoading) {
      workspaceProvider.refreshCounts();
    }
  }

  @override
  void dispose() {
    _widgetClickSubscription?.cancel();
    _taskProvider?.removeListener(_onTaskStateChanged);
    _authProvider?.attachDataSyncedCallback(null);
    super.dispose();
  }

  void _switchTab(int index) {
    if (_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final unplannedCount = context.select<TaskProvider, int>(
      (provider) => provider.unplannedCount,
    );

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(
            autoLoad: false,
            onOpenUnplannedTab: () => _switchTab(2),
          ),
          const BoardScreen(),
          const UnplannedScreen(),
          WorkspaceScreen(
            themeMode: widget.themeMode,
            onToggleTheme: widget.onToggleTheme,
            onSelectThemeMode: widget.onSelectThemeMode,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: colorScheme.outline, width: 1),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: _switchTab,
          elevation: 0,
          backgroundColor: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          indicatorColor: colorScheme.primaryContainer,
          height: 68,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.view_day_outlined),
              selectedIcon: const Icon(Icons.view_day_rounded),
              label: l10n.navTimeline,
            ),
            NavigationDestination(
              icon: const Icon(Icons.dashboard_outlined),
              selectedIcon: const Icon(Icons.dashboard_rounded),
              label: l10n.navBoard,
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: unplannedCount > 0,
                label: Text('$unplannedCount'),
                child: const Icon(Icons.inbox_outlined),
              ),
              selectedIcon: Badge(
                isLabelVisible: unplannedCount > 0,
                label: Text('$unplannedCount'),
                child: const Icon(Icons.inbox_rounded),
              ),
              label: l10n.navUnplanned,
            ),
            NavigationDestination(
              icon: const Icon(Icons.tune_outlined),
              selectedIcon: const Icon(Icons.tune_rounded),
              label: l10n.navMore,
            ),
          ],
        ),
      ),
    );
  }
}
