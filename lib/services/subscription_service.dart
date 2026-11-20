import 'package:shared_preferences/shared_preferences.dart';

import '../models/subscription_model.dart';

const String prefProIsActiveKey = 'zettask_pro_is_active';
const String prefProActivePlanKey = 'zettask_pro_active_plan';
const String prefProExpiresAtKey = 'zettask_pro_expires_at';

const String proProductIdMonthly = 'zettask_pro_monthly';
const String proProductIdYearly = 'zettask_pro_yearly';
const String proProductIdLifetime = 'zettask_pro_lifetime';

abstract class BillingService {
  Future<bool> isStoreAvailable();

  Future<List<ProProductOffering>> queryProductOfferings();

  Future<BillingActionResult> purchase(ProPlanType plan);

  Future<BillingActionResult> restorePurchases();
}

/// Google Play Billing adapter prepared with Zettask Pro product IDs.
/// Returns graceful non-throwing unavailable responses until Play Console
/// billing products are connected in production.
class PlayBillingService implements BillingService {
  const PlayBillingService();

  static const Set<String> configuredProductIds = {
    proProductIdMonthly,
    proProductIdYearly,
    proProductIdLifetime,
  };

  static const List<ProProductOffering> defaultOfferings = [
    ProProductOffering(
      plan: ProPlanType.monthly,
      productId: proProductIdMonthly,
      isFallbackPrice: true,
    ),
    ProProductOffering(
      plan: ProPlanType.yearly,
      productId: proProductIdYearly,
      isFallbackPrice: true,
    ),
    ProProductOffering(
      plan: ProPlanType.lifetime,
      productId: proProductIdLifetime,
      isFallbackPrice: true,
    ),
  ];

  @override
  Future<bool> isStoreAvailable() async => false;

  @override
  Future<List<ProProductOffering>> queryProductOfferings() async {
    return defaultOfferings;
  }

  @override
  Future<BillingActionResult> purchase(ProPlanType plan) async {
    return const BillingActionResult(
      success: false,
      isStoreUnavailable: true,
      errorCode: 'store_unavailable',
    );
  }

  @override
  Future<BillingActionResult> restorePurchases() async {
    return const BillingActionResult(
      success: false,
      isStoreUnavailable: true,
      errorCode: 'store_unavailable',
    );
  }
}

class SubscriptionService {
  SubscriptionService({
    BillingService? billingService,
  }) : _billingService = billingService ?? const PlayBillingService();

  final BillingService _billingService;

  Future<SubscriptionState> loadCachedEntitlement({
    DateTime? now,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedIsPro = prefs.getBool(prefProIsActiveKey) ?? false;
      final cachedPlan =
          ProPlanType.fromStorage(prefs.getString(prefProActivePlanKey));
      final rawExpires = prefs.getString(prefProExpiresAtKey);
      final cachedExpiresAt =
          rawExpires != null ? DateTime.tryParse(rawExpires) : null;

      if (!cachedIsPro) {
        return const SubscriptionState.free();
      }

      final referenceNow = now ?? DateTime.now();
      final candidate = SubscriptionState(
        isPro: true,
        activePlan: cachedPlan ?? ProPlanType.yearly,
        expiresAt: cachedPlan == ProPlanType.lifetime ? null : cachedExpiresAt,
      );

      if (candidate.isExpiredAt(referenceNow)) {
        await clearCachedEntitlement();
        return const SubscriptionState.free();
      }

      return candidate;
    } catch (_) {
      return const SubscriptionState.free();
    }
  }

  Future<void> saveEntitlement({
    required bool isPro,
    ProPlanType? plan,
    DateTime? expiresAt,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(prefProIsActiveKey, isPro);
      if (isPro && plan != null) {
        await prefs.setString(prefProActivePlanKey, plan.key);
      } else {
        await prefs.remove(prefProActivePlanKey);
      }

      if (isPro && plan != ProPlanType.lifetime && expiresAt != null) {
        await prefs.setString(
          prefProExpiresAtKey,
          expiresAt.toIso8601String(),
        );
      } else {
        await prefs.remove(prefProExpiresAtKey);
      }
    } catch (_) {
      // Preserve in-memory state if local preference write fails.
    }
  }

  Future<void> clearCachedEntitlement() async {
    await saveEntitlement(isPro: false);
  }

  Future<bool> checkStoreAvailability() async {
    try {
      return await _billingService.isStoreAvailable();
    } catch (_) {
      return false;
    }
  }

  Future<List<ProProductOffering>> loadProductOfferings() async {
    try {
      final offerings = await _billingService.queryProductOfferings();
      if (offerings.isNotEmpty) return offerings;
    } catch (_) {
      // Fall back to default product definitions.
    }
    return PlayBillingService.defaultOfferings;
  }

  Future<BillingActionResult> purchasePlan(ProPlanType plan) async {
    try {
      return await _billingService.purchase(plan);
    } catch (_) {
      return const BillingActionResult(
        success: false,
        errorCode: 'purchase_failed',
      );
    }
  }

  Future<BillingActionResult> restorePurchases() async {
    try {
      return await _billingService.restorePurchases();
    } catch (_) {
      return const BillingActionResult(
        success: false,
        errorCode: 'restore_failed',
      );
    }
  }
}
