import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zettask/core/theme/app_theme.dart';
import 'package:zettask/l10n/app_localizations.dart';
import 'package:zettask/l10n/l10n_helpers.dart';
import 'package:zettask/models/subscription_model.dart';
import 'package:zettask/providers/subscription_provider.dart';
import 'package:zettask/providers/theme_provider.dart';
import 'package:zettask/screens/pro_paywall_screen.dart';
import 'package:zettask/screens/theme_settings_screen.dart';
import 'package:zettask/services/home_widget_service.dart';
import 'package:zettask/services/subscription_service.dart';

class _FakeBillingService implements BillingService {
  _FakeBillingService({
    this.storeAvailable = true,
    this.purchaseResult,
  });

  bool storeAvailable;
  BillingActionResult? purchaseResult;
  ProPlanType? lastPurchasedPlan;
  int restoreCallCount = 0;

  @override
  Future<bool> isStoreAvailable() async => storeAvailable;

  @override
  Future<List<ProProductOffering>> queryProductOfferings() async {
    return PlayBillingService.defaultOfferings;
  }

  @override
  Future<BillingActionResult> purchase(ProPlanType plan) async {
    lastPurchasedPlan = plan;
    return purchaseResult ??
        BillingActionResult(
          success: true,
          plan: plan,
          expiresAt: plan == ProPlanType.lifetime
              ? null
              : DateTime(2027, 11, 20),
        );
  }

  @override
  Future<BillingActionResult> restorePurchases() async {
    restoreCallCount++;
    return const BillingActionResult(
      success: false,
      errorCode: 'no_purchases',
    );
  }
}

class _FakeWidgetStyleService implements HomeWidgetStyleService {
  final List<String> recordedStyles = [];

  @override
  Future<void> updateWidgetStyle(String styleKey) async {
    recordedStyles.add(styleKey);
  }
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting('id_ID');
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    final dispatcher = TestWidgetsFlutterBinding.instance.platformDispatcher;
    dispatcher.localeTestValue = const Locale('id', 'ID');
    dispatcher.localesTestValue = const [Locale('id', 'ID')];
  });

  tearDown(() {
    final dispatcher = TestWidgetsFlutterBinding.instance.platformDispatcher;
    dispatcher.clearLocaleTestValue();
    dispatcher.clearLocalesTestValue();
  });

  test(
    'SubscriptionProvider mengelola transisi Free -> Pro -> Expired/Revert serta persistensi offline',
    () async {
      var now = DateTime(2026, 11, 20, 12, 0);
      final billing = _FakeBillingService(
        storeAvailable: true,
        purchaseResult: BillingActionResult(
          success: true,
          plan: ProPlanType.monthly,
          expiresAt: DateTime(2026, 12, 20, 12, 0),
        ),
      );
      final statusEvents = <bool>[];
      final provider = SubscriptionProvider(
        subscriptionService: SubscriptionService(billingService: billing),
        nowProvider: () => now,
        onProStatusChanged: statusEvents.add,
      );

      await provider.initialize();
      expect(provider.isPro, isFalse);
      expect(provider.activePlan, isNull);
      // Tahap 1: fitur lama tetap terbuka, fitur kustomisasi baru butuh Pro
      expect(provider.hasAccess(ProFeature.cloudSync), isTrue);
      expect(provider.hasAccess(ProFeature.calendarSync), isTrue);
      expect(provider.hasAccess(ProFeature.customThemes), isFalse);
      expect(provider.hasAccess(ProFeature.widgetStyles), isFalse);

      // Beli paket Bulanan -> transisi ke Pro + tersimpan di SharedPreferences
      final purchaseRes = await provider.purchasePlan(ProPlanType.monthly);
      expect(purchaseRes.success, isTrue);
      expect(billing.lastPurchasedPlan, ProPlanType.monthly);
      expect(provider.isPro, isTrue);
      expect(provider.activePlan, ProPlanType.monthly);
      expect(provider.hasAccess(ProFeature.customThemes), isTrue);
      expect(provider.hasAccess(ProFeature.widgetStyles), isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(prefProIsActiveKey), isTrue);
      expect(prefs.getString(prefProActivePlanKey), 'monthly');

      // Instance baru tetap bisa membaca status Pro saat offline
      final offlineProvider = SubscriptionProvider(
        subscriptionService: SubscriptionService(
          billingService: const PlayBillingService(),
        ),
        nowProvider: () => now,
      );
      await offlineProvider.initialize();
      expect(offlineProvider.isPro, isTrue);
      expect(offlineProvider.activePlan, ProPlanType.monthly);

      // Waktu maju melewati expiresAt -> checkExpiration revert aman ke Free
      now = DateTime(2026, 12, 21, 0, 0);
      final expired = await provider.checkExpiration();
      expect(expired, isTrue);
      expect(provider.isPro, isFalse);
      expect(provider.activePlan, isNull);
      expect(provider.expiresAt, isNull);
      expect(prefs.getBool(prefProIsActiveKey), isFalse);
      expect(statusEvents.last, isFalse);
    },
  );

  test(
    'ThemeProvider mengaktifkan AMOLED, aksen kustom, gaya widget, lalu fallback aman saat Pro berakhir',
    () async {
      final widgetStyleService = _FakeWidgetStyleService();
      final themeProvider = ThemeProvider(
        initialThemeMode: ThemeMode.dark,
        homeWidgetStyleService: widgetStyleService,
      );

      await themeProvider.setAmoledBlack(true);
      await themeProvider.setAccentColor(ProAccentColor.sage);
      await themeProvider.setWidgetStyle(WidgetStyle.amoled);

      expect(themeProvider.isAmoledBlack, isTrue);
      expect(themeProvider.accentColor, ProAccentColor.sage);
      expect(themeProvider.widgetStyle, WidgetStyle.amoled);
      expect(
        themeProvider.darkTheme.scaffoldBackgroundColor,
        AppTheme.amoledBackground,
      );
      expect(
        themeProvider.darkTheme.colorScheme.surface,
        AppTheme.amoledSurface,
      );
      expect(
        themeProvider.darkTheme.colorScheme.outline,
        AppTheme.amoledBorder,
      );
      expect(
        themeProvider.darkTheme.colorScheme.primary,
        ProAccentColor.sage.tokens.primaryDark,
      );
      expect(widgetStyleService.recordedStyles, contains('amoled'));

      // Pro berakhir -> kembali otomatis ke Monochrome, AMOLED off, dan widget standard
      await themeProvider.enforceProEntitlement(false);

      expect(themeProvider.isAmoledBlack, isFalse);
      expect(themeProvider.accentColor, ProAccentColor.monochrome);
      expect(themeProvider.widgetStyle, WidgetStyle.standard);
      expect(
        themeProvider.darkTheme.scaffoldBackgroundColor,
        AppTheme.darkBackground,
      );
      expect(widgetStyleService.recordedStyles.last, 'standard');

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(prefThemeAmoledKey), isFalse);
      expect(prefs.getString(prefThemeAccentKey), 'monochrome');
      expect(prefs.getString(prefWidgetStyleKey), 'standard');
    },
  );

  testWidgets(
    'ProPaywallScreen menampilkan 3 paket, tombol Pulihkan Pembelian, dan menangani store belum siap tanpa crash',
    (WidgetTester tester) async {
      final subscriptionProvider = SubscriptionProvider(
        subscriptionService: SubscriptionService(
          billingService: const PlayBillingService(),
        ),
      );
      await subscriptionProvider.initialize();

      await tester.pumpWidget(
        ChangeNotifierProvider<SubscriptionProvider>.value(
          value: subscriptionProvider,
          child: MaterialApp(
            locale: const Locale('id'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: zettaskLocalizationsDelegates,
            theme: AppTheme.lightTheme,
            home: const ProPaywallScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // 3 paket tampil lengkap beserta badge & harga fallback lokal
      final paywallScroll = find.byType(Scrollable).first;
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('pro_plan_card_lifetime')),
        200,
        scrollable: paywallScroll,
      );
      expect(find.byKey(const ValueKey('pro_plan_card_yearly')), findsOneWidget);
      expect(find.byKey(const ValueKey('pro_plan_card_monthly')), findsOneWidget);
      expect(
        find.byKey(const ValueKey('pro_plan_card_lifetime')),
        findsOneWidget,
      );
      expect(find.text('Tahunan'), findsOneWidget);
      expect(find.text('Paling Hemat'), findsOneWidget);
      expect(find.text('Bulanan'), findsOneWidget);
      expect(find.text('Seumur Hidup'), findsOneWidget);
      expect(find.text('Sekali Bayar'), findsOneWidget);

      // Pilih paket Bulanan lalu ketuk Lanjutkan saat store belum tersedia -> tampil SnackBar informatif
      await tester.ensureVisible(
        find.byKey(const ValueKey('pro_plan_card_monthly')),
      );
      await tester.tap(find.byKey(const ValueKey('pro_plan_card_monthly')));
      await tester.pumpAndSettle();

      final continueButton = find.byKey(const ValueKey('paywall_continue_button'));
      await tester.scrollUntilVisible(
        continueButton,
        200,
        scrollable: paywallScroll,
      );
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Pembelian Google Play belum tersedia di perangkat ini. Coba lagi setelah terhubung ke Google Play.',
        ),
        findsOneWidget,
      );

      // Tombol Pulihkan Pembelian tampil dan tidak crash saat diketuk
      final restoreButton = find.byKey(const ValueKey('paywall_restore_button'));
      await tester.scrollUntilVisible(
        restoreButton,
        200,
        scrollable: paywallScroll,
      );
      expect(restoreButton, findsOneWidget);
      await tester.tap(restoreButton);
      await tester.pumpAndSettle();
      expect(find.byType(ProPaywallScreen), findsOneWidget);
    },
  );

  testWidgets(
    'ThemeSettingsScreen membuka ProPaywallScreen saat pengguna Gratis mengetuk AMOLED/Aksen Pro, dan menerapkan langsung saat Pro',
    (WidgetTester tester) async {
      final themeProvider = ThemeProvider(initialThemeMode: ThemeMode.dark);
      final subscriptionProvider = SubscriptionProvider(
        subscriptionService: SubscriptionService(
          billingService: const PlayBillingService(),
        ),
        onProStatusChanged: (isPro) {
          if (!isPro) themeProvider.enforceProEntitlement(false);
        },
      );
      await subscriptionProvider.initialize();

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
            ChangeNotifierProvider<SubscriptionProvider>.value(
              value: subscriptionProvider,
            ),
          ],
          child: MaterialApp(
            locale: const Locale('id'),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: zettaskLocalizationsDelegates,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: const ThemeSettingsScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Pengguna Gratis mengetuk AMOLED -> membuka ProPaywallScreen & AMOLED tetap nonaktif
      final amoledSwitch = find.byKey(const ValueKey('amoled_black_switch'));
      await tester.scrollUntilVisible(
        amoledSwitch,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(amoledSwitch);
      await tester.pumpAndSettle();

      expect(find.byType(ProPaywallScreen), findsOneWidget);
      expect(themeProvider.isAmoledBlack, isFalse);

      // Tutup paywall -> aktifkan Simulasi Pro -> ketuk AMOLED & Sage berhasil diterapkan
      await tester.tap(find.byTooltip('Tutup'));
      await tester.pumpAndSettle();

      await subscriptionProvider.debugSetProStatus(
        true,
        plan: ProPlanType.yearly,
      );
      await tester.pumpAndSettle();

      await tester.tap(amoledSwitch);
      await tester.pumpAndSettle();
      expect(themeProvider.isAmoledBlack, isTrue);

      final sageChip = find.byKey(const ValueKey('accent_chip_sage'));
      await tester.scrollUntilVisible(
        sageChip,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(sageChip);
      await tester.pumpAndSettle();
      expect(themeProvider.accentColor, ProAccentColor.sage);

      // Cabut status Pro -> otomatis kembali ke Monochrome & AMOLED off
      await subscriptionProvider.debugSetProStatus(false);
      await tester.pumpAndSettle();
      expect(themeProvider.isAmoledBlack, isFalse);
      expect(themeProvider.accentColor, ProAccentColor.monochrome);
    },
  );
}
