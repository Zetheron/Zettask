import 'package:flutter/foundation.dart';

import '../models/subscription_model.dart';
import '../services/subscription_service.dart';

class SubscriptionProvider extends ChangeNotifier {
  SubscriptionProvider({
    SubscriptionService? subscriptionService,
    DateTime Function()? nowProvider,
    this.onProStatusChanged,
  })  : _service = subscriptionService ?? SubscriptionService(),
        _nowProvider = nowProvider ?? DateTime.now;

  final SubscriptionService _service;
  final DateTime Function() _nowProvider;
  final ValueChanged<bool>? onProStatusChanged;

  SubscriptionState _state = const SubscriptionState.free();
  List<ProProductOffering> _offerings = PlayBillingService.defaultOfferings;
  bool _initialized = false;

  SubscriptionState get state => _state;
  bool get isPro => _state.isPro;
  ProPlanType? get activePlan => _state.activePlan;
  DateTime? get expiresAt => _state.expiresAt;
  bool get isLoading => _state.isLoading;
  bool get isStoreAvailable => _state.isStoreAvailable;
  bool get isInitialized => _initialized;
  List<ProProductOffering> get offerings => List.unmodifiable(_offerings);

  /// Phase 1 entitlement check:
  /// New Pro customization features require Pro; legacy features stay unlocked
  /// until Phase 2 feature gating.
  bool hasAccess(ProFeature feature) {
    return switch (feature) {
      ProFeature.customThemes || ProFeature.widgetStyles => _state.isPro,
      ProFeature.cloudSync ||
      ProFeature.calendarSync ||
      ProFeature.appLock ||
      ProFeature.csvExport ||
      ProFeature.unlimitedProjects =>
        true,
    };
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
    onProStatusChanged?.call(_state.isPro);
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
    if (!_state.isPro) return false;
    if (!_state.isExpiredAt(_nowProvider())) return false;

    await _service.clearCachedEntitlement();
    _state = _state.copyWith(
      isPro: false,
      clearActivePlan: true,
      clearExpiresAt: true,
    );
    notifyListeners();
    onProStatusChanged?.call(false);
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
    onProStatusChanged?.call(isPro);
  }
}
