import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../models/subscription_model.dart';
import '../providers/subscription_provider.dart';
import '../widgets/pro_badge.dart';
import '../widgets/zettask_loaders.dart';

String localizedProPlanName(ProPlanType plan, AppLocalizations l10n) {
  return switch (plan) {
    ProPlanType.monthly => l10n.proPlanMonthlyTitle,
    ProPlanType.yearly => l10n.proPlanYearlyTitle,
    ProPlanType.lifetime => l10n.proPlanLifetimeTitle,
  };
}

Future<bool?> showProPaywall(
  BuildContext context, {
  ProFeature? highlightedFeature,
}) {
  return Navigator.of(context).push<bool>(
    MaterialPageRoute<bool>(
      fullscreenDialog: true,
      builder: (_) => ProPaywallScreen(
        highlightedFeature: highlightedFeature,
      ),
    ),
  );
}

class ProPaywallScreen extends StatefulWidget {
  const ProPaywallScreen({
    super.key,
    this.highlightedFeature,
  });

  final ProFeature? highlightedFeature;

  @override
  State<ProPaywallScreen> createState() => _ProPaywallScreenState();
}

class _ProPaywallScreenState extends State<ProPaywallScreen> {
  ProPlanType _selectedPlan = ProPlanType.yearly;

  String? _contextualFeatureCopy(AppLocalizations l10n) {
    final feature = widget.highlightedFeature;
    if (feature == null) return null;
    return switch (feature) {
      ProFeature.unlimitedProjects => l10n.proContextUnlimitedProjects,
      ProFeature.calendarSync => l10n.proContextCalendarSync,
      ProFeature.appLock => l10n.proContextAppLock,
      ProFeature.csvExport => l10n.proContextCsvExport,
      ProFeature.cloudSync => l10n.proContextCloudSync,
      ProFeature.customThemes => l10n.proContextCustomThemes,
      ProFeature.widgetStyles => l10n.proContextWidgetStyles,
    };
  }

  bool _isBenefitHighlighted(ProFeature benefitFeature) {
    final highlighted = widget.highlightedFeature;
    if (highlighted == null) return false;
    if (highlighted == benefitFeature) return true;
    if (highlighted == ProFeature.csvExport &&
        benefitFeature == ProFeature.unlimitedProjects) {
      return true;
    }
    if (highlighted == ProFeature.widgetStyles &&
        benefitFeature == ProFeature.customThemes) {
      return true;
    }
    return false;
  }

  String _resolvePrice(
    ProPlanType plan,
    SubscriptionProvider subscriptionProvider,
    AppLocalizations l10n,
  ) {
    final offering = subscriptionProvider.offeringFor(plan);
    final livePrice = offering.formattedPrice?.trim();
    if (livePrice != null && livePrice.isNotEmpty) {
      return livePrice;
    }
    return switch (plan) {
      ProPlanType.monthly => l10n.proPlanMonthlyPrice,
      ProPlanType.yearly => l10n.proPlanYearlyPrice,
      ProPlanType.lifetime => l10n.proPlanLifetimePrice,
    };
  }

  Future<void> _handlePurchase(
    BuildContext context,
    SubscriptionProvider subscriptionProvider,
  ) async {
    final l10n = AppLocalizations.of(context);
    final result = await subscriptionProvider.purchasePlan(_selectedPlan);
    if (!context.mounted) return;

    if (result.success) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(l10n.proPurchaseSuccessMessage)),
        );
      Navigator.of(context).pop(true);
      return;
    }

    if (result.isCancelled) return;

    final message = result.isStoreUnavailable
        ? l10n.proStoreUnavailableMessage
        : l10n.proPurchaseFailedMessage;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _handleRestore(
    BuildContext context,
    SubscriptionProvider subscriptionProvider,
  ) async {
    final l10n = AppLocalizations.of(context);
    final result = await subscriptionProvider.restorePurchases();
    if (!context.mounted) return;

    final String message;
    if (result.success) {
      message = l10n.proRestoreSuccessMessage;
    } else if (result.isStoreUnavailable) {
      message = l10n.proStoreUnavailableMessage;
    } else {
      message = l10n.proRestoreEmptyMessage;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));

    if (result.success) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final subscriptionProvider = context.watch<SubscriptionProvider>();
    final isPro = subscriptionProvider.isPro;
    final isLoading = subscriptionProvider.isLoading;

    final benefits = [
      (
        ProFeature.cloudSync,
        Icons.cloud_done_outlined,
        l10n.proBenefitCloudSync,
      ),
      (
        ProFeature.calendarSync,
        Icons.calendar_month_outlined,
        l10n.proBenefitCalendar,
      ),
      (
        ProFeature.appLock,
        Icons.lock_outline_rounded,
        l10n.proBenefitAppLock,
      ),
      (
        ProFeature.unlimitedProjects,
        Icons.folder_copy_outlined,
        l10n.proBenefitProjectsCsv,
      ),
      (
        ProFeature.customThemes,
        Icons.contrast_rounded,
        l10n.proBenefitCustomization,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.close,
          onPressed: () => Navigator.of(context).pop(),
          style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
          icon: const Icon(Icons.close_rounded),
        ),
        title: Text(l10n.proBrandTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            _PaywallHeader(
              isPro: isPro,
              activePlan: subscriptionProvider.activePlan,
            ),
            if (!isPro && _contextualFeatureCopy(l10n) != null) ...[
              const SizedBox(height: 12),
              _ContextualFeatureBanner(
                key: const ValueKey('paywall_context_banner'),
                message: _contextualFeatureCopy(l10n)!,
              ),
            ],
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colorScheme.outline, width: 1),
              ),
              child: Column(
                children: [
                  for (var i = 0; i < benefits.length; i++) ...[
                    _BenefitRow(
                      icon: benefits[i].$2,
                      text: benefits[i].$3,
                      highlighted: _isBenefitHighlighted(benefits[i].$1),
                    ),
                    if (i < benefits.length - 1) ...[
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                    ],
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            _PlanOptionCard(
              key: const ValueKey('pro_plan_card_yearly'),
              title: l10n.proPlanYearlyTitle,
              price: _resolvePrice(
                ProPlanType.yearly,
                subscriptionProvider,
                l10n,
              ),
              subtitle: l10n.proPlanYearlySavings,
              badge: l10n.proPlanYearlyBadge,
              isSelected: _selectedPlan == ProPlanType.yearly,
              onTap: isLoading
                  ? null
                  : () => setState(() => _selectedPlan = ProPlanType.yearly),
            ),
            const SizedBox(height: 10),
            _PlanOptionCard(
              key: const ValueKey('pro_plan_card_monthly'),
              title: l10n.proPlanMonthlyTitle,
              price: _resolvePrice(
                ProPlanType.monthly,
                subscriptionProvider,
                l10n,
              ),
              isSelected: _selectedPlan == ProPlanType.monthly,
              onTap: isLoading
                  ? null
                  : () => setState(() => _selectedPlan = ProPlanType.monthly),
            ),
            const SizedBox(height: 10),
            _PlanOptionCard(
              key: const ValueKey('pro_plan_card_lifetime'),
              title: l10n.proPlanLifetimeTitle,
              price: _resolvePrice(
                ProPlanType.lifetime,
                subscriptionProvider,
                l10n,
              ),
              badge: l10n.proPlanLifetimeBadge,
              isSelected: _selectedPlan == ProPlanType.lifetime,
              onTap: isLoading
                  ? null
                  : () => setState(() => _selectedPlan = ProPlanType.lifetime),
            ),
            const SizedBox(height: 22),
            SizedBox(
              height: 52,
              child: FilledButton(
                key: const ValueKey('paywall_continue_button'),
                onPressed: (isLoading || isPro)
                    ? null
                    : () => _handlePurchase(context, subscriptionProvider),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: isLoading
                    ? ZettaskSpinnerArc(
                        size: 20,
                        color: colorScheme.onPrimary,
                      )
                    : Text(
                        isPro
                            ? l10n.proAlreadyActiveButton
                            : l10n.proContinueButton,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: isPro
                              ? colorScheme.onSurfaceVariant
                              : colorScheme.onPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: TextButton(
                key: const ValueKey('paywall_restore_button'),
                onPressed: isLoading
                    ? null
                    : () => _handleRestore(context, subscriptionProvider),
                style: TextButton.styleFrom(
                  minimumSize: const Size(48, 48),
                ),
                child: Text(l10n.proRestorePurchasesButton),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.proLegalFootnote,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaywallHeader extends StatelessWidget {
  const _PaywallHeader({
    required this.isPro,
    required this.activePlan,
  });

  final bool isPro;
  final ProPlanType? activePlan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPro ? colorScheme.primary : colorScheme.outline,
          width: isPro ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isPro ? Icons.verified_rounded : Icons.workspace_premium_outlined,
              size: 22,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        l10n.proBrandTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 19,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const ProBadge(filled: true),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  isPro && activePlan != null
                      ? l10n.proActiveBannerTitle(
                          localizedProPlanName(activePlan!, l10n),
                        )
                      : l10n.proPaywallSubtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isPro
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                    fontWeight: isPro ? FontWeight.w600 : FontWeight.w400,
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

class _ContextualFeatureBanner extends StatelessWidget {
  const _ContextualFeatureBanner({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Icon(
              Icons.info_outline_rounded,
              size: 16,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  const _BenefitRow({
    required this.icon,
    required this.text,
    this.highlighted = false,
  });

  final IconData icon;
  final String text;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: highlighted
                ? colorScheme.primaryContainer
                : colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 17,
            color: highlighted
                ? colorScheme.onPrimaryContainer
                : colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 13.5,
              fontWeight: highlighted ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _PlanOptionCard extends StatelessWidget {
  const _PlanOptionCard({
    super.key,
    required this.title,
    required this.price,
    required this.isSelected,
    required this.onTap,
    this.subtitle,
    this.badge,
  });

  final String title;
  final String price;
  final String? subtitle;
  final String? badge;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: isSelected
          ? colorScheme.primaryContainer.withValues(alpha: 0.35)
          : colorScheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 68),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? colorScheme.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: colorScheme.onPrimary,
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (badge != null) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                badge!,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10.5,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  price,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
