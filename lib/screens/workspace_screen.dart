import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_lock_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/calendar_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/workspace_provider.dart';
import '../services/export_service.dart';
import '../widgets/about_sheet.dart';
import '../widgets/account_sheet.dart';
import '../widgets/calendar_sync_sheet.dart';
import '../widgets/language_picker_sheet.dart';
import '../widgets/weekly_stats_card.dart';
import 'auth_welcome_screen.dart';
import 'notes_screen.dart';
import 'repeating_tasks_screen.dart';
import 'stats_screen.dart';
import 'tags_screen.dart';
import 'templates_screen.dart';
import 'theme_settings_screen.dart';

class WorkspaceScreen extends StatelessWidget {
  const WorkspaceScreen({
    super.key,
    required this.themeMode,
    this.onToggleTheme,
    this.onSelectThemeMode,
  });

  final ThemeMode themeMode;
  final VoidCallback? onToggleTheme;
  final ValueChanged<ThemeMode>? onSelectThemeMode;

  String _themeModeLabel(BuildContext context, AppLocalizations l10n) {
    return switch (themeMode) {
      ThemeMode.light => l10n.themeLight,
      ThemeMode.dark => l10n.themeDark,
      ThemeMode.system =>
        Theme.of(context).brightness == Brightness.dark
            ? l10n.themeSystemDark
            : l10n.themeSystemLight,
    };
  }

  String _syncStatusLabel(SyncStatus status, AppLocalizations l10n) {
    return switch (status) {
      SyncStatus.idle => l10n.syncStatusIdle,
      SyncStatus.syncing => l10n.syncStatusSyncing,
      SyncStatus.synced => l10n.syncStatusSynced,
      SyncStatus.error => l10n.syncStatusError,
    };
  }

  Future<void> _openExportSheet(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final target = await showModalBottomSheet<ExportTarget>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        final colorScheme = theme.colorScheme;
        final sheetL10n = AppLocalizations.of(sheetContext);
        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.outline,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 8, 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          sheetL10n.exportDataCsvTitle,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: sheetL10n.close,
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        style: IconButton.styleFrom(
                          minimumSize: const Size(48, 48),
                        ),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                  child: Column(
                    children: [
                      _ExportOptionTile(
                        icon: Icons.task_alt_rounded,
                        title: sheetL10n.exportTasksTitle,
                        subtitle: sheetL10n.exportTasksSubtitle,
                        onTap: () =>
                            Navigator.of(sheetContext).pop(ExportTarget.tasks),
                      ),
                      const SizedBox(height: 10),
                      _ExportOptionTile(
                        icon: Icons.sticky_note_2_outlined,
                        title: sheetL10n.exportNotesTitle,
                        subtitle: sheetL10n.exportNotesSubtitle,
                        onTap: () =>
                            Navigator.of(sheetContext).pop(ExportTarget.notes),
                      ),
                      const SizedBox(height: 10),
                      _ExportOptionTile(
                        icon: Icons.file_download_outlined,
                        title: sheetL10n.exportBothTitle,
                        subtitle: sheetL10n.exportBothSubtitle,
                        onTap: () =>
                            Navigator.of(sheetContext).pop(ExportTarget.both),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (!context.mounted || target == null) return;
    context.read<AppLockProvider?>()?.suspendLockTemporarily();
    final result = await context.read<WorkspaceProvider>().exportCsv(target);
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(result.message.isNotEmpty ? result.message : l10n.exportCsvTitle)),
      );
  }

  void _openThemeSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => const ThemeSettingsScreen(),
      ),
    );
  }

  Future<void> _openFirstDayPicker(
    BuildContext context,
    TaskProvider taskProvider,
  ) async {
    final selected = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        final colorScheme = theme.colorScheme;
        final sheetL10n = AppLocalizations.of(sheetContext);
        return SafeArea(
          top: false,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.outline,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 8, 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          sheetL10n.firstDayOfWeek,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: sheetL10n.close,
                        onPressed: () => Navigator.of(sheetContext).pop(),
                        style: IconButton.styleFrom(
                          minimumSize: const Size(48, 48),
                        ),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                  child: Column(
                    children: [
                      for (final option in [
                        (
                          DateTime.monday,
                          sheetL10n.monday,
                          sheetL10n.firstDayMondayOrder,
                        ),
                        (
                          DateTime.sunday,
                          sheetL10n.sunday,
                          sheetL10n.firstDaySundayOrder,
                        ),
                      ])
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Material(
                            color: taskProvider.firstDayOfWeek == option.$1
                                ? colorScheme.primaryContainer
                                : colorScheme.surface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: taskProvider.firstDayOfWeek == option.$1
                                    ? colorScheme.primary
                                    : colorScheme.outline,
                                width: 1,
                              ),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () =>
                                  Navigator.of(sheetContext).pop(option.$1),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(minHeight: 56),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              option.$2,
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(fontSize: 14.5),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              option.$3,
                                              style: theme.textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (taskProvider.firstDayOfWeek ==
                                          option.$1)
                                        Icon(
                                          Icons.check_rounded,
                                          size: 20,
                                          color: colorScheme.primary,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null) {
      await taskProvider.setFirstDayOfWeek(selected);
    }
  }

  Future<void> _handleToggleAppLock(
    BuildContext context,
    AppLockProvider appLockProvider,
    bool value,
  ) async {
    final l10n = AppLocalizations.of(context);
    final success = await appLockProvider.setEnabled(value);
    if (!context.mounted) return;
    if (!success) {
      final message = !appLockProvider.isDeviceSupported
          ? l10n.appLockUnsupportedError
          : l10n.appLockCancelledError;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _openAccountFlow(BuildContext context, AuthProvider authProvider) {
    if (authProvider.isSignedIn) {
      AccountSheet.show(context);
    } else {
      authProvider.clearError();
      Navigator.of(context).push(
        MaterialPageRoute<bool>(
          settings: const RouteSettings(name: AuthWelcomeScreen.routeName),
          builder: (_) => const AuthWelcomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final localeProvider = context.watch<LocaleProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Consumer4<CalendarProvider, TaskProvider, WorkspaceProvider,
        AuthProvider>(
      builder: (
        context,
        calendarProvider,
        taskProvider,
        workspaceProvider,
        authProvider,
        _,
      ) {
        final isCalendarActive =
            calendarProvider.isSyncEnabled && calendarProvider.hasPermission;
        final calendarSubtitle = isCalendarActive
            ? l10n.calendarSyncActiveSubtitle(
                calendarProvider.selectedCalendarIds.length,
              )
            : l10n.calendarSyncInactiveSubtitle;
        final activeRepeatingCount = taskProvider.activeRepeatingRuleCount;
        final repeatingSubtitle = activeRepeatingCount > 0
            ? l10n.repeatingActiveCount(activeRepeatingCount)
            : l10n.repeatingTasksSubtitleEmpty;

        final tagCount = workspaceProvider.tags.length;
        final templateCount = workspaceProvider.templates.length;
        final noteCount = workspaceProvider.notes.length;
        final user = authProvider.user;
        final firstDayLabel = taskProvider.firstDayOfWeek == DateTime.sunday
            ? l10n.sunday
            : l10n.monday;

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.workspaceTitle),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 6),
                child: IconButton(
                  tooltip: l10n.accountAndSyncTitle,
                  onPressed: () => _openAccountFlow(context, authProvider),
                  style: IconButton.styleFrom(
                    minimumSize: const Size(48, 48),
                  ),
                  icon: user != null
                      ? CircleAvatar(
                          radius: 14,
                          backgroundColor: colorScheme.primaryContainer,
                          foregroundColor: colorScheme.primary,
                          child: Text(
                            user.initials,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.primary,
                            ),
                          ),
                        )
                      : const Icon(Icons.account_circle_outlined, size: 24),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
              children: [
                _AccountSummaryCard(
                  authProvider: authProvider,
                  syncStatusLabel: _syncStatusLabel(authProvider.syncStatus, l10n),
                  onTap: () => _openAccountFlow(context, authProvider),
                ),
                const SizedBox(height: 12),
                WeeklyStatsCard(
                  stats: workspaceProvider.stats,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const StatsScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _SectionHeader(title: l10n.organizeSection),
                const SizedBox(height: 8),
                _SettingsCard(
                  children: [
                    _SettingsTile(
                      icon: Icons.label_outline_rounded,
                      iconColor: tagCount > 0
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                      title: l10n.tagsTitle,
                      subtitle: tagCount > 0
                          ? l10n.tagsCountSubtitle(tagCount)
                          : l10n.tagsSubtitleEmpty,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const TagsScreen(),
                        ),
                      ),
                    ),
                    const Divider(),
                    _SettingsTile(
                      icon: Icons.content_copy_outlined,
                      iconColor: templateCount > 0
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                      title: l10n.templatesTitle,
                      subtitle: templateCount > 0
                          ? l10n.templatesCountSubtitle(templateCount)
                          : l10n.templatesSubtitleEmpty,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const TemplatesScreen(),
                        ),
                      ),
                    ),
                    const Divider(),
                    _SettingsTile(
                      icon: Icons.sticky_note_2_outlined,
                      iconColor: noteCount > 0
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                      title: l10n.notesTitle,
                      subtitle: noteCount > 0
                          ? l10n.notesCountSubtitle(noteCount)
                          : l10n.notesSubtitleEmpty,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const NotesScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _SectionHeader(title: l10n.automationSection),
                const SizedBox(height: 8),
                _SettingsCard(
                  children: [
                    _SettingsTile(
                      icon: Icons.repeat_rounded,
                      iconColor: activeRepeatingCount > 0
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                      title: l10n.repeatingTasksTitle,
                      subtitle: repeatingSubtitle,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const RepeatingTasksScreen(),
                        ),
                      ),
                    ),
                    const Divider(),
                    _SettingsTile(
                      icon: Icons.calendar_month_outlined,
                      iconColor: isCalendarActive
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                      title: l10n.calendarSyncTitle,
                      subtitle: calendarSubtitle,
                      onTap: () => CalendarSyncSheet.show(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _SectionHeader(title: l10n.insightsSection),
                const SizedBox(height: 8),
                _SettingsCard(
                  children: [
                    _SettingsTile(
                      icon: Icons.bar_chart_rounded,
                      iconColor: colorScheme.primary,
                      title: l10n.statsTitle,
                      subtitle: l10n.statsSubtitle(
                        workspaceProvider.stats.allTimeCompletedTasks,
                        workspaceProvider.stats.completionPercentage,
                      ),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const StatsScreen(),
                        ),
                      ),
                    ),
                    const Divider(),
                    _SettingsTile(
                      icon: Icons.file_download_outlined,
                      iconColor: colorScheme.onSurfaceVariant,
                      title: l10n.exportCsvTitle,
                      subtitle: l10n.exportCsvSubtitle,
                      onTap: () => _openExportSheet(context),
                    ),
                    const Divider(),
                    _SettingsTile(
                      icon: Icons.palette_outlined,
                      iconColor: colorScheme.primary,
                      title: l10n.themeTitle,
                      subtitle:
                          '${_themeModeLabel(context, l10n)} · ${themeProvider.preset.label}',
                      onTap: () => _openThemeSettings(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _SectionHeader(title: l10n.settingsInfoSection),
                const SizedBox(height: 8),
                _SettingsCard(
                  children: [
                    _SettingsTile(
                      key: const ValueKey('workspace_language_tile'),
                      icon: Icons.translate_rounded,
                      iconColor: colorScheme.primary,
                      title: l10n.languageTitle,
                      subtitle: localeProvider.currentLanguageLabel(l10n),
                      onTap: () => LanguagePickerSheet.show(context),
                    ),
                    const Divider(),
                    _SettingsTile(
                      icon: Icons.date_range_outlined,
                      iconColor: colorScheme.onSurfaceVariant,
                      title: l10n.firstDayOfWeek,
                      subtitle: firstDayLabel,
                      onTap: () => _openFirstDayPicker(context, taskProvider),
                    ),
                    const Divider(),
                    Consumer<AppLockProvider>(
                      builder: (context, appLockProvider, _) {
                        return SwitchListTile(
                          key: const ValueKey('workspace_app_lock_switch'),
                          value: appLockProvider.isEnabled,
                          onChanged: appLockProvider.isAuthenticating
                              ? null
                              : (value) => _handleToggleAppLock(
                                    context,
                                    appLockProvider,
                                    value,
                                  ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 4,
                          ),
                          secondary: Icon(
                            Icons.lock_outline_rounded,
                            size: 20,
                            color: appLockProvider.isEnabled
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                          ),
                          title: Text(
                            l10n.appLockTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 14.5,
                            ),
                          ),
                          subtitle: Text(
                            l10n.appLockSubtitle,
                            style: theme.textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
                    const Divider(),
                    SwitchListTile(
                      value: taskProvider.showCompletedTasks,
                      onChanged: taskProvider.setShowCompletedTasks,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 4,
                      ),
                      secondary: Icon(
                        Icons.check_circle_outline_rounded,
                        size: 20,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      title: Text(
                        l10n.showCompletedTasks,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.5,
                        ),
                      ),
                      subtitle: Text(
                        l10n.showCompletedWorkspaceSubtitle,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    const Divider(),
                    _SettingsTile(
                      icon: Icons.info_outline_rounded,
                      iconColor: colorScheme.onSurfaceVariant,
                      title: l10n.aboutPrivacyTitle,
                      subtitle: l10n.aboutPrivacySubtitle(AboutSheet.appVersion),
                      onTap: () => AboutSheet.show(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ExportOptionTile extends StatelessWidget {
  const _ExportOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colorScheme.outline, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Icon(icon, size: 20, color: colorScheme.primary),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(subtitle, style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 4),
      child: Text(
        title,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontSize: 12.5,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colorScheme.outline, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: children,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountSummaryCard extends StatelessWidget {
  const _AccountSummaryCard({
    required this.authProvider,
    required this.syncStatusLabel,
    required this.onTap,
  });

  final AuthProvider authProvider;
  final String syncStatusLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final user = authProvider.user;

    final title = user != null ? user.displayLabel : l10n.signInToZettask;
    final subtitle = user != null ? syncStatusLabel : l10n.accountBannerSubtitle;

    return Material(
      color: colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colorScheme.outline, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                if (user != null)
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: colorScheme.primaryContainer,
                    foregroundColor: colorScheme.primary,
                    child: Text(
                      user.initials,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.primary,
                      ),
                    ),
                  )
                else
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.outline, width: 1),
                    ),
                    child: Icon(
                      Icons.cloud_outlined,
                      size: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 14.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: user != null &&
                                  authProvider.syncStatus == SyncStatus.error
                              ? colorScheme.error
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
