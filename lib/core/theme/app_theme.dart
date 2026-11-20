import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

import '../../models/task_model.dart';

class TaskTagColor {
  const TaskTagColor({
    required this.label,
    required this.hex,
    required this.lightColor,
    required this.darkColor,
  });

  final String label;
  final String hex;
  final Color lightColor;
  final Color darkColor;

  Color resolve(Brightness brightness) {
    return brightness == Brightness.dark ? darkColor : lightColor;
  }
}

class ThemePaletteTokens {
  const ThemePaletteTokens({
    required this.primaryLight,
    required this.onPrimaryLight,
    required this.primaryContainerLight,
    required this.onPrimaryContainerLight,
    required this.secondaryLight,
    required this.onSecondaryLight,
    required this.secondaryContainerLight,
    required this.onSecondaryContainerLight,
    required this.primaryDark,
    required this.onPrimaryDark,
    required this.primaryContainerDark,
    required this.onPrimaryContainerDark,
    required this.secondaryDark,
    required this.onSecondaryDark,
    required this.secondaryContainerDark,
    required this.onSecondaryContainerDark,
  });

  final Color primaryLight;
  final Color onPrimaryLight;
  final Color primaryContainerLight;
  final Color onPrimaryContainerLight;
  final Color secondaryLight;
  final Color onSecondaryLight;
  final Color secondaryContainerLight;
  final Color onSecondaryContainerLight;

  final Color primaryDark;
  final Color onPrimaryDark;
  final Color primaryContainerDark;
  final Color onPrimaryContainerDark;
  final Color secondaryDark;
  final Color onSecondaryDark;
  final Color secondaryContainerDark;
  final Color onSecondaryContainerDark;
}

enum AppThemePreset {
  defaultIndigo(
    key: 'default',
    label: 'Default',
    description: 'Indigo & slate',
    tokens: ThemePaletteTokens(
      primaryLight: Color(0xFF3730A3),
      onPrimaryLight: Color(0xFFFFFFFF),
      primaryContainerLight: Color(0xFFE0E7FF),
      onPrimaryContainerLight: Color(0xFF1E1B4B),
      secondaryLight: Color(0xFF475569),
      onSecondaryLight: Color(0xFFFFFFFF),
      secondaryContainerLight: Color(0xFFF1F5F9),
      onSecondaryContainerLight: Color(0xFF1E293B),
      primaryDark: Color(0xFF818CF8),
      onPrimaryDark: Color(0xFF1E1B4B),
      primaryContainerDark: Color(0xFF312E81),
      onPrimaryContainerDark: Color(0xFFE0E7FF),
      secondaryDark: Color(0xFF94A3B8),
      onSecondaryDark: Color(0xFF0F172A),
      secondaryContainerDark: Color(0xFF1E293B),
      onSecondaryContainerDark: Color(0xFFE2E8F0),
    ),
  ),
  ocean(
    key: 'ocean',
    label: 'Ocean',
    description: 'Biru tenang',
    tokens: ThemePaletteTokens(
      primaryLight: Color(0xFF0369A1),
      onPrimaryLight: Color(0xFFFFFFFF),
      primaryContainerLight: Color(0xFFE0F2FE),
      onPrimaryContainerLight: Color(0xFF0C4A6E),
      secondaryLight: Color(0xFF0284C7),
      onSecondaryLight: Color(0xFFFFFFFF),
      secondaryContainerLight: Color(0xFFF0F9FF),
      onSecondaryContainerLight: Color(0xFF075985),
      primaryDark: Color(0xFF38BDF8),
      onPrimaryDark: Color(0xFF082F49),
      primaryContainerDark: Color(0xFF0C4A6E),
      onPrimaryContainerDark: Color(0xFFE0F2FE),
      secondaryDark: Color(0xFF7DD3FC),
      onSecondaryDark: Color(0xFF082F49),
      secondaryContainerDark: Color(0xFF075985),
      onSecondaryContainerDark: Color(0xFFE0F2FE),
    ),
  ),
  forest(
    key: 'forest',
    label: 'Forest',
    description: 'Hijau sage & emerald',
    tokens: ThemePaletteTokens(
      primaryLight: Color(0xFF047857),
      onPrimaryLight: Color(0xFFFFFFFF),
      primaryContainerLight: Color(0xFFD1FAE5),
      onPrimaryContainerLight: Color(0xFF064E3B),
      secondaryLight: Color(0xFF0D9488),
      onSecondaryLight: Color(0xFFFFFFFF),
      secondaryContainerLight: Color(0xFFCCFBF1),
      onSecondaryContainerLight: Color(0xFF115E59),
      primaryDark: Color(0xFF34D399),
      onPrimaryDark: Color(0xFF022C22),
      primaryContainerDark: Color(0xFF064E3B),
      onPrimaryContainerDark: Color(0xFFD1FAE5),
      secondaryDark: Color(0xFF2DD4BF),
      onSecondaryDark: Color(0xFF042F2E),
      secondaryContainerDark: Color(0xFF134E4A),
      onSecondaryContainerDark: Color(0xFFCCFBF1),
    ),
  ),
  terracotta(
    key: 'terracotta',
    label: 'Terracotta',
    description: 'Oranye bata hangat',
    tokens: ThemePaletteTokens(
      primaryLight: Color(0xFFC2410C),
      onPrimaryLight: Color(0xFFFFFFFF),
      primaryContainerLight: Color(0xFFFFEDD5),
      onPrimaryContainerLight: Color(0xFF7C2D12),
      secondaryLight: Color(0xFFB45309),
      onSecondaryLight: Color(0xFFFFFFFF),
      secondaryContainerLight: Color(0xFFFEF3C7),
      onSecondaryContainerLight: Color(0xFF78350F),
      primaryDark: Color(0xFFFB923C),
      onPrimaryDark: Color(0xFF431407),
      primaryContainerDark: Color(0xFF7C2D12),
      onPrimaryContainerDark: Color(0xFFFFEDD5),
      secondaryDark: Color(0xFFFBBF24),
      onSecondaryDark: Color(0xFF451A03),
      secondaryContainerDark: Color(0xFF78350F),
      onSecondaryContainerDark: Color(0xFFFEF3C7),
    ),
  ),
  plum(
    key: 'plum',
    label: 'Plum',
    description: 'Ungu kalem',
    tokens: ThemePaletteTokens(
      primaryLight: Color(0xFF6D28D9),
      onPrimaryLight: Color(0xFFFFFFFF),
      primaryContainerLight: Color(0xFFEDE9FE),
      onPrimaryContainerLight: Color(0xFF4C1D95),
      secondaryLight: Color(0xFF7E22CE),
      onSecondaryLight: Color(0xFFFFFFFF),
      secondaryContainerLight: Color(0xFFF3E8FF),
      onSecondaryContainerLight: Color(0xFF581C87),
      primaryDark: Color(0xFFA78BFA),
      onPrimaryDark: Color(0xFF2E1065),
      primaryContainerDark: Color(0xFF4C1D95),
      onPrimaryContainerDark: Color(0xFFEDE9FE),
      secondaryDark: Color(0xFFC084FC),
      onSecondaryDark: Color(0xFF3B0764),
      secondaryContainerDark: Color(0xFF581C87),
      onSecondaryContainerDark: Color(0xFFF3E8FF),
    ),
  ),
  monochrome(
    key: 'monochrome',
    label: 'Monochrome',
    description: 'Arang & hitam minimalis',
    tokens: ThemePaletteTokens(
      primaryLight: Color(0xFF18181B),
      onPrimaryLight: Color(0xFFFAFAFA),
      primaryContainerLight: Color(0xFFE4E4E7),
      onPrimaryContainerLight: Color(0xFF18181B),
      secondaryLight: Color(0xFF52525B),
      onSecondaryLight: Color(0xFFFAFAFA),
      secondaryContainerLight: Color(0xFFF4F4F5),
      onSecondaryContainerLight: Color(0xFF27272A),
      primaryDark: Color(0xFFFAFAFA),
      onPrimaryDark: Color(0xFF0A0A0A),
      primaryContainerDark: Color(0xFF27272A),
      onPrimaryContainerDark: Color(0xFFFAFAFA),
      secondaryDark: Color(0xFFA1A1AA),
      onSecondaryDark: Color(0xFF09090B),
      secondaryContainerDark: Color(0xFF1F1F23),
      onSecondaryContainerDark: Color(0xFFE4E4E7),
    ),
  );

  const AppThemePreset({
    required this.key,
    required this.label,
    required this.description,
    required this.tokens,
  });

  final String key;
  final String label;
  final String description;
  final ThemePaletteTokens tokens;

  Color previewPrimary(Brightness brightness) {
    return brightness == Brightness.dark
        ? tokens.primaryDark
        : tokens.primaryLight;
  }

  Color previewContainer(Brightness brightness) {
    return brightness == Brightness.dark
        ? tokens.primaryContainerDark
        : tokens.primaryContainerLight;
  }

  static AppThemePreset fromStorage(String? rawKey) {
    for (final preset in AppThemePreset.values) {
      if (preset.key == rawKey) return preset;
    }
    return AppThemePreset.defaultIndigo;
  }
}

class AppTheme {
  AppTheme._();

  static const Color primaryLight = Color(0xFF3730A3);
  static const Color secondaryLight = Color(0xFF475569);
  static const Color primaryDark = Color(0xFF818CF8);
  static const Color secondaryDark = Color(0xFF94A3B8);

  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF5F5F4);
  static const Color lightBorder = Color(0xFFE7E5E4);
  static const Color lightTextPrimary = Color(0xFF18181B);
  static const Color lightTextSecondary = Color(0xFF57534E);

  static const Color darkBackground = Color(0xFF0A0A0A);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkSurfaceVariant = Color(0xFF1C1C1C);
  static const Color darkBorder = Color(0xFF262626);
  static const Color darkTextPrimary = Color(0xFFFAFAFA);
  static const Color darkTextSecondary = Color(0xFFA3A3A3);

  static const Color errorLight = Color(0xFFDC2626);
  static const Color errorDark = Color(0xFFF87171);
  static const Color successLight = Color(0xFF059669);
  static const Color successDark = Color(0xFF34D399);
  static const Color warningLight = Color(0xFFD97706);
  static const Color warningDark = Color(0xFFFBBF24);

  static const List<TaskTagColor> tagPalette = [
    TaskTagColor(
      label: 'Teal',
      hex: '#0D9488',
      lightColor: Color(0xFF0D9488),
      darkColor: Color(0xFF2DD4BF),
    ),
    TaskTagColor(
      label: 'Biru',
      hex: '#2563EB',
      lightColor: Color(0xFF2563EB),
      darkColor: Color(0xFF60A5FA),
    ),
    TaskTagColor(
      label: 'Amber',
      hex: '#D97706',
      lightColor: Color(0xFFD97706),
      darkColor: Color(0xFFFBBF24),
    ),
    TaskTagColor(
      label: 'Mawar',
      hex: '#E11D48',
      lightColor: Color(0xFFE11D48),
      darkColor: Color(0xFFFB7185),
    ),
    TaskTagColor(
      label: 'Hijau',
      hex: '#059669',
      lightColor: Color(0xFF059669),
      darkColor: Color(0xFF34D399),
    ),
    TaskTagColor(
      label: 'Abu',
      hex: '#64748B',
      lightColor: Color(0xFF64748B),
      darkColor: Color(0xFF94A3B8),
    ),
  ];

  static Color resolveTagColor(String hex, Brightness brightness) {
    final normalized = hex.trim().toUpperCase();
    for (final tag in tagPalette) {
      if (tag.hex.toUpperCase() == normalized) {
        return tag.resolve(brightness);
      }
    }

    final cleanHex = normalized.replaceFirst('#', '');
    if (cleanHex.length == 6) {
      final parsed = int.tryParse('FF$cleanHex', radix: 16);
      if (parsed != null) {
        return Color(parsed);
      }
    }

    return brightness == Brightness.dark ? primaryDark : primaryLight;
  }

  static Color priorityColor(TaskPriority priority, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return switch (priority) {
      TaskPriority.low =>
        isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
      TaskPriority.medium => isDark ? warningDark : warningLight,
      TaskPriority.high => isDark ? errorDark : errorLight,
    };
  }

  static Color successColor(Brightness brightness) {
    return brightness == Brightness.dark ? successDark : successLight;
  }

  static ThemeData get lightTheme =>
      lightThemeFor(AppThemePreset.defaultIndigo);

  static ThemeData get darkTheme => darkThemeFor(AppThemePreset.defaultIndigo);

  static ThemeData lightThemeFor(AppThemePreset preset) {
    final t = preset.tokens;
    final colorScheme = ColorScheme.light(
      primary: t.primaryLight,
      onPrimary: t.onPrimaryLight,
      primaryContainer: t.primaryContainerLight,
      onPrimaryContainer: t.onPrimaryContainerLight,
      secondary: t.secondaryLight,
      onSecondary: t.onSecondaryLight,
      secondaryContainer: t.secondaryContainerLight,
      onSecondaryContainer: t.onSecondaryContainerLight,
      surface: lightSurface,
      onSurface: lightTextPrimary,
      onSurfaceVariant: lightTextSecondary,
      surfaceContainerHighest: lightSurfaceVariant,
      outline: lightBorder,
      outlineVariant: lightBorder,
      error: errorLight,
      onError: Colors.white,
    );

    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme(
      ThemeData.light().textTheme,
    ).apply(
      bodyColor: lightTextPrimary,
      displayColor: lightTextPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: lightBackground,
      textTheme: _buildTextTheme(baseTextTheme, lightTextSecondary),
      appBarTheme: AppBarTheme(
        backgroundColor: lightBackground,
        foregroundColor: lightTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: lightTextPrimary,
          letterSpacing: -0.4,
        ),
      ),
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: lightBorder, width: 1),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: t.primaryLight,
        foregroundColor: t.onPrimaryLight,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: lightSurface,
        selectedColor: colorScheme.primaryContainer,
        side: const BorderSide(color: lightBorder, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: lightTextPrimary,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        side: const BorderSide(color: lightTextSecondary, width: 1.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: lightBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: t.primaryLight, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorLight, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorLight, width: 1.5),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: lightSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: lightTextPrimary,
        contentTextStyle: GoogleFonts.plusJakartaSans(
          color: lightBackground,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        actionTextColor: t.primaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: lightBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData darkThemeFor(AppThemePreset preset) {
    final t = preset.tokens;
    final colorScheme = ColorScheme.dark(
      primary: t.primaryDark,
      onPrimary: t.onPrimaryDark,
      primaryContainer: t.primaryContainerDark,
      onPrimaryContainer: t.onPrimaryContainerDark,
      secondary: t.secondaryDark,
      onSecondary: t.onSecondaryDark,
      secondaryContainer: t.secondaryContainerDark,
      onSecondaryContainer: t.onSecondaryContainerDark,
      surface: darkSurface,
      onSurface: darkTextPrimary,
      onSurfaceVariant: darkTextSecondary,
      surfaceContainerHighest: darkSurfaceVariant,
      outline: darkBorder,
      outlineVariant: darkBorder,
      error: errorDark,
      onError: const Color(0xFF450A0A),
    );

    final baseTextTheme = GoogleFonts.plusJakartaSansTextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: darkTextPrimary,
      displayColor: darkTextPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: darkBackground,
      textTheme: _buildTextTheme(baseTextTheme, darkTextSecondary),
      appBarTheme: AppBarTheme(
        backgroundColor: darkBackground,
        foregroundColor: darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: darkTextPrimary,
          letterSpacing: -0.4,
        ),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: darkBorder, width: 1),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: t.primaryDark,
        foregroundColor: t.onPrimaryDark,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: darkSurface,
        selectedColor: colorScheme.primaryContainer,
        side: const BorderSide(color: darkBorder, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        side: const BorderSide(color: darkTextSecondary, width: 1.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: darkBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: t.primaryDark, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorDark, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorDark, width: 1.5),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: darkSurface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: darkSurfaceVariant,
        contentTextStyle: GoogleFonts.plusJakartaSans(
          color: darkTextPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        actionTextColor: t.primaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: darkBorder, width: 1),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: darkBorder,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base, Color secondaryColor) {
    return base.copyWith(
      headlineSmall: base.headlineSmall?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        height: 1.45,
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: secondaryColor,
        height: 1.4,
      ),
      labelMedium: base.labelMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
