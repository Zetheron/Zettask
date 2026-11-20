import 'package:material_ui/material_ui.dart';

import '../l10n/app_localizations.dart';
import '../providers/task_provider.dart';

enum RepeatingActionIntent {
  edit,
  delete,
}

class RepeatingActionSheet extends StatelessWidget {
  const RepeatingActionSheet({
    super.key,
    required this.intent,
  });

  final RepeatingActionIntent intent;

  static Future<RepeatingActionScope?> show(
    BuildContext context, {
    required RepeatingActionIntent intent,
  }) {
    return showModalBottomSheet<RepeatingActionScope>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => RepeatingActionSheet(intent: intent),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final isDelete = intent == RepeatingActionIntent.delete;

    return SafeArea(
      top: false,
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
            padding: const EdgeInsetsDirectional.fromSTEB(20, 12, 8, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.repeatingActionTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isDelete
                            ? l10n.repeatingDeletePrompt
                            : l10n.repeatingEditPrompt,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
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
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _ScopeOptionTile(
                  icon: Icons.event_outlined,
                  iconColor:
                      isDelete ? colorScheme.error : colorScheme.primary,
                  title: l10n.repeatingThisOnly,
                  subtitle: isDelete
                      ? l10n.repeatingDeleteSingleSub
                      : l10n.repeatingEditSingleSub,
                  onTap: () => Navigator.of(context).pop(
                    RepeatingActionScope.single,
                  ),
                ),
                const SizedBox(height: 10),
                _ScopeOptionTile(
                  icon: Icons.repeat_rounded,
                  iconColor:
                      isDelete ? colorScheme.error : colorScheme.primary,
                  title: l10n.repeatingThisAndFollowing,
                  subtitle: isDelete
                      ? l10n.repeatingDeleteFollowingSub
                      : l10n.repeatingEditFollowingSub,
                  onTap: () => Navigator.of(context).pop(
                    RepeatingActionScope.thisAndFollowing,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScopeOptionTile extends StatelessWidget {
  const _ScopeOptionTile({
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
          constraints: const BoxConstraints(minHeight: 62),
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
      ),
    );
  }
}
