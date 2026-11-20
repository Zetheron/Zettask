enum ProPlanType {
  monthly(
    key: 'monthly',
    productId: 'zettask_pro_monthly',
  ),
  yearly(
    key: 'yearly',
    productId: 'zettask_pro_yearly',
  ),
  lifetime(
    key: 'lifetime',
    productId: 'zettask_pro_lifetime',
  );

  const ProPlanType({
    required this.key,
    required this.productId,
  });

  final String key;
  final String productId;

  static ProPlanType? fromStorage(String? rawValue) {
    for (final plan in ProPlanType.values) {
      if (plan.key == rawValue || plan.productId == rawValue) {
        return plan;
      }
    }
    return null;
  }
}

enum ProFeature {
  cloudSync,
  calendarSync,
  appLock,
  csvExport,
  unlimitedProjects,
  customThemes,
  widgetStyles,
}

class ProProductOffering {
  const ProProductOffering({
    required this.plan,
    required this.productId,
    this.formattedPrice,
    this.isFallbackPrice = true,
  });

  final ProPlanType plan;
  final String productId;
  final String? formattedPrice;
  final bool isFallbackPrice;
}

class BillingActionResult {
  const BillingActionResult({
    required this.success,
    this.isStoreUnavailable = false,
    this.isCancelled = false,
    this.plan,
    this.expiresAt,
    this.errorCode,
  });

  final bool success;
  final bool isStoreUnavailable;
  final bool isCancelled;
  final ProPlanType? plan;
  final DateTime? expiresAt;
  final String? errorCode;
}

class SubscriptionState {
  const SubscriptionState({
    this.isPro = false,
    this.activePlan,
    this.expiresAt,
    this.isLoading = false,
    this.isStoreAvailable = false,
  });

  const SubscriptionState.free({
    this.isLoading = false,
    this.isStoreAvailable = false,
  })  : isPro = false,
        activePlan = null,
        expiresAt = null;

  final bool isPro;
  final ProPlanType? activePlan;
  final DateTime? expiresAt;
  final bool isLoading;
  final bool isStoreAvailable;

  bool isExpiredAt(DateTime now) {
    if (!isPro) return false;
    if (activePlan == ProPlanType.lifetime) return false;
    final expiry = expiresAt;
    if (expiry == null) return false;
    return !expiry.isAfter(now);
  }

  SubscriptionState copyWith({
    bool? isPro,
    ProPlanType? activePlan,
    DateTime? expiresAt,
    bool? isLoading,
    bool? isStoreAvailable,
    bool clearActivePlan = false,
    bool clearExpiresAt = false,
  }) {
    return SubscriptionState(
      isPro: isPro ?? this.isPro,
      activePlan: clearActivePlan ? null : (activePlan ?? this.activePlan),
      expiresAt: clearExpiresAt ? null : (expiresAt ?? this.expiresAt),
      isLoading: isLoading ?? this.isLoading,
      isStoreAvailable: isStoreAvailable ?? this.isStoreAvailable,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SubscriptionState &&
        other.isPro == isPro &&
        other.activePlan == activePlan &&
        other.expiresAt == expiresAt &&
        other.isLoading == isLoading &&
        other.isStoreAvailable == isStoreAvailable;
  }

  @override
  int get hashCode => Object.hash(
        isPro,
        activePlan,
        expiresAt,
        isLoading,
        isStoreAvailable,
      );
}
