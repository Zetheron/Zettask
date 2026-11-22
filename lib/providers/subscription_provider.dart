import 'package:flutter/foundation.dart';

import '../models/subscription_model.dart';
import '../services/subscription_service.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({
    SubscriptionService? subscriptionService,
    DateTime Function()? nowProvider,
    this.onProStatusChanged,
    bool? enableProPaywall,
  })  : _service = subscriptionService ?? SubscriptionService(),
        _nowProvider = nowProvider ?? DateTime.now,
        _enableProPaywallInstance = enableProPaywall;

  /// Centralized feature flag for Zettask Pro monetization.
  /// Defaults to `false` for the 100% free v1.0 release while preserving all
  /// Pro/Paywall/Billing modules for future activation.
  static const bool defaultEnableProPaywall = false;

  static bool _enableProPaywallOverride = defaultEnableProPaywall;

  static bool get enableProPaywall => _enableProPaywallOverride;

  @visibleForTesting
  static set debugEnableProPaywallOverride(bool value) {
    _enableProPaywallOverride = value;
  }

  @visibleForTesting
  static void resetEnableProPaywallOverride() {
    _enableProPaywallOverride = defaultEnableProPaywall;
  }

  static const int freeProjectLimit = 3;

  final SubscriptionService _service;
  final DateTime Function() _nowProvider;
  final ValueChanged<bool>? onProStatusChanged;
  final bool? _enableProPaywallInstance;

  SubscriptionState _state = const SubscriptionState.free();
  List<ProProductOffering> _offerings = PlayBillingService.defaultOfferings;
  bool _initialized = false;

  bool get isPaywallEnabled =>
      _enableProPaywallInstance ?? SubscriptionProvider.enableProPaywall;

  SubscriptionState get state => _state;
  bool get isPro => !isPaywallEnabled || _state.isPro;
  ProPlanType? get activePlan => _state.activePlan;
  DateTime? get expiresAt => _state.expiresAt;
  bool get isLoading => _state.isLoading;
  bool get isStoreAvailable => _state.isStoreAvailable;
  bool get isInitialized => _initialized;
  List<ProProductOffering> get offerings => List.unmodifiable(_offerings);

  bool hasAccess(ProFeature feature) {
    if (!isPaywallEnabled) return true;
    return switch (feature) {
      ProFeature.cloudSync ||
      ProFeature.calendarSync ||
      ProFeature.appLock ||
      ProFeature.csvExport ||
      ProFeature.unlimitedProjects ||
      ProFeature.customThemes ||
      ProFeature.widgetStyles =>
        _state.isPro,
    };
  }

  bool canCreateProject(int currentProjectCount) {
    if (hasAccess(ProFeature.unlimitedProjects)) return true;
    return currentProjectCount < freeProjectLimit;
  }

  ProProductOffering offeringFor(ProPlanType plan) {
    for (final item in _offerings) {
      if (item.plan == plan) return item;
    }
    return ProProductOffering(
      plan: plan,
      productId: plan.productId,
      isFallbackPrice: true,
    );
  }

  Future<void> initialize() async {
    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final cached = await _service.loadCachedEntitlement(now: _nowProvider());
    final storeAvailable = await _service.checkStoreAvailability();
    final loadedOfferings = await _service.loadProductOfferings();

    _offerings = loadedOfferings;
    _state = cached.copyWith(
      isLoading: false,
      isStoreAvailable: storeAvailable,
    );
    _initialized = true;
    notifyListeners();
    onProStatusChanged?.call(isPro);
  }

  Future<BillingActionResult> purchasePlan(ProPlanType plan) async {
    if (_state.isLoading) {
      return const BillingActionResult(
        success: false,
        errorCode: 'busy',
      );
    }

    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _service.purchasePlan(plan);
    if (result.success) {
      final resolvedPlan = result.plan ?? plan;
      final resolvedExpiry = resolvedPlan == ProPlanType.lifetime
          ? null
          : result.expiresAt;

      await _service.saveEntitlement(
        isPro: true,
        plan: resolvedPlan,
        expiresAt: resolvedExpiry,
      );

      _state = _state.copyWith(
        isPro: true,
        activePlan: resolvedPlan,
        expiresAt: resolvedExpiry,
        clearExpiresAt: resolvedExpiry == null,
        isLoading: false,
        isStoreAvailable: true,
      );
      notifyListeners();
      onProStatusChanged?.call(true);
      return result;
    }

    _state = _state.copyWith(
      isLoading: false,
      isStoreAvailable:
          result.isStoreUnavailable ? false : _state.isStoreAvailable,
    );
    notifyListeners();
    return result;
  }

  Future<BillingActionResult> restorePurchases() async {
    if (_state.isLoading) {
      return const BillingActionResult(
        success: false,
        errorCode: 'busy',
      );
    }

    _state = _state.copyWith(isLoading: true);
    notifyListeners();

    final result = await _service.restorePurchases();
    if (result.success) {
      final resolvedPlan = result.plan ?? ProPlanType.yearly;
      final resolvedExpiry = resolvedPlan == ProPlanType.lifetime
          ? null
          : result.expiresAt;

      await _service.saveEntitlement(
        isPro: true,
        plan: resolvedPlan,
        expiresAt: resolvedExpiry,
      );

      _state = _state.copyWith(
        isPro: true,
        activePlan: resolvedPlan,
        expiresAt: resolvedExpiry,
        clearExpiresAt: resolvedExpiry == null,
        isLoading: false,
        isStoreAvailable: true,
      );
      notifyListeners();
      onProStatusChanged?.call(true);
      return result;
    }

    _state = _state.copyWith(
      isLoading: false,
      isStoreAvailable:
          result.isStoreUnavailable ? false : _state.isStoreAvailable,
    );
    notifyListeners();
    return result;
  }

  Future<bool> checkExpiration() async {
    if (!isPaywallEnabled) return false;
    if (!_state.isPro) return false;
    if (!_state.isExpiredAt(_nowProvider())) return false;

    await _service.clearCachedEntitlement();
    _state = _state.copyWith(
      isPro: false,
      clearActivePlan: true,
      clearExpiresAt: true,
    );
    notifyListeners();
    onProStatusChanged?.call(isPro);
    return true;
  }

  Future<void> debugSetProStatus(
    bool isPro, {
    ProPlanType? plan,
    DateTime? expiresAt,
  }) async {
    if (!kDebugMode) return;

    final resolvedPlan = isPro ? (plan ?? ProPlanType.yearly) : null;
    final resolvedExpiry =
        isPro && resolvedPlan != ProPlanType.lifetime ? expiresAt : null;

    await _service.saveEntitlement(
      isPro: isPro,
      plan: resolvedPlan,
      expiresAt: resolvedExpiry,
    );

    _state = _state.copyWith(
      isPro: isPro,
      activePlan: resolvedPlan,
      expiresAt: resolvedExpiry,
      clearActivePlan: !isPro,
      clearExpiresAt: !isPro || resolvedExpiry == null,
      isLoading: false,
    );
    notifyListeners();
    onProStatusChanged?.call(this.isPro);
  }
}
