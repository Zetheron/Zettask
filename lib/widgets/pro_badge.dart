import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/subscription_provider.dart';

class ProBadge extends StatelessWidget {
  const ProBadge({
    super.key,
    this.visible = true,
    this.filled = false,
  });

  final bool visible;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider = context.watch<SubscriptionProvider?>();
    final isPaywallEnabled = subscriptionProvider?.isPaywallEnabled ??
        SubscriptionProvider.enableProPaywall;
    if (!visible || !isPaywallEnabled) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: filled ? 8 : 7,
        vertical: filled ? 2.5 : 2,
      ),
      decoration: BoxDecoration(
        color: filled ? colorScheme.primary : colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        l10n.proBadge,
        style: theme.textTheme.labelSmall?.copyWith(
          color:
              filled ? colorScheme.onPrimary : colorScheme.onPrimaryContainer,
          fontSize: 9.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
