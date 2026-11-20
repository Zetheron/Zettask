import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/app_lock_service.dart';

const String prefAppLockEnabledKey = 'zettask_app_lock_enabled';

class AppLockProvider extends ChangeNotifier {
  AppLockProvider({
    AppLockService? appLockService,
    ScreenPrivacyService? privacyService,
    DateTime Function()? nowProvider,
    this.gracePeriod = const Duration(seconds: 3),
  })  : _appLockService = appLockService ?? LocalAuthAppLockService.instance,
        _privacyService =
            privacyService ?? PlatformScreenPrivacyService.instance,
        _nowProvider = nowProvider ?? DateTime.now;

  final AppLockService _appLockService;
  final ScreenPrivacyService _privacyService;
  final DateTime Function() _nowProvider;
  final Duration gracePeriod;

  bool _isEnabled = false;
  bool _isLocked = false;
  bool _isPrivacyShieldVisible = false;
  bool _isAuthenticating = false;
  bool _isDeviceSupported = false;
  bool _isInitialized = false;
  DateTime? _pausedAt;
  DateTime? _suspendUntil;
  String? _errorMessage;

  bool get isEnabled => _isEnabled;
  bool get isLocked => _isLocked;
  bool get isPrivacyShieldVisible => _isPrivacyShieldVisible;
  bool get isAuthenticating => _isAuthenticating;
  bool get isDeviceSupported => _isDeviceSupported;
  bool get isInitialized => _isInitialized;
  String? get errorMessage => _errorMessage;

  Future<void> initialize({bool allowEnabled = true}) async {
    if (_isInitialized) {
      if (!allowEnabled && (_isEnabled || _isLocked)) {
        await disableForDowngrade();
      }
      return;
    }
    _isDeviceSupported = await _appLockService.isDeviceSupported();
    var storedEnabled = false;
    try {
      final prefs = await SharedPreferences.getInstance();
      storedEnabled = prefs.getBool(prefAppLockEnabledKey) ?? false;
    } catch (_) {
      storedEnabled = false;
    }

    if (storedEnabled && !allowEnabled) {
      _isEnabled = false;
      _isLocked = false;
      _isPrivacyShieldVisible = false;
      _pausedAt = null;
      _suspendUntil = null;
      _errorMessage = null;
      _isInitialized = true;
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool(prefAppLockEnabledKey, false);
      } catch (_) {
        // Keep unlocked state even if preference write fails.
      }
      await _applySecureScreen(false);
      notifyListeners();
      return;
    }

    _isEnabled = storedEnabled;
    _isLocked = _isEnabled;
    _isPrivacyShieldVisible = false;
    _isInitialized = true;
    await _applySecureScreen(_isEnabled);
    notifyListeners();
  }

  /// Disables App Lock and Recent Apps privacy without biometric prompt so an
  /// expired Pro subscription never locks the user out of their own data.
  Future<void> disableForDowngrade() async {
    final wasActive = _isEnabled || _isLocked || _isPrivacyShieldVisible;
    _isEnabled = false;
    _isLocked = false;
    _isPrivacyShieldVisible = false;
    _pausedAt = null;
    _suspendUntil = null;
    _errorMessage = null;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(prefAppLockEnabledKey, false);
    } catch (_) {
      // Never block safe downgrade unlock if preference write fails.
    }

    await _applySecureScreen(false);
    if (wasActive || _isInitialized) {
      notifyListeners();
    }
  }

  Future<void> _applySecureScreen(bool enabled) async {
    try {
      await _privacyService.setSecureScreen(enabled);
    } catch (_) {
      // Never block app lock state updates if platform flag fails.
    }
  }

  void suspendLockTemporarily({
    Duration duration = const Duration(seconds: 15),
  }) {
    _suspendUntil = _nowProvider().add(duration);
  }

  void lockNow() {
    if (!_isEnabled || _isLocked) return;
    _isLocked = true;
    _isPrivacyShieldVisible = false;
    _errorMessage = null;
    notifyListeners();
  }

  void handleLifecycleStateChanged(AppLifecycleState state) {
    if (!_isEnabled) {
      if (_isPrivacyShieldVisible) {
        _isPrivacyShieldVisible = false;
        notifyListeners();
      }
      return;
    }

    final now = _nowProvider();
    final isSuspended = _suspendUntil != null && now.isBefore(_suspendUntil!);

    if (state == AppLifecycleState.inactive) {
      if (_isAuthenticating || isSuspended) return;
      if (!_isPrivacyShieldVisible) {
        _isPrivacyShieldVisible = true;
        notifyListeners();
      }
      return;
    }

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      if (_isAuthenticating || isSuspended) return;
      _pausedAt ??= now;
      if (!_isPrivacyShieldVisible) {
        _isPrivacyShieldVisible = true;
        notifyListeners();
      }
      return;
    }

    if (state == AppLifecycleState.resumed) {
      final pausedAt = _pausedAt;
      _pausedAt = null;
      final hadShield = _isPrivacyShieldVisible;
      _isPrivacyShieldVisible = false;

      if (_isAuthenticating) {
        if (hadShield) notifyListeners();
        return;
      }
      if (isSuspended) {
        if (hadShield) notifyListeners();
        return;
      }
      _suspendUntil = null;

      if (pausedAt != null && now.difference(pausedAt) >= gracePeriod) {
        _isLocked = true;
        _errorMessage = null;
        notifyListeners();
      } else if (hadShield) {
        notifyListeners();
      }
    }
  }

  Future<bool> setEnabled(bool enable) async {
    if (_isAuthenticating) return false;
    if (_isEnabled == enable) return true;

    _errorMessage = null;
    final supported = await _appLockService.isDeviceSupported();
    _isDeviceSupported = supported;

    if (!supported) {
      _errorMessage =
          'Perangkat belum mengaktifkan biometrik atau PIN kunci layar.';
      notifyListeners();
      return false;
    }

    _isAuthenticating = true;
    notifyListeners();

    final verified = await _appLockService.authenticate(
      reason: enable
          ? 'Verifikasi identitas untuk mengaktifkan Kunci Aplikasi'
          : 'Verifikasi identitas untuk menonaktifkan Kunci Aplikasi',
    );

    _isAuthenticating = false;

    if (!verified) {
      _errorMessage = 'Verifikasi dibatalkan atau gagal.';
      notifyListeners();
      return false;
    }

    _isEnabled = enable;
    _isLocked = false;
    _isPrivacyShieldVisible = false;
    _pausedAt = null;
    _errorMessage = null;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(prefAppLockEnabledKey, enable);
    } catch (_) {
      // Keep runtime lock state even if preference persistence fails.
    }

    await _applySecureScreen(enable);
    notifyListeners();
    return true;
  }

  Future<bool> unlock() async {
    if (_isAuthenticating) return false;
    if (!_isLocked) return true;

    _isAuthenticating = true;
    _errorMessage = null;
    notifyListeners();

    final verified = await _appLockService.authenticate(
      reason: 'Verifikasi identitas untuk membuka Zettask',
    );

    _isAuthenticating = false;

    if (verified) {
      _isLocked = false;
      _isPrivacyShieldVisible = false;
      _pausedAt = null;
      _errorMessage = null;
      notifyListeners();
      return true;
    }

    _errorMessage =
        'Autentikasi dibatalkan atau gagal. Ketuk Buka Kunci untuk mencoba lagi.';
    notifyListeners();
    return false;
  }
}
