import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';
import '../models/auth_user_model.dart';
import '../services/auth_service.dart';
import '../services/cloud_sync_service.dart';
import '../services/database_service.dart';

enum SyncStatus {
  idle('Belum disinkronkan'),
  syncing('Menyinkronkan...'),
  synced('Tersinkron'),
  error('Gagal sinkronisasi');

  const SyncStatus(this.label);

  final String label;
}

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    AuthService? authService,
    CloudSyncService? cloudSyncService,
    DatabaseService? databaseService,
    Future<void> Function()? onDataSynced,
  })  : _authService = authService ?? FirebaseAuthService.instance,
        _cloudSyncService = cloudSyncService ?? FirestoreSyncService.instance,
        _databaseService = databaseService ?? DatabaseService.instance {
    _onDataSynced = onDataSynced;
    _user = _authService.currentUser;
    if (_user != null) {
      _restoreLastSyncedAt(_user!.uid);
    }
    _authSubscription = _authService.authStateChanges.listen(_onAuthStateChanged);
  }

  static const String _prefLastSyncedPrefix = 'zettask_last_synced_at_';

  final AuthService _authService;
  final CloudSyncService _cloudSyncService;
  final DatabaseService _databaseService;
  Future<void> Function()? _onDataSynced;

  StreamSubscription<AuthUser?>? _authSubscription;

  AuthUser? _user;
  SyncStatus _syncStatus = SyncStatus.idle;
  DateTime? _lastSyncedAt;
  bool _isAuthBusy = false;
  String? _errorCode;
  String? _errorMessage;
  String? _syncErrorMessage;
  bool _requiresRecentLogin = false;

  AuthUser? get user => _user;
  bool get isSignedIn => _user != null;
  SyncStatus get syncStatus => _syncStatus;
  DateTime? get lastSyncedAt => _lastSyncedAt;
  bool get isAuthBusy => _isAuthBusy;
  bool get isSyncing => _syncStatus == SyncStatus.syncing;
  String? get errorCode => _errorCode;
  String? get errorMessage => _errorMessage;
  String? get syncErrorMessage => _syncErrorMessage;
  bool get requiresRecentLogin => _requiresRecentLogin;

  String? localizedError(AppLocalizations l10n) {
    if (_errorCode != null) {
      return localizeFirebaseAuthError(_errorCode!, l10n);
    }
    return _errorMessage;
  }

  void attachDataSyncedCallback(Future<void> Function()? callback) {
    _onDataSynced = callback;
  }

  void clearError() {
    if (_errorMessage == null && _errorCode == null && !_requiresRecentLogin) {
      return;
    }
    _errorCode = null;
    _errorMessage = null;
    _requiresRecentLogin = false;
    notifyListeners();
  }

  Future<void> _onAuthStateChanged(AuthUser? nextUser) async {
    final previousUid = _user?.uid;
    _user = nextUser;

    if (nextUser == null) {
      _syncStatus = SyncStatus.idle;
      _lastSyncedAt = null;
      _syncErrorMessage = null;
      notifyListeners();
      return;
    }

    if (previousUid != nextUser.uid) {
      await _restoreLastSyncedAt(nextUser.uid);
    }
    notifyListeners();
  }

  Future<void> _restoreLastSyncedAt(String uid) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('$_prefLastSyncedPrefix$uid');
      if (raw != null && raw.isNotEmpty) {
        _lastSyncedAt = DateTime.tryParse(raw);
        if (_lastSyncedAt != null && _syncStatus == SyncStatus.idle) {
          _syncStatus = SyncStatus.synced;
        }
        notifyListeners();
      }
    } catch (_) {
      // Ignore storage read failures so auth remains usable.
    }
  }

  Future<void> _saveLastSyncedAt(String uid, DateTime syncedAt) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        '$_prefLastSyncedPrefix$uid',
        syncedAt.toIso8601String(),
      );
    } catch (_) {
      // Ignore storage write failures.
    }
  }

  Future<void> _clearLastSyncedAt(String uid) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('$_prefLastSyncedPrefix$uid');
    } catch (_) {
      // Ignore storage cleanup failures.
    }
  }

  Future<bool> signInWithEmail(String email, String password) async {
    if (_isAuthBusy) return false;
    _isAuthBusy = true;
    _errorMessage = null;
    _requiresRecentLogin = false;
    notifyListeners();

    try {
      final signedInUser = await _authService.signInWithEmail(email, password);
      _user = signedInUser;
      await _restoreLastSyncedAt(signedInUser.uid);
      _isAuthBusy = false;
      notifyListeners();
      await syncNow();
      return true;
    } on AuthException catch (e) {
      _errorCode = e.code;
      _errorMessage = e.message;
      _isAuthBusy = false;
      notifyListeners();
      return false;
    } catch (_) {
      _errorCode = 'unknown';
      _errorMessage = mapFirebaseAuthError('unknown');
      _isAuthBusy = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUpWithEmail(String email, String password) async {
    if (_isAuthBusy) return false;
    _isAuthBusy = true;
    _errorMessage = null;
    _requiresRecentLogin = false;
    notifyListeners();

    try {
      final createdUser = await _authService.signUpWithEmail(email, password);
      _user = createdUser;
      _lastSyncedAt = null;
      _isAuthBusy = false;
      notifyListeners();
      await syncNow();
      return true;
    } on AuthException catch (e) {
      _errorCode = e.code;
      _errorMessage = e.message;
      _isAuthBusy = false;
      notifyListeners();
      return false;
    } catch (_) {
      _errorCode = 'unknown';
      _errorMessage = mapFirebaseAuthError('unknown');
      _isAuthBusy = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    if (_isAuthBusy) return false;
    _isAuthBusy = true;
    _errorMessage = null;
    _requiresRecentLogin = false;
    notifyListeners();

    try {
      final signedInUser = await _authService.signInWithGoogle();
      if (signedInUser == null) {
        _isAuthBusy = false;
        notifyListeners();
        return false;
      }
      _user = signedInUser;
      await _restoreLastSyncedAt(signedInUser.uid);
      _isAuthBusy = false;
      notifyListeners();
      await syncNow();
      return true;
    } on AuthException catch (e) {
      _errorCode = e.code;
      _errorMessage = e.message;
      _isAuthBusy = false;
      notifyListeners();
      return false;
    } catch (_) {
      _errorCode = 'unknown';
      _errorMessage = mapFirebaseAuthError('unknown');
      _isAuthBusy = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    if (_isAuthBusy) return false;
    _isAuthBusy = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.sendPasswordResetEmail(email);
      _isAuthBusy = false;
      notifyListeners();
      return true;
    } on AuthException catch (e) {
      _errorCode = e.code;
      _errorMessage = e.message;
      _isAuthBusy = false;
      notifyListeners();
      return false;
    } catch (_) {
      _errorCode = 'unknown';
      _errorMessage = mapFirebaseAuthError('unknown');
      _isAuthBusy = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> syncNow() async {
    final current = _user;
    if (current == null || _syncStatus == SyncStatus.syncing) {
      return false;
    }

    _syncStatus = SyncStatus.syncing;
    _syncErrorMessage = null;
    notifyListeners();

    try {
      final summary = await _cloudSyncService.syncAll(
        current.uid,
        _databaseService,
        lastSyncedAt: _lastSyncedAt,
      );
      _lastSyncedAt = summary.syncedAt;
      _syncStatus = SyncStatus.synced;
      await _saveLastSyncedAt(current.uid, summary.syncedAt);
      notifyListeners();

      if (_onDataSynced != null) {
        await _onDataSynced!();
      }
      return true;
    } catch (e) {
      debugPrint('AuthProvider.syncNow gagal: $e');
      _syncStatus = SyncStatus.error;
      _syncErrorMessage = 'Gagal menyinkronkan data. Periksa koneksi internet Anda.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> signOut() async {
    if (_isAuthBusy) return false;
    _isAuthBusy = true;
    _errorMessage = null;
    _requiresRecentLogin = false;
    notifyListeners();

    try {
      await _authService.signOut();
      _user = null;
      _syncStatus = SyncStatus.idle;
      _lastSyncedAt = null;
      _syncErrorMessage = null;
      _isAuthBusy = false;
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('AuthProvider.signOut gagal: $e');
      _errorMessage = 'Gagal keluar dari akun. Silakan coba lagi.';
      _isAuthBusy = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    final current = _user;
    if (current == null || _isAuthBusy) return false;

    _isAuthBusy = true;
    _errorMessage = null;
    _requiresRecentLogin = false;
    notifyListeners();

    try {
      await _cloudSyncService.deleteAllUserData(current.uid);
      await _authService.deleteAccount();
      await _clearLastSyncedAt(current.uid);
      _user = null;
      _syncStatus = SyncStatus.idle;
      _lastSyncedAt = null;
      _syncErrorMessage = null;
      _isAuthBusy = false;
      notifyListeners();
      return true;
    } on AuthException catch (e) {
      _errorCode = e.code;
      _errorMessage = e.message;
      _requiresRecentLogin = e.requiresRecentLogin;
      _isAuthBusy = false;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint('AuthProvider.deleteAccount gagal: $e');
      _errorCode = 'network-request-failed';
      _errorMessage = 'Gagal menghapus akun. Periksa koneksi internet Anda.';
      _isAuthBusy = false;
      notifyListeners();
      return false;
    }
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
