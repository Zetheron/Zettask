import 'package:dynamic_color/dynamic_color.dart';
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
import 'package:zettask/screens/theme_settings_screen.dart';
import 'package:zettask/services/subscription_service.dart';

class _ProAlwaysBillingService implements BillingService {
  const _ProAlwaysBillingService();

  @override
  Future<bool> isStoreAvailable() async => true;

  @override
  Future<List<ProProductOffering>> queryProductOfferings() async =>
      PlayBillingService.defaultOfferings;

  @override
  Future<BillingActionResult> purchase(ProPlanType plan) async {
    return const BillingActionResult(
      success: true,
      plan: ProPlanType.lifetime,
    );
  }

  @override
  Future<BillingActionResult> restorePurchases() async {
    return const BillingActionResult(
      success: true,
      plan: ProPlanType.lifetime,
    );
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
    'Persistensi use_dynamic_color di SharedPreferences (default false, toggle true & false)',
    () async {
      final provider = ThemeProvider();
      expect(provider.useDynamicColor, isFalse);

      await provider.setUseDynamicColor(true);
      expect(provider.useDynamicColor, isTrue);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool(prefUseDynamicColorKey), isTrue);
      expect(prefUseDynamicColorKey, 'use_dynamic_color');

      final restored = ThemeProvider();
      expect(restored.useDynamicColor, isFalse);
      await restored.loadSavedPreferences();
      expect(restored.useDynamicColor, isTrue);

      await restored.setUseDynamicColor(false);
      expect(restored.useDynamicColor, isFalse);
      expect(prefs.getBool(prefUseDynamicColorKey), isFalse);
    },
  );

  test(
    'Fallback aman ke tema & aksen manual saat lightDynamic/darkDynamic bernilai null',
    () async {
      final provider = ThemeProvider(
        initialPreset: AppThemePreset.forest,
        initialAccentColor: ProAccentColor.sage,
        initialAmoledBlack: true,
      );
      await provider.setUseDynamicColor(true);

      final lightFallback = provider.buildLightTheme(dynamicColorScheme: null);
      final darkFallback = provider.buildDarkTheme(dynamicColorScheme: null);

      expect(
        lightFallback.colorScheme.primary,
        ProAccentColor.sage.tokens.primaryLight,
      );
      expect(lightFallback.scaffoldBackgroundColor, AppTheme.lightBackground);
      expect(
        darkFallback.colorScheme.primary,
        ProAccentColor.sage.tokens.primaryDark,
      );
      expect(darkFallback.scaffoldBackgroundColor, AppTheme.amoledBackground);

      // Saat useDynamicColor == false, skema dinamis yang tersedia tetap diabaikan.
      await provider.setUseDynamicColor(false);
      final mockLightDynamic = ColorScheme.fromSeed(
        seedColor: const Color(0xFF006D77),
        brightness: Brightness.light,
      );
      final manualLight =
          provider.buildLightTheme(dynamicColorScheme: mockLightDynamic);
      expect(
        manualLight.colorScheme.primary,
        ProAccentColor.sage.tokens.primaryLight,
      );
    },
  );

  test(
    'Mode Light, Dark, dan AMOLED Pure Black menerapkan skema dinamis harmonized dengan benar',
    () async {
      final mockLightDynamic = ColorScheme.fromSeed(
        seedColor: const Color(0xFF0077B6),
        brightness: Brightness.light,
      );
      final mockDarkDynamic = ColorScheme.fromSeed(
        seedColor: const Color(0xFF0077B6),
        brightness: Brightness.dark,
      );
      final expectedLight = mockLightDynamic.harmonized();
      final expectedDark = mockDarkDynamic.harmonized();

      final provider = ThemeProvider();
      await provider.setUseDynamicColor(true);

      final dynamicLight =
          provider.buildLightTheme(dynamicColorScheme: mockLightDynamic);
      expect(dynamicLight.colorScheme.primary, expectedLight.primary);
      expect(dynamicLight.colorScheme.secondary, expectedLight.secondary);
      expect(dynamicLight.cardTheme.elevation, 0);

      final dynamicDark =
          provider.buildDarkTheme(dynamicColorScheme: mockDarkDynamic);
      expect(dynamicDark.colorScheme.primary, expectedDark.primary);
      expect(dynamicDark.colorScheme.secondary, expectedDark.secondary);
      expect(dynamicDark.scaffoldBackgroundColor, expectedDark.surface);

      // Aktifkan AMOLED Pure Black: kanvas wajib tetap #000000, kartu #0A0A0A, border #1E1E1E.
      await provider.setAmoledBlack(true);
      final amoledDynamic =
          provider.buildDarkTheme(dynamicColorScheme: mockDarkDynamic);

      expect(amoledDynamic.scaffoldBackgroundColor, const Color(0xFF000000));
      expect(amoledDynamic.colorScheme.surface, const Color(0xFF0A0A0A));
      expect(amoledDynamic.colorScheme.outline, const Color(0xFF1E1E1E));
      expect(amoledDynamic.dividerTheme.color, const Color(0xFF1E1E1E));
      expect(amoledDynamic.colorScheme.primary, expectedDark.primary);
      expect(amoledDynamic.colorScheme.onPrimary, expectedDark.onPrimary);
      expect(
        amoledDynamic.colorScheme.primaryContainer,
        expectedDark.primaryContainer,
      );
      expect(
        amoledDynamic.colorScheme.onPrimaryContainer,
        expectedDark.onPrimaryContainer,
      );
      expect(amoledDynamic.colorScheme.secondary, expectedDark.secondary);
      expect(
        amoledDynamic.colorScheme.secondaryContainer,
        expectedDark.secondaryContainer,
      );
    },
  );

  test(
    'Memilih salah satu dari 5 warna aksen manual otomatis menonaktifkan useDynamicColor',
    () async {
      final provider = ThemeProvider();
      final prefs = await SharedPreferences.getInstance();

      for (final accent in ProAccentColor.values) {
        await provider.setUseDynamicColor(true);
        expect(provider.useDynamicColor, isTrue);
        expect(prefs.getBool(prefUseDynamicColorKey), isTrue);

        await provider.setAccentColor(accent);
        expect(provider.accentColor, accent);
        expect(provider.useDynamicColor, isFalse);
        expect(prefs.getBool(prefUseDynamicColorKey), isFalse);
      }
    },
  );

  testWidgets(
    'ThemeSettingsScreen menampilkan sakelar Material You dan menonaktifkannya saat aksen manual dipilih',
    (WidgetTester tester) async {
      final themeProvider = ThemeProvider(initialThemeMode: ThemeMode.dark);
      final subscriptionProvider = SubscriptionProvider(
        subscriptionService: SubscriptionService(
          billingService: const _ProAlwaysBillingService(),
        ),
      );
      await subscriptionProvider.initialize();
      await subscriptionProvider.purchasePlan(ProPlanType.lifetime);

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
            ChangeNotifierProvider<SubscriptionProvider>.value(
              value: subscriptionProvider,
            ),
          ],
          child: DynamicColorBuilder(
            builder: (lightDynamic, darkDynamic) {
              return DynamicColorScope(
                lightDynamic: lightDynamic,
                darkDynamic: darkDynamic,
                child: MaterialApp(
                  locale: const Locale('id'),
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates: zettaskLocalizationsDelegates,
                  theme: themeProvider.buildLightTheme(
                    dynamicColorScheme: lightDynamic,
                  ),
                  darkTheme: themeProvider.buildDarkTheme(
                    dynamicColorScheme: darkDynamic,
                  ),
                  themeMode: themeProvider.themeMode,
                  home: const ThemeSettingsScreen(),
                ),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      final listScroll = find.byType(Scrollable).first;
      final dynamicSwitch = find.byKey(const ValueKey('dynamic_color_switch'));
      await tester.scrollUntilVisible(
        dynamicSwitch,
        200,
        scrollable: listScroll,
      );
      await tester.pumpAndSettle();

      expect(find.text('Material You (Warna Wallpaper)'), findsOneWidget);
      expect(
        find.text(
          'Sesuaikan warna aksen dengan wallpaper perangkat (Android 12+)',
        ),
        findsOneWidget,
      );
      expect(themeProvider.useDynamicColor, isFalse);

      await tester.tap(dynamicSwitch);
      await tester.pumpAndSettle();
      expect(themeProvider.useDynamicColor, isTrue);

      // Pilih warna aksen manual -> otomatis matikan Material You.
      final indigoChip = find.byKey(const ValueKey('accent_chip_indigo'));
      await tester.scrollUntilVisible(
        indigoChip,
        150,
        scrollable: listScroll,
      );
      await tester.pumpAndSettle();
      await tester.tap(indigoChip);
      await tester.pumpAndSettle();

      expect(themeProvider.accentColor, ProAccentColor.indigo);
      expect(themeProvider.useDynamicColor, isFalse);
    },
  );
}
