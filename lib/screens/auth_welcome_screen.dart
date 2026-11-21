import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../providers/app_lock_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/about_sheet.dart';
import '../widgets/zettask_loaders.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});

  static const String routeName = '/auth-welcome';

  static void closeAuthFlow(BuildContext context) {
    Navigator.of(context).popUntil((route) {
      final name = route.settings.name;
      return name != AuthWelcomeScreen.routeName &&
          name != LoginScreen.routeName &&
          name != SignUpScreen.routeName;
    });
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    context.read<AppLockProvider?>()?.suspendLockTemporarily();
    final authProvider = context.read<AuthProvider>();
    final l10n = AppLocalizations.of(context);
    final success = await authProvider.signInWithGoogle();
    if (!context.mounted) return;
    if (success) {
      closeAuthFlow(context);
    } else {
      final err = authProvider.localizedError(l10n);
      if (err != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(err)));
      }
    }
  }

  Future<void> _openSignUp(BuildContext context) async {
    context.read<AuthProvider>().clearError();
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        settings: const RouteSettings(name: SignUpScreen.routeName),
        builder: (_) => const SignUpScreen(),
      ),
    );
  }

  Future<void> _openLogin(BuildContext context) async {
    context.read<AuthProvider>().clearError();
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        settings: const RouteSettings(name: LoginScreen.routeName),
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final authProvider = context.watch<AuthProvider>();
    final isBusy = authProvider.isAuthBusy;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.back,
          onPressed: isBusy ? null : () => Navigator.of(context).pop(),
          style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
          icon: const Icon(Icons.close_rounded),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: colorScheme.outline, width: 1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    'assets/icon/app_icon.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return ColoredBox(
                        color: colorScheme.primaryContainer,
                        child: Center(
                          child: Text(
                            'Z',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.authWelcomeTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.authWelcomeSubtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 36),
              FilledButton(
                onPressed: isBusy ? null : () => _openSignUp(context),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.createNewAccount,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: isBusy ? null : () => _openLogin(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  side: BorderSide(color: colorScheme.outline, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  l10n.signIn,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: isBusy ? null : () => _handleGoogleSignIn(context),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  backgroundColor: colorScheme.surface,
                  side: BorderSide(color: colorScheme.outline, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isBusy
                    ? ZettaskSpinnerArc(
                        size: 20,
                        color: colorScheme.primary,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const _GoogleBadge(),
                          const SizedBox(width: 10),
                          Text(
                            l10n.continueWithGoogle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 28),
              Center(
                child: TextButton(
                  onPressed: isBusy ? null : () => AboutSheet.show(context),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(48, 48),
                    foregroundColor: colorScheme.onSurfaceVariant,
                  ),
                  child: Text(
                    l10n.authTermsNotice,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleBadge extends StatelessWidget {
  const _GoogleBadge();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.outline, width: 1),
      ),
      alignment: Alignment.center,
      child: Text(
        'G',
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w800,
          color: colorScheme.onSurface,
          height: 1.0,
        ),
      ),
    );
  }
}
