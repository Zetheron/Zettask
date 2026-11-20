import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'l10n/l10n_helpers.dart';
import 'providers/app_lock_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/calendar_provider.dart';
import 'providers/locale_provider.dart';
import 'providers/subscription_provider.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/workspace_provider.dart';
import 'screens/main_shell.dart';
import 'services/app_lock_service.dart';
import 'services/auth_service.dart';
import 'services/calendar_service.dart';
import 'services/cloud_sync_service.dart';
import 'services/database_service.dart';
import 'services/export_service.dart';
import 'services/home_widget_service.dart';
import 'services/notification_service.dart';
import 'services/subscription_service.dart';
import 'widgets/app_lock_gate.dart';

export 'providers/locale_provider.dart' show prefLocaleKey;
export 'providers/theme_provider.dart'
    show
        prefThemeModeKey,
        prefThemePresetKey,
        prefThemeAmoledKey,
        prefThemeAccentKey,
        prefWidgetStyleKey,
        parseThemeMode,
        serializeThemeMode;

Future<(ThemeMode, AppThemePreset)> _loadSavedThemeConfig() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final mode = parseThemeMode(prefs.getString(prefThemeModeKey));
    final preset =
        AppThemePreset.fromStorage(prefs.getString(prefThemePresetKey));
    return (mode, preset);
  } catch (_) {
    return (ThemeMode.system, AppThemePreset.defaultIndigo);
  }
}

Future<void> _initFirebaseSafely() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (e) {
    // Allow offline-first startup when Firebase cannot initialize on this platform.
    debugPrint('Firebase.initializeApp dilewati: $e');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await _initFirebaseSafely();
  await NotificationService.instance.init();
  final (initialThemeMode, initialPreset) = await _loadSavedThemeConfig();
  final initialLocale = await LocaleProvider.loadStoredLocale();
  runApp(
    ZettaskApp(
      initialThemeMode: initialThemeMode,
      initialThemePreset: initialPreset,
      initialLocale: initialLocale,
    ),
  );
}

class ZettaskApp extends StatefulWidget {
  const ZettaskApp({
    super.key,
    this.autoLoadTasks = true,
    this.databaseService,
    this.notificationService,
    this.calendarService,
    this.exportService,
    this.authService,
    this.cloudSyncService,
    this.appLockService,
    this.privacyService,
    this.homeWidgetService,
    this.subscriptionService,
    this.initialDate,
    this.initialThemeMode,
    this.initialThemePreset,
    this.initialLocale,
    this.nowProvider,
  });

  final bool autoLoadTasks;
  final DatabaseService? databaseService;
  final TaskNotificationService? notificationService;
  final DeviceCalendarService? calendarService;
  final DataExportService? exportService;
  final AuthService? authService;
  final CloudSyncService? cloudSyncService;
  final AppLockService? appLockService;
  final ScreenPrivacyService? privacyService;
  final HomeWidgetSyncService? homeWidgetService;
  final SubscriptionService? subscriptionService;
  final DateTime? initialDate;
  final ThemeMode? initialThemeMode;
  final AppThemePreset? initialThemePreset;
  final Locale? initialLocale;
  final DateTime Function()? nowProvider;

  @override
  State<ZettaskApp> createState() => _ZettaskAppState();
}

class _ZettaskAppState extends State<ZettaskApp> {
  late final ThemeProvider _themeProvider;
  late final LocaleProvider _localeProvider;
  late final SubscriptionProvider _subscriptionProvider;
  late final AppLockProvider _appLockProvider;
  late final CalendarProvider _calendarProvider;
  late final AuthProvider _authProvider;

  HomeWidgetSyncService get _homeWidgetService =>
      widget.homeWidgetService ?? AndroidHomeWidgetService.instance;

  @override
  void initState() {
    super.initState();
    final styleService = _homeWidgetService is HomeWidgetStyleService
        ? _homeWidgetService as HomeWidgetStyleService
        : null;

    _themeProvider = ThemeProvider(
      initialThemeMode: widget.initialThemeMode ?? ThemeMode.system,
      initialPreset: widget.initialThemePreset ?? AppThemePreset.defaultIndigo,
      homeWidgetStyleService: styleService,
    );

    _appLockProvider = AppLockProvider(
      appLockService: widget.appLockService,
      privacyService: widget.privacyService,
      nowProvider: widget.nowProvider,
    );

    _calendarProvider = CalendarProvider(
      calendarService: widget.calendarService,
      initialDate: widget.initialDate,
    );

    _authProvider = AuthProvider(
      authService: widget.authService,
      cloudSyncService: widget.cloudSyncService,
      databaseService: widget.databaseService,
    );

    _subscriptionProvider = SubscriptionProvider(
      subscriptionService: widget.subscriptionService,
      nowProvider: widget.nowProvider,
      onProStatusChanged: _handleProStatusChanged,
    );

    _initializeEntitlementAndDependents();

    _localeProvider = LocaleProvider(
      initialLocale: widget.initialLocale,
      onLocaleChanged: _syncWidgetLabelsForLocale,
    );
    if (widget.initialLocale == null) {
      _localeProvider.loadSavedLocale().then((_) {
        if (!mounted) return;
        final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
        final effective = LocaleProvider.resolveEffectiveLocale(
          _localeProvider.currentLocale,
          deviceLocale,
        );
        _syncWidgetLabelsForLocale(effective);
      });
    } else {
      _syncWidgetLabelsForLocale(
        LocaleProvider.resolveEffectiveLocale(
          widget.initialLocale,
          WidgetsBinding.instance.platformDispatcher.locale,
        ),
      );
    }
  }

  Future<void> _handleProStatusChanged(bool isPro) async {
    _authProvider.setCloudSyncPaused(!isPro);
    if (!isPro) {
      await _themeProvider.enforceProEntitlement(false);
      await _appLockProvider.disableForDowngrade();
      await _calendarProvider.disableForDowngrade();
    }
  }

  Future<void> _initializeEntitlementAndDependents() async {
    await _subscriptionProvider.initialize();
    if (!mounted) return;
    final isPro = _subscriptionProvider.isPro;
    _authProvider.setCloudSyncPaused(!isPro);
    await _appLockProvider.initialize(allowEnabled: isPro);
    if (!mounted) return;
    await _themeProvider.loadSavedPreferences(
      restoreMode: widget.initialThemeMode == null,
      restorePreset: widget.initialThemePreset == null,
      restoreProOptions: true,
      isPro: isPro,
    );
    if (!isPro) {
      await _calendarProvider.disableForDowngrade();
    }
  }

  Future<void> _syncWidgetLabelsForLocale(Locale effectiveLocale) async {
    final l10n = lookupAppLocalizations(effectiveLocale);
    await _homeWidgetService.updateWidgetLabels(
      widgetTitle: l10n.widgetTitle,
      widgetEmptyText: l10n.widgetEmptyText,
    );
  }

  @override
  void dispose() {
    _themeProvider.dispose();
    _localeProvider.dispose();
    _subscriptionProvider.dispose();
    _appLockProvider.dispose();
    _calendarProvider.dispose();
    _authProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(value: _themeProvider),
        ChangeNotifierProvider<LocaleProvider>.value(value: _localeProvider),
        ChangeNotifierProvider<SubscriptionProvider>.value(
          value: _subscriptionProvider,
        ),
        ChangeNotifierProvider<AppLockProvider>.value(value: _appLockProvider),
        ChangeNotifierProvider<TaskProvider>(
          create: (_) => TaskProvider(
            databaseService: widget.databaseService,
            notificationService: widget.notificationService,
            homeWidgetService: widget.homeWidgetService,
            initialDate: widget.initialDate,
            nowProvider: widget.nowProvider,
          ),
        ),
        ChangeNotifierProvider<CalendarProvider>.value(
          value: _calendarProvider,
        ),
        ChangeNotifierProvider<WorkspaceProvider>(
          create: (_) => WorkspaceProvider(
            databaseService: widget.databaseService,
            exportService: widget.exportService,
            nowProvider: widget.nowProvider,
          ),
        ),
        ChangeNotifierProvider<AuthProvider>.value(value: _authProvider),
      ],
      child: Consumer2<ThemeProvider, LocaleProvider>(
        builder: (context, themeProvider, localeProvider, _) {
          return MaterialApp(
            title: 'Zettask',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.themeMode,
            locale: localeProvider.currentLocale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: zettaskLocalizationsDelegates,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              return LocaleProvider.resolveEffectiveLocale(
                localeProvider.currentLocale,
                deviceLocale,
              );
            },
            home: AppLockGate(
              child: MainShell(
                themeMode: themeProvider.themeMode,
                onToggleTheme: themeProvider.toggleThemeMode,
                onSelectThemeMode: themeProvider.setThemeMode,
                autoLoad: widget.autoLoadTasks,
                homeWidgetService: widget.homeWidgetService,
              ),
            ),
          );
        },
      ),
    );
  }
}
