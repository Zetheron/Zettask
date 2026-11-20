import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

abstract class AppLockService {
  Future<bool> isDeviceSupported();

  Future<bool> authenticate({required String reason});
}

abstract class ScreenPrivacyService {
  Future<void> setSecureScreen(bool enabled);
}

class PlatformScreenPrivacyService implements ScreenPrivacyService {
  PlatformScreenPrivacyService({this.enforceAndroidOnly = true});

  static final PlatformScreenPrivacyService instance =
      PlatformScreenPrivacyService();

  static const MethodChannel channel =
      MethodChannel('com.zetheron.zettask/privacy');

  final bool enforceAndroidOnly;

  bool get _shouldInvokeChannel =>
      !enforceAndroidOnly || (!kIsWeb && Platform.isAndroid);

  @override
  Future<void> setSecureScreen(bool enabled) async {
    if (!_shouldInvokeChannel) return;
    try {
      await channel.invokeMethod<void>(
        'setSecureScreen',
        {'enabled': enabled},
      );
    } on MissingPluginException {
      // Safe no-op in widget tests and non-Android targets.
    } on PlatformException catch (e) {
      debugPrint('PlatformScreenPrivacyService.setSecureScreen gagal: ${e.code}');
    } catch (e) {
      debugPrint('PlatformScreenPrivacyService.setSecureScreen gagal: $e');
    }
  }
}

class LocalAuthAppLockService implements AppLockService {
  LocalAuthAppLockService._internal();

  static final LocalAuthAppLockService instance =
      LocalAuthAppLockService._internal();

  final LocalAuthentication _localAuth = LocalAuthentication();

  bool get _isMobileRuntime =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Future<bool> isDeviceSupported() async {
    if (!_isMobileRuntime) return false;
    try {
      final supported = await _localAuth.isDeviceSupported();
      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      return supported || canCheckBiometrics;
    } on MissingPluginException {
      return false;
    } on PlatformException catch (e) {
      debugPrint('LocalAuthAppLockService.isDeviceSupported gagal: ${e.code}');
      return false;
    } catch (e) {
      debugPrint('LocalAuthAppLockService.isDeviceSupported gagal: $e');
      return false;
    }
  }

  @override
  Future<bool> authenticate({required String reason}) async {
    if (!_isMobileRuntime) return false;
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        biometricOnly: false,
        persistAcrossBackgrounding: true,
      );
    } on LocalAuthException catch (e) {
      debugPrint('LocalAuthException: ${e.code} ${e.description}');
      return false;
    } on MissingPluginException {
      return false;
    } on PlatformException catch (e) {
      debugPrint('LocalAuthAppLockService.authenticate gagal: ${e.code}');
      return false;
    } catch (e) {
      debugPrint('LocalAuthAppLockService.authenticate gagal: $e');
      return false;
    }
  }
}
