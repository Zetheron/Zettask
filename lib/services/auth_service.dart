import 'dart:ui' show Locale;

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../l10n/app_localizations.dart';
import '../models/auth_user_model.dart';

class AuthException implements Exception {
  const AuthException({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;

  bool get requiresRecentLogin => code == 'requires-recent-login';

  @override
  String toString() => message;
}

String localizeFirebaseAuthError(String code, AppLocalizations l10n) {
  return switch (code) {
    'user-not-found' => l10n.authErrUserNotFound,
    'wrong-password' => l10n.authErrWrongPassword,
    'invalid-credential' => l10n.authErrInvalidCredential,
    'invalid-email' => l10n.authErrInvalidEmail,
    'email-already-in-use' => l10n.authErrEmailInUse,
    'weak-password' => l10n.authErrWeakPassword,
    'network-request-failed' => l10n.authErrNetwork,
    'requires-recent-login' => l10n.authErrRequiresRecentLogin,
    'too-many-requests' => l10n.authErrTooManyRequests,
    'user-disabled' => l10n.authErrUserDisabled,
    'account-exists-with-different-credential' =>
      l10n.authErrAccountExistsDifferent,
    'operation-not-allowed' => l10n.authErrOperationNotAllowed,
    'firebase-unavailable' => l10n.authErrFirebaseUnavailable,
    _ => l10n.authErrUnknown,
  };
}

String mapFirebaseAuthError(String code, {Locale? locale}) {
  final l10n = lookupAppLocalizations(locale ?? const Locale('id'));
  return localizeFirebaseAuthError(code, l10n);
}

abstract class AuthService {
  Stream<AuthUser?> get authStateChanges;

  AuthUser? get currentUser;

  Future<AuthUser> signInWithEmail(String email, String password);

  Future<AuthUser> signUpWithEmail(String email, String password);

  Future<AuthUser?> signInWithGoogle();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> signOut();

  Future<void> deleteAccount();
}

class FirebaseAuthService implements AuthService {
  FirebaseAuthService._internal();

  static final FirebaseAuthService instance = FirebaseAuthService._internal();

  Future<void>? _googleInitFuture;

  bool get _isFirebaseReady => Firebase.apps.isNotEmpty;

  fb.FirebaseAuth get _auth {
    if (!_isFirebaseReady) {
      throw AuthException(
        code: 'firebase-unavailable',
        message: mapFirebaseAuthError('firebase-unavailable'),
      );
    }
    return fb.FirebaseAuth.instance;
  }

  Future<void> _ensureGoogleInitialized() {
    return _googleInitFuture ??= GoogleSignIn.instance.initialize();
  }

  AuthUser? _toAuthUser(fb.User? user) {
    if (user == null) return null;
    final providerId = user.providerData.isNotEmpty
        ? user.providerData.first.providerId
        : 'password';
    return AuthUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      providerId: providerId,
    );
  }

  @override
  Stream<AuthUser?> get authStateChanges {
    if (!_isFirebaseReady) {
      return const Stream<AuthUser?>.empty();
    }
    return fb.FirebaseAuth.instance.authStateChanges().map(_toAuthUser);
  }

  @override
  AuthUser? get currentUser {
    if (!_isFirebaseReady) return null;
    return _toAuthUser(fb.FirebaseAuth.instance.currentUser);
  }

  @override
  Future<AuthUser> signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = _toAuthUser(credential.user);
      if (user == null) {
        throw const AuthException(
          code: 'unknown',
          message: 'Gagal memuat data akun.',
        );
      }
      return user;
    } on AuthException {
      rethrow;
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: mapFirebaseAuthError(e.code),
      );
    } catch (e) {
      debugPrint('FirebaseAuthService.signInWithEmail gagal: $e');
      throw AuthException(
        code: 'unknown',
        message: mapFirebaseAuthError('unknown'),
      );
    }
  }

  @override
  Future<AuthUser> signUpWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = _toAuthUser(credential.user);
      if (user == null) {
        throw const AuthException(
          code: 'unknown',
          message: 'Gagal membuat akun baru.',
        );
      }
      return user;
    } on AuthException {
      rethrow;
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: mapFirebaseAuthError(e.code),
      );
    } catch (e) {
      debugPrint('FirebaseAuthService.signUpWithEmail gagal: $e');
      throw AuthException(
        code: 'unknown',
        message: mapFirebaseAuthError('unknown'),
      );
    }
  }

  @override
  Future<AuthUser?> signInWithGoogle() async {
    try {
      final auth = _auth;
      await _ensureGoogleInitialized();
      final googleUser = await GoogleSignIn.instance.authenticate();
      final idToken = googleUser.authentication.idToken;
      if (idToken == null || idToken.isEmpty) {
        throw const AuthException(
          code: 'invalid-credential',
          message: 'Token Google tidak tersedia. Silakan coba lagi.',
        );
      }

      String? accessToken;
      try {
        final authorization = await googleUser.authorizationClient
            .authorizationForScopes(const ['email']);
        accessToken = authorization?.accessToken;
      } catch (_) {
        // Firebase Auth accepts Google credentials with idToken alone.
      }

      final credential = fb.GoogleAuthProvider.credential(
        idToken: idToken,
        accessToken: accessToken,
      );
      final userCredential = await auth.signInWithCredential(credential);
      return _toAuthUser(userCredential.user);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted) {
        return null;
      }
      debugPrint('GoogleSignInException: ${e.code} ${e.description}');
      throw const AuthException(
        code: 'google-sign-in-failed',
        message: 'Gagal masuk dengan Google. Silakan coba lagi.',
      );
    } on AuthException {
      rethrow;
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: mapFirebaseAuthError(e.code),
      );
    } on PlatformException catch (e) {
      debugPrint('Google Sign-In PlatformException: ${e.code} ${e.message}');
      throw const AuthException(
        code: 'network-request-failed',
        message: 'Gagal terhubung ke layanan Google. Periksa koneksi Anda.',
      );
    } catch (e) {
      debugPrint('FirebaseAuthService.signInWithGoogle gagal: $e');
      throw AuthException(
        code: 'unknown',
        message: mapFirebaseAuthError('unknown'),
      );
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on AuthException {
      rethrow;
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: mapFirebaseAuthError(e.code),
      );
    } catch (e) {
      debugPrint('FirebaseAuthService.sendPasswordResetEmail gagal: $e');
      throw AuthException(
        code: 'unknown',
        message: mapFirebaseAuthError('unknown'),
      );
    }
  }

  @override
  Future<void> signOut() async {
    if (!_isFirebaseReady) return;
    try {
      if (_googleInitFuture != null) {
        await GoogleSignIn.instance.signOut();
      }
    } catch (_) {
      // Ignore Google Sign-In session errors when signing out locally.
    }
    await fb.FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AuthException(
        code: 'user-not-found',
        message: 'Tidak ada akun yang sedang masuk.',
      );
    }
    try {
      await user.delete();
      try {
        if (_googleInitFuture != null) {
          await GoogleSignIn.instance.disconnect();
        }
      } catch (_) {
        // Ignore disconnect errors after Firebase user is already deleted.
      }
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: mapFirebaseAuthError(e.code),
      );
    } catch (e) {
      debugPrint('FirebaseAuthService.deleteAccount gagal: $e');
      throw AuthException(
        code: 'unknown',
        message: mapFirebaseAuthError('unknown'),
      );
    }
  }
}
