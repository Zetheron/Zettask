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
import 'package:zettask/services/subscription_service.dart';
import 'package:zettask/widgets/zettask_motion.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting('id_ID');
  });

  setUp(() {
    SubscriptionProvider.debugEnableProPaywallOverride = true;
    SharedPreferences.setMockInitialValues({});
    final dispatcher = TestWidgetsFlutterBinding.instance.platformDispatcher;
    dispatcher.localeTestValue = const Locale('id', 'ID');
    dispatcher.localesTestValue = const [Locale('id', 'ID')];
  });

  tearDown(() {
    SubscriptionProvider.resetEnableProPaywallOverride();
    final dispatcher = TestWidgetsFlutterBinding.instance.platformDispatcher;
    dispatcher.clearLocaleTestValue();
    dispatcher.clearLocalesTestValue();
  });

  testWidgets(
    'ZettaskPinnedHeaderDelegate tetap menempel di atas viewport CustomScrollView saat digulir',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkThemeFor(
            AppThemePreset.defaultIndigo,
            amoled: true,
          ),
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverMainAxisGroup(
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: ZettaskPinnedHeaderDelegate(
                        height: 48,
                        child: const Text('Hari Ini · 21 Nov'),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => SizedBox(
                          height: 72,
                          child: Text('Tugas #$index'),
                        ),
                        childCount: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final initialTop = tester.getTopLeft(find.text('Hari Ini · 21 Nov')).dy;
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -450));
      await tester.pumpAndSettle();

      // Header tetap ter-render dan menempel di posisi puncak viewport
      expect(find.text('Hari Ini · 21 Nov'), findsOneWidget);
      final pinnedTop = tester.getTopLeft(find.text('Hari Ini · 21 Nov')).dy;
      expect(pinnedTop, closeTo(initialTop, 1.0));
    },
  );

  testWidgets(
    'ZettaskLineReveal menyelesaikan animasi staggered dengan bersih, aman di-dispose, dan statis saat disableAnimations: true',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: Column(
              children: List.generate(
                10,
                (i) => ZettaskLineReveal(
                  index: i,
                  child: Text('Baris #$i'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      for (var i = 0; i < 10; i++) {
        expect(find.text('Baris #$i'), findsOneWidget);
      }

      // Unmount di tengah/setelah animasi -> nol leak
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();

      // Mode disableAnimations: true -> langsung tampil statis tanpa menunggu
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp(
            theme: AppTheme.darkTheme,
            home: const Scaffold(
              body: ZettaskLineReveal(
                index: 3,
                child: Text('Statis Langsung'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Statis Langsung'), findsOneWidget);
    },
  );

  testWidgets(
    'ZettaskStackingCard aman saat ScrollController belum terpasang maupun saat digulir',
    (WidgetTester tester) async {
      final detachedController = ScrollController();
      addTearDown(detachedController.dispose);

      // Controller belum terpasang ke Scrollable mana pun -> tidak melempar exception
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            body: ZettaskStackingCard(
              scrollController: detachedController,
              child: const SizedBox(height: 100, child: Text('Kartu Terpisah')),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Kartu Terpisah'), findsOneWidget);

      // Controller terpasang ke ListView -> aman saat digulir
      final activeController = ScrollController();
      addTearDown(activeController.dispose);

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.darkThemeFor(
            AppThemePreset.defaultIndigo,
            amoled: true,
          ),
          home: Scaffold(
            body: ListView(
              controller: activeController,
              children: List.generate(
                10,
                (i) => Padding(
                  padding: const EdgeInsets.all(12),
                  child: ZettaskStackingCard(
                    scrollController: activeController,
                    child: SizedBox(
                      height: 120,
                      child: Text('Kartu Statistik $i'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.drag(find.byType(ListView), const Offset(0, -350));
      await tester.pumpAndSettle();
      expect(find.text('Kartu Statistik 4'), findsOneWidget);
    },
  );

  testWidgets(
    'ZettaskFocusFrameSlider dapat digeser/diketuk dan menjaga gating Pro pada ThemeSettingsScreen',
    (WidgetTester tester) async {
      final themeProvider = ThemeProvider(initialThemeMode: ThemeMode.dark);
      final subscriptionProvider = SubscriptionProvider(
        subscriptionService: SubscriptionService(
          billingService: const PlayBillingService(),
        ),
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

      final sliderFinder = find.byKey(
        const ValueKey('widget_style_focus_slider'),
      );
      await tester.scrollUntilVisible(
        sliderFinder,
        250,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.ensureVisible(sliderFinder);
      await tester.pumpAndSettle();

      expect(sliderFinder, findsOneWidget);
      expect(find.byKey(const ValueKey('widget_style_standard')), findsOneWidget);

      // Geser slider ke kartu AMOLED (Pro) -> pengguna Gratis tetap di Standard hingga memilih
      await tester.drag(sliderFinder, const Offset(-350, 0));
      await tester.pumpAndSettle();
      expect(themeProvider.widgetStyle, WidgetStyle.standard);

      // Ketuk kartu AMOLED saat Gratis -> diarahkan ke ProPaywallScreen
      final amoledCard = find.byKey(const ValueKey('widget_style_amoled'));
      expect(amoledCard, findsOneWidget);
      await tester.tap(amoledCard);
      await tester.pumpAndSettle();
      expect(find.byType(ProPaywallScreen), findsOneWidget);

      // Tutup paywall & aktifkan Pro -> ketuk AMOLED berhasil menerapkan WidgetStyle.amoled
      await tester.tap(find.byTooltip('Tutup'));
      await tester.pumpAndSettle();

      await subscriptionProvider.debugSetProStatus(
        true,
        plan: ProPlanType.yearly,
      );
      await tester.pumpAndSettle();

      await tester.tap(amoledCard);
      await tester.pumpAndSettle();
      expect(find.byType(ProPaywallScreen), findsNothing);
      expect(themeProvider.widgetStyle, WidgetStyle.amoled);
    },
  );
}
