import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';

const String prefLocaleKey = 'zettask_locale';

class SupportedLanguageOption {
  const SupportedLanguageOption({
    required this.code,
    required this.locale,
    required this.label,
  });

  final String code;
  final Locale locale;
  final String label;
}

class LocaleProvider extends ChangeNotifier {
  LocaleProvider({
    Locale? initialLocale,
    this.onLocaleChanged,
  }) : _currentLocale = initialLocale;

  final Future<void> Function(Locale effectiveLocale)? onLocaleChanged;

  static const List<SupportedLanguageOption> supportedLanguages = [
    SupportedLanguageOption(
      code: 'ar',
      locale: Locale('ar'),
      label: 'عربي (Arabic)',
    ),
    SupportedLanguageOption(
      code: 'de',
      locale: Locale('de'),
      label: 'Deutsch (German)',
    ),
    SupportedLanguageOption(
      code: 'en',
      locale: Locale('en'),
      label: 'English (English)',
    ),
    SupportedLanguageOption(
      code: 'es',
      locale: Locale('es'),
      label: 'Español (Spanish)',
    ),
    SupportedLanguageOption(
      code: 'fr',
      locale: Locale('fr'),
      label: 'Français (French)',
    ),
    SupportedLanguageOption(
      code: 'he',
      locale: Locale('he'),
      label: 'עברית (Hebrew)',
    ),
    SupportedLanguageOption(
      code: 'id',
      locale: Locale('id'),
      label: 'Bahasa Indonesia (Indonesian)',
    ),
    SupportedLanguageOption(
      code: 'it',
      locale: Locale('it'),
      label: 'Italiano (Italian)',
    ),
    SupportedLanguageOption(
      code: 'ja',
      locale: Locale('ja'),
      label: '日本語 (Japanese)',
    ),
    SupportedLanguageOption(
      code: 'ko',
      locale: Locale('ko'),
      label: '조선말, 한국어 (Korean)',
    ),
    SupportedLanguageOption(
      code: 'pt',
      locale: Locale('pt'),
      label: 'Português (Portuguese)',
    ),
    SupportedLanguageOption(
      code: 'pt_BR',
      locale: Locale('pt', 'BR'),
      label: 'Português do Brasil (Brazilian Portuguese)',
    ),
    SupportedLanguageOption(
      code: 'ru',
      locale: Locale('ru'),
      label: 'Русский (Russian)',
    ),
    SupportedLanguageOption(
      code: 'uk',
      locale: Locale('uk'),
      label: 'Українська (Ukrainian)',
    ),
    SupportedLanguageOption(
      code: 'vi',
      locale: Locale('vi'),
      label: 'Tiếng Việt Nam (Vietnamese)',
    ),
    SupportedLanguageOption(
      code: 'zh',
      locale: Locale('zh'),
      label: '简化字 (Simplified Chinese)',
    ),
  ];

  Locale? _currentLocale;

  Locale? get currentLocale => _currentLocale;

  String get currentLocaleCode => serializeLocale(_currentLocale);

  static String serializeLocale(Locale? locale) {
    if (locale == null) return 'system';
    final country = locale.countryCode;
    if (country != null && country.isNotEmpty) {
      return '${locale.languageCode}_$country';
    }
    return locale.languageCode;
  }

  static Locale? parseLocaleCode(String? rawCode) {
    if (rawCode == null || rawCode.isEmpty || rawCode == 'system') {
      return null;
    }
    for (final option in supportedLanguages) {
      if (option.code.toLowerCase() == rawCode.trim().toLowerCase()) {
        return option.locale;
      }
    }
    return null;
  }

  static Locale resolveEffectiveLocale(
    Locale? selectedLocale,
    Locale? deviceLocale,
  ) {
    final target = selectedLocale ?? deviceLocale;
    if (target == null) return const Locale('en');

    for (final option in supportedLanguages) {
      if (option.locale.languageCode == target.languageCode &&
          option.locale.countryCode != null &&
          option.locale.countryCode == target.countryCode) {
        return option.locale;
      }
    }
    for (final option in supportedLanguages) {
      if (option.locale.languageCode == target.languageCode &&
          option.locale.countryCode == null) {
        return option.locale;
      }
    }
    return const Locale('en');
  }

  static String intlLocaleTag(Locale locale) {
    if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
      return '${locale.languageCode}_${locale.countryCode}';
    }
    return locale.languageCode;
  }

  String currentLanguageLabel(AppLocalizations l10n) {
    final selected = _currentLocale;
    if (selected == null) return l10n.deviceLanguageOption;
    for (final option in supportedLanguages) {
      if (option.locale == selected) {
        return option.label;
      }
    }
    return l10n.deviceLanguageOption;
  }

  static Future<Locale?> loadStoredLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return parseLocaleCode(prefs.getString(prefLocaleKey));
    } catch (_) {
      return null;
    }
  }

  Future<void> loadSavedLocale() async {
    final saved = await loadStoredLocale();
    if (saved != _currentLocale) {
      _currentLocale = saved;
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale? locale) async {
    if (_currentLocale == locale) return;
    _currentLocale = locale;
    notifyListeners();

    final effective = resolveEffectiveLocale(
      locale,
      WidgetsBinding.instance.platformDispatcher.locale,
    );
    try {
      await initializeDateFormatting(intlLocaleTag(effective));
    } catch (_) {
      // Fallback to already-initialized date symbols if unavailable.
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefLocaleKey, serializeLocale(locale));
    } catch (_) {
      // Keep runtime locale even if storage write fails.
    }

    if (onLocaleChanged != null) {
      await onLocaleChanged!(effective);
    }
  }
}
