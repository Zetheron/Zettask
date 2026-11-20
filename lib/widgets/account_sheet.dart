import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/subscription_model.dart';
import '../providers/auth_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/subscription_provider.dart';
import '../screens/pro_paywall_screen.dart';
import 'pro_badge.dart';

class AccountSheet extends StatelessWidget {
  const AccountSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const AccountSheet(),
    );
  }

  String _formatSyncTime(
    BuildContext context,
    DateTime? syncedAt,
    AppLocalizations l10n,
  ) {
    if (syncedAt == null) return l10n.neverSynced;
    final localeTag =
        LocaleProvider.intlLocaleTag(Localizations.localeOf(context));
    try {
      return DateFormat('d MMM yyyy · HH:mm', localeTag).format(syncedAt);
    } catch (_) {
      return DateFormat('d MMM yyyy · HH:mm').format(syncedAt);
    }
  }

  String _syncStatusLabel(SyncStatus status, AppLocalizations l10n) {
    return switch (status) {
      SyncStatus.idle => l10n.syncStatusIdle,
      SyncStatus.syncing => l10n.syncStatusSyncing,
      SyncStatus.synced => l10n.syncStatusSynced,
      SyncStatus.error => l10n.syncStatusError,
    };
  }

  Future<void> _handleSync(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final authProvider = context.read<AuthProvider>();
    final ok = await authProvider.syncNow();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(ok ? l10n.syncDoneMessage : l10n.syncFailedMessage),
        ),
      );
  }

  Future<void> _handleSignOut(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final authProvider = context.read<AuthProvider>();
    final ok = await authProvider.signOut();
    if (!context.mounted) return;
    if (ok) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.signedOutMessage)));
    }
  }

  Future<void> _handleDeleteAccount(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final step1 = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.deleteAccountStep1Title),
          content: Text(l10n.deleteAccountStep1Body),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(dialogContext).colorScheme.error,
              ),
              child: Text(l10n.continueAction),
            ),
          ],
        );
      },
    );

    if (step1 != true || !context.mounted) return;

    final step2 = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final colorScheme = Theme.of(dialogContext).colorScheme;
        return AlertDialog(
          title: Text(l10n.deleteAccountStep2Title),
          content: Text(l10n.deleteAccountStep2Body),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
                elevation: 0,
              ),
              child: Text(l10n.deleteAccountConfirmButton),
            ),
          ],
        );
      },
    );

    if (step2 != true || !context.mounted) return;

    final authProvider = context.read<AuthProvider>();
    final deleted = await authProvider.deleteAccount();
    if (!context.mounted) return;

    if (deleted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.accountDeletedMessage)));
    } else if (authProvider.requiresRecentLogin) {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: Text(l10n.reloginRequiredTitle),
          content: Text(
            authProvider.localizedError(l10n) ?? l10n.authErrRequiresRecentLogin,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(l10n.understand),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final authProvider = context.watch<AuthProvider>();
    final subscriptionProvider = context.watch<SubscriptionProvider?>();
    final user = authProvider.user;

    if (user == null) {
      return const SizedBox.shrink();
    }

    final isBusy = authProvider.isAuthBusy;
    final isSyncing = authProvider.isSyncing;
    final hasCloudSyncAccess =
        subscriptionProvider?.hasAccess(ProFeature.cloudSync) ?? true;
    final isCloudSyncPaused =
        !hasCloudSyncAccess || authProvider.isCloudSyncPaused;
    final localizedError = authProvider.localizedError(l10n);

    final (syncIcon, syncColor) = isCloudSyncPaused
        ? (Icons.cloud_off_outlined, colorScheme.onSurfaceVariant)
        : switch (authProvider.syncStatus) {
            SyncStatus.synced => (
                Icons.cloud_done_outlined,
                colorScheme.primary,
              ),
            SyncStatus.syncing => (
                Icons.cloud_sync_outlined,
                colorScheme.primary,
              ),
            SyncStatus.error => (Icons.cloud_off_outlined, colorScheme.error),
            SyncStatus.idle => (
                Icons.cloud_queue_outlined,
                colorScheme.onSurfaceVariant,
              ),
          };

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
                      l10n.accountAndSyncTitle,
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.close,
                    onPressed: isBusy ? null : () => Navigator.of(context).pop(),
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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: colorScheme.outline, width: 1),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: colorScheme.primaryContainer,
                          foregroundColor: colorScheme.primary,
                          child: Text(
                            user.initials,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.displayLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              if (user.email != null &&
                                  user.email != user.displayLabel) ...[
                                const SizedBox(height: 2),
                                Text(
                                  user.email!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                              const SizedBox(height: 2),
                              Text(
                                l10n.signedInVia(user.providerLabel),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: colorScheme.outline, width: 1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(syncIcon, size: 20, color: syncColor),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      isCloudSyncPaused
                                          ? l10n.cloudSyncPausedTitle
                                          : _syncStatusLabel(
                                              authProvider.syncStatus,
                                              l10n,
                                            ),
                                      style:
                                          theme.textTheme.titleMedium?.copyWith(
                                        fontSize: 14,
                                        color: syncColor,
                                      ),
                                    ),
                                  ),
                                  if (isCloudSyncPaused) ...[
                                    const SizedBox(width: 8),
                                    const ProBadge(),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isCloudSyncPaused
                                    ? l10n.cloudSyncPausedBody
                                    : l10n.lastSyncedPrefix(
                                        _formatSyncTime(
                                          context,
                                          authProvider.lastSyncedAt,
                                          l10n,
                                        ),
                                      ),
                                style: theme.textTheme.bodySmall,
                              ),
                              if (!isCloudSyncPaused &&
                                  authProvider.syncStatus ==
                                      SyncStatus.error) ...[
                                const SizedBox(height: 4),
                                Text(
                                  l10n.syncFailedMessage,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.error,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (localizedError != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: colorScheme.error.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorScheme.error.withValues(alpha: 0.35),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        localizedError,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: (isBusy || isSyncing)
                        ? null
                        : isCloudSyncPaused
                            ? () => showProPaywall(
                                  context,
                                  highlightedFeature: ProFeature.cloudSync,
                                )
                            : () => _handleSync(context),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: isSyncing
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            isCloudSyncPaused
                                ? Icons.workspace_premium_outlined
                                : Icons.sync_rounded,
                            size: 18,
                          ),
                    label: Text(
                      isCloudSyncPaused
                          ? l10n.resumeSyncWithProButton
                          : (isSyncing
                              ? l10n.syncingLabel
                              : l10n.syncNowButton),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: isBusy ? null : () => _handleSignOut(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      side: BorderSide(color: colorScheme.outline, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.logout_rounded, size: 18),
                    label: Text(l10n.signOutButton),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed:
                        isBusy ? null : () => _handleDeleteAccount(context),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      foregroundColor: colorScheme.error,
                      side: BorderSide(
                        color: colorScheme.error.withValues(alpha: 0.45),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.delete_forever_outlined, size: 18),
                    label: Text(l10n.deleteAccountButton),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
