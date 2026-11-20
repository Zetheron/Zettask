import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/theme/app_theme.dart';
import '../services/home_widget_service.dart';

const String prefThemeModeKey = 'zettask_theme_mode';
const String prefThemePresetKey = 'zettask_theme_preset';
const String prefThemeAmoledKey = 'zettask_theme_amoled';
const String prefThemeAccentKey = 'zettask_theme_accent';
const String prefWidgetStyleKey = 'zettask_widget_style';

ThemeMode parseThemeMode(String? rawValue) {
  return switch (rawValue) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}

String serializeThemeMode(ThemeMode mode) {
  return switch (mode) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  };
}

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({
    ThemeMode initialThemeMode = ThemeMode.system,
    AppThemePreset initialPreset = AppThemePreset.defaultIndigo,
    bool initialAmoledBlack = false,
    ProAccentColor initialAccentColor = ProAccentColor.monochrome,
    WidgetStyle initialWidgetStyle = WidgetStyle.standard,
    this.homeWidgetStyleService,
  })  : _themeMode = initialThemeMode,
        _preset = initialPreset,
        _isAmoledBlack = initialAmoledBlack,
        _accentColor = initialAccentColor,
        _widgetStyle = initialWidgetStyle;

  final HomeWidgetStyleService? homeWidgetStyleService;

  ThemeMode _themeMode;
  AppThemePreset _preset;
  bool _isAmoledBlack;
  ProAccentColor _accentColor;
  WidgetStyle _widgetStyle;

  ThemeMode get themeMode => _themeMode;
  AppThemePreset get preset => _preset;
  bool get isAmoledBlack => _isAmoledBlack;
  ProAccentColor get accentColor => _accentColor;
  WidgetStyle get widgetStyle => _widgetStyle;

  ThemeData get lightTheme => AppTheme.lightThemeFor(
        _preset,
        accentColor: _accentColor,
      );

  ThemeData get darkTheme => AppTheme.darkThemeFor(
        _preset,
        amoled: _isAmoledBlack,
        accentColor: _accentColor,
      );

  String themeModeLabel(Brightness platformBrightness) {
    return switch (_themeMode) {
      ThemeMode.light => 'Terang',
      ThemeMode.dark => 'Gelap',
      ThemeMode.system =>
        platformBrightness == Brightness.dark
            ? 'Sistem (Gelap)'
            : 'Sistem (Terang)',
    };
  }

  Future<void> loadSavedPreferences({
    bool restoreMode = true,
    bool restorePreset = true,
    bool restoreProOptions = true,
    bool isPro = true,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var changed = false;
      if (restoreMode) {
        final savedMode = parseThemeMode(prefs.getString(prefThemeModeKey));
        if (savedMode != _themeMode) {
          _themeMode = savedMode;
          changed = true;
        }
      }
      if (restorePreset) {
        final savedPreset =
            AppThemePreset.fromStorage(prefs.getString(prefThemePresetKey));
        if (savedPreset != _preset) {
          _preset = savedPreset;
          changed = true;
        }
      }
      if (restoreProOptions) {
        final savedAmoled = prefs.getBool(prefThemeAmoledKey) ?? false;
        final savedAccent =
            ProAccentColor.fromStorage(prefs.getString(prefThemeAccentKey));
        final savedWidgetStyle =
            WidgetStyle.fromStorage(prefs.getString(prefWidgetStyleKey));

        final effectiveAmoled = isPro ? savedAmoled : false;
        final effectiveAccent = isPro ? savedAccent : ProAccentColor.monochrome;
        final effectiveWidgetStyle =
            isPro ? savedWidgetStyle : WidgetStyle.standard;

        if (effectiveAmoled != _isAmoledBlack) {
          _isAmoledBlack = effectiveAmoled;
          changed = true;
        }
        if (effectiveAccent != _accentColor) {
          _accentColor = effectiveAccent;
          changed = true;
        }
        if (effectiveWidgetStyle != _widgetStyle) {
          _widgetStyle = effectiveWidgetStyle;
          changed = true;
        }
      }
      if (changed) notifyListeners();
    } catch (_) {
      // Ignore storage errors so default theme remains active.
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefThemeModeKey, serializeThemeMode(mode));
    } catch (_) {
      // Ignore storage write failures.
    }
  }

  Future<void> setPreset(AppThemePreset preset) async {
    if (_preset == preset) return;
    _preset = preset;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefThemePresetKey, preset.key);
    } catch (_) {
      // Ignore storage write failures.
    }
  }

  Future<void> setAmoledBlack(bool enabled) async {
    if (_isAmoledBlack == enabled) return;
    _isAmoledBlack = enabled;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(prefThemeAmoledKey, enabled);
    } catch (_) {
      // Ignore storage write failures.
    }
  }

  Future<void> setAccentColor(ProAccentColor accent) async {
    if (_accentColor == accent) return;
    _accentColor = accent;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefThemeAccentKey, accent.key);
    } catch (_) {
      // Ignore storage write failures.
    }
  }

  Future<void> setWidgetStyle(WidgetStyle style) async {
    if (_widgetStyle == style) return;
    _widgetStyle = style;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefWidgetStyleKey, style.key);
    } catch (_) {
      // Ignore storage write failures.
    }
    try {
      await homeWidgetStyleService?.updateWidgetStyle(style.key);
    } catch (_) {
      // Ignore platform widget sync errors.
    }
  }

  Future<void> enforceProEntitlement(bool isPro) async {
    if (isPro) return;
    await revertProCustomizations();
  }

  Future<void> revertProCustomizations() async {
    final needsRevert = _isAmoledBlack ||
        _accentColor != ProAccentColor.monochrome ||
        _widgetStyle != WidgetStyle.standard;

    _isAmoledBlack = false;
    _accentColor = ProAccentColor.monochrome;
    _widgetStyle = WidgetStyle.standard;

    if (needsRevert) {
      notifyListeners();
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(prefThemeAmoledKey, false);
      await prefs.setString(
        prefThemeAccentKey,
        ProAccentColor.monochrome.key,
      );
      await prefs.setString(prefWidgetStyleKey, WidgetStyle.standard.key);
    } catch (_) {
      // Ignore storage write failures.
    }

    if (needsRevert) {
      try {
        await homeWidgetStyleService?.updateWidgetStyle(
          WidgetStyle.standard.key,
        );
      } catch (_) {
        // Ignore platform widget sync errors.
      }
    }
  }

  Future<void> toggleThemeMode() async {
    final ThemeMode nextMode;
    if (_themeMode == ThemeMode.dark) {
      nextMode = ThemeMode.light;
    } else if (_themeMode == ThemeMode.light) {
      nextMode = ThemeMode.dark;
    } else {
      final platformBrightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      nextMode = platformBrightness == Brightness.dark
          ? ThemeMode.light
          : ThemeMode.dark;
    }
    await setThemeMode(nextMode);
  }
}
