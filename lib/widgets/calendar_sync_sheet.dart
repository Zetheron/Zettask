import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_theme.dart';
import '../l10n/app_localizations.dart';
import '../models/calendar_event_model.dart';
import '../providers/app_lock_provider.dart';
import '../providers/calendar_provider.dart';

class CalendarSyncSheet extends StatefulWidget {
  const CalendarSyncSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const CalendarSyncSheet(),
    );
  }

  @override
  State<CalendarSyncSheet> createState() => _CalendarSyncSheetState();
}

class _CalendarSyncSheetState extends State<CalendarSyncSheet>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final provider = context.read<CalendarProvider>();
        if (!provider.hasPermission ||
            (provider.isSyncEnabled && provider.calendars.isEmpty)) {
          provider.refreshPermissionAndCalendars();
        }
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;
    if (state == AppLifecycleState.resumed) {
      context.read<CalendarProvider>().refreshPermissionAndCalendars();
    }
  }

  void _suspendAppLock() {
    try {
      context.read<AppLockProvider>().suspendLockTemporarily(
            duration: const Duration(seconds: 30),
          );
    } catch (_) {
      // Allow sheet to render in tests where AppLockProvider is omitted.
    }
  }

  Future<void> _handleToggleSync(
    CalendarProvider calendarProvider,
    bool enabled,
  ) async {
    if (enabled && !calendarProvider.hasPermission) {
      _suspendAppLock();
    }
    await calendarProvider.setSyncEnabled(enabled);
  }

  Future<void> _handleRequestPermission(
    CalendarProvider calendarProvider,
  ) async {
    _suspendAppLock();
    await calendarProvider.requestCalendarPermission();
  }

  Future<void> _handleOpenSettings(CalendarProvider calendarProvider) async {
    _suspendAppLock();
    await calendarProvider.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final maxHeight = MediaQuery.sizeOf(context).height * 0.82;

    return Consumer<CalendarProvider>(
      builder: (context, calendarProvider, _) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight),
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
                padding: const EdgeInsetsDirectional.fromSTEB(20, 8, 8, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.deviceCalendarTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 19,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.close,
                      onPressed: () => Navigator.of(context).pop(),
                      style: IconButton.styleFrom(
                        minimumSize: const Size(48, 48),
                      ),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SyncToggleCard(
                        value: calendarProvider.isSyncEnabled,
                        isBusy: calendarProvider.isRequestingPermission,
                        onChanged: (enabled) =>
                            _handleToggleSync(calendarProvider, enabled),
                      ),
                      if (!calendarProvider.hasPermission) ...[
                        const SizedBox(height: 14),
                        _PermissionCard(
                          isPermanentlyDenied:
                              calendarProvider.isPermissionPermanentlyDenied,
                          showSettingsFallback:
                              calendarProvider.shouldShowOpenSettings,
                          isRequesting: calendarProvider.isRequestingPermission,
                          onRequestPermission: () =>
                              _handleRequestPermission(calendarProvider),
                          onOpenSettings: () =>
                              _handleOpenSettings(calendarProvider),
                          onRefresh:
                              calendarProvider.refreshPermissionAndCalendars,
                        ),
                      ],
                      if (calendarProvider.errorMessage != null &&
                          calendarProvider.hasPermission) ...[
                        const SizedBox(height: 12),
                        _ErrorBanner(message: calendarProvider.errorMessage!),
                      ],
                      if (calendarProvider.isSyncEnabled &&
                          calendarProvider.hasPermission) ...[
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                l10n.selectCalendarsLabel,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                            if (calendarProvider.calendars.isNotEmpty)
                              Text(
                                l10n.calendarsActiveCount(
                                  calendarProvider.selectedCalendarIds.length,
                                  calendarProvider.calendars.length,
                                ),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _CalendarListSection(
                          isLoading: calendarProvider.isLoadingCalendars,
                          calendars: calendarProvider.calendars,
                          selectedIds: calendarProvider.selectedCalendarIds,
                          onToggle: calendarProvider.toggleCalendarSelection,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SyncToggleCard extends StatelessWidget {
  const _SyncToggleCard({
    required this.value,
    required this.isBusy,
    required this.onChanged,
  });

  final bool value;
  final bool isBusy;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Material(
      color: colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: colorScheme.outline, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: SwitchListTile(
        value: value,
        onChanged: isBusy ? null : onChanged,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        title: Text(
          l10n.showCalendarEventsTitle,
          style: theme.textTheme.titleMedium?.copyWith(fontSize: 15),
        ),
        subtitle: Text(
          l10n.showCalendarEventsSubtitle,
          style: theme.textTheme.bodySmall,
        ),
      ),
    );
  }
}

class _PermissionCard extends StatelessWidget {
  const _PermissionCard({
    required this.isPermanentlyDenied,
    required this.showSettingsFallback,
    required this.isRequesting,
    required this.onRequestPermission,
    required this.onOpenSettings,
    required this.onRefresh,
  });

  final bool isPermanentlyDenied;
  final bool showSettingsFallback;
  final bool isRequesting;
  final VoidCallback onRequestPermission;
  final VoidCallback onOpenSettings;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isPermanentlyDenied ? colorScheme.error : colorScheme.outline,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isPermanentlyDenied
                    ? Icons.block_rounded
                    : Icons.calendar_month_outlined,
                size: 20,
                color: isPermanentlyDenied
                    ? colorScheme.error
                    : colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isPermanentlyDenied
                          ? l10n.calendarPermDeniedPermanentTitle
                          : l10n.calendarPermRequiredTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isPermanentlyDenied
                          ? l10n.calendarPermDeniedPermanentDesc
                          : showSettingsFallback
                              ? l10n.calendarPermFallbackHint
                              : l10n.calendarPermRequiredDesc,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (isPermanentlyDenied)
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: onOpenSettings,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(l10n.openSettingsButton),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: onRefresh,
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(48, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(l10n.checkAgainButton),
                ),
              ],
            )
          else ...[
            FilledButton(
              onPressed: isRequesting ? null : onRequestPermission,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: isRequesting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator.adaptive(strokeWidth: 2),
                    )
                  : Text(l10n.grantCalendarPermission),
            ),
            if (showSettingsFallback) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onOpenSettings,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(l10n.openSettingsButton),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: onRefresh,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(48, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(l10n.checkAgainButton),
                  ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.error.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline_rounded, size: 18, color: colorScheme.error),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarListSection extends StatelessWidget {
  const _CalendarListSection({
    required this.isLoading,
    required this.calendars,
    required this.selectedIds,
    required this.onToggle,
  });

  final bool isLoading;
  final List<DeviceCalendarInfo> calendars;
  final Set<String> selectedIds;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    if (calendars.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: colorScheme.outline, width: 1),
        ),
        child: Text(
          l10n.noCalendarsFound,
          style: theme.textTheme.bodySmall,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.outline, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: List.generate(calendars.length, (index) {
          final calendar = calendars[index];
          final isChecked = selectedIds.contains(calendar.id);
          final dotColor = AppTheme.resolveTagColor(
            calendar.colorHex,
            theme.brightness,
          );
          final hasAccount = calendar.accountName != null &&
              calendar.accountName!.trim().isNotEmpty &&
              calendar.accountName!.trim() != calendar.name.trim();

          return Column(
            children: [
              if (index > 0) const Divider(),
              InkWell(
                onTap: () => onToggle(calendar.id),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 52),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(14, 6, 6, 6),
                    child: Row(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                calendar.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (hasAccount)
                                Text(
                                  calendar.accountName!.trim(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: Checkbox(
                            value: isChecked,
                            onChanged: (_) => onToggle(calendar.id),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
