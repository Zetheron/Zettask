import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/theme/app_theme.dart';

const String prefThemeModeKey = 'zettask_theme_mode';
const String prefThemePresetKey = 'zettask_theme_preset';

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
  })  : _themeMode = initialThemeMode,
        _preset = initialPreset;

  ThemeMode _themeMode;
  AppThemePreset _preset;

  ThemeMode get themeMode => _themeMode;
  AppThemePreset get preset => _preset;

  ThemeData get lightTheme => AppTheme.lightThemeFor(_preset);
  ThemeData get darkTheme => AppTheme.darkThemeFor(_preset);

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
