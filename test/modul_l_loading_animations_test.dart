import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
import 'package:zettask/core/theme/app_theme.dart';
import 'package:zettask/widgets/zettask_loaders.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  final themeCases = <(String, ThemeData)>[
    ('Light', AppTheme.lightTheme),
    ('Dark', AppTheme.darkTheme),
    (
      'AMOLED Pure Black + Sage',
      AppTheme.darkThemeFor(
        AppThemePreset.defaultIndigo,
        amoled: true,
        accentColor: ProAccentColor.sage,
      ),
    ),
  ];

  test(
    'ZettaskSkeletonShimmer.resolveColors memilih palet gelap khusus AMOLED (#121212 <-> #1F1F1F)',
    () {
      final amoledTheme = AppTheme.darkThemeFor(
        AppThemePreset.defaultIndigo,
        amoled: true,
      );
      final darkTheme = AppTheme.darkTheme;
      final lightTheme = AppTheme.lightTheme;

      final amoledColors = ZettaskSkeletonShimmer.resolveColors(amoledTheme);
      expect(amoledColors.base, const Color(0xFF121212));
      expect(amoledColors.highlight, const Color(0xFF1F1F1F));

      final darkColors = ZettaskSkeletonShimmer.resolveColors(darkTheme);
      expect(darkColors.base, isNot(equals(amoledColors.base)));

      final lightColors = ZettaskSkeletonShimmer.resolveColors(lightTheme);
      expect(lightColors.base.computeLuminance(), greaterThan(0.7));
    },
  );

  for (final (label, theme) in themeCases) {
    testWidgets(
      'Ke-4 komponen loader ter-render halus tanpa error pada tema $label dan aman saat dispose',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: theme,
            home: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  ZettaskIndeterminateBar(),
                  SizedBox(height: 12),
                  Center(child: ZettaskSpinnerArc(size: 28)),
                  SizedBox(height: 12),
                  Center(child: ZettaskTextShimmer(text: 'Menyinkronkan...')),
                  SizedBox(height: 12),
                  Expanded(child: ZettaskTaskListSkeleton(itemCount: 3)),
                ],
              ),
            ),
          ),
        );

        // Jalankan beberapa frame animasi untuk memastikan CustomPainter & ShaderMask aman
        await tester.pump(const Duration(milliseconds: 250));
        await tester.pump(const Duration(milliseconds: 500));

        expect(find.byType(ZettaskSpinnerArc), findsOneWidget);
        expect(find.byType(ZettaskIndeterminateBar), findsOneWidget);
        expect(find.byType(ZettaskTextShimmer), findsOneWidget);
        expect(find.byType(ZettaskTaskListSkeleton), findsOneWidget);
        expect(find.byType(ZettaskSkeletonShimmer), findsNWidgets(3));
        expect(find.text('Menyinkronkan...'), findsOneWidget);

        // Unmount untuk memastikan seluruh AnimationController di-dispose tanpa leak
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpAndSettle();
      },
    );
  }

  testWidgets(
    'Seluruh loader mematuhi MediaQuery.disableAnimations: true sehingga pumpAndSettle selesai tanpa timeout',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp(
            theme: AppTheme.darkThemeFor(
              AppThemePreset.defaultIndigo,
              amoled: true,
              accentColor: ProAccentColor.amber,
            ),
            home: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  ZettaskIndeterminateBar(),
                  SizedBox(height: 12),
                  Center(child: ZettaskSpinnerArc(size: 20)),
                  SizedBox(height: 12),
                  Center(child: ZettaskTextShimmer(text: 'Memproses...')),
                  SizedBox(height: 12),
                  Expanded(child: ZettaskTaskListSkeleton(itemCount: 4)),
                ],
              ),
            ),
          ),
        ),
      );

      // Tidak akan pernah timeout karena seluruh controller berhenti saat disableAnimations == true
      await tester.pumpAndSettle();

      expect(find.byType(ZettaskSpinnerArc), findsOneWidget);
      expect(find.byType(ZettaskIndeterminateBar), findsOneWidget);
      expect(find.byType(ZettaskTextShimmer), findsOneWidget);
      expect(find.byType(ZettaskTaskListSkeleton), findsOneWidget);
      expect(find.byType(ZettaskSkeletonShimmer), findsNWidgets(4));
      expect(find.text('Memproses...'), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpAndSettle();
    },
  );
}
