import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../providers/app_lock_provider.dart';
import '../screens/lock_screen.dart';

class AppLockGate extends StatefulWidget {
  const AppLockGate({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends State<AppLockGate> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;
    context.read<AppLockProvider>().handleLifecycleStateChanged(state);
  }

  @override
  Widget build(BuildContext context) {
    final (isLocked, isPrivacyShieldVisible) =
        context.select<AppLockProvider, (bool, bool)>(
      (provider) => (provider.isLocked, provider.isPrivacyShieldVisible),
    );
    final isObscured = isLocked || isPrivacyShieldVisible;

    return Stack(
      children: [
        ExcludeSemantics(
          excluding: isObscured,
          child: IgnorePointer(
            ignoring: isObscured,
            child: widget.child,
          ),
        ),
        if (isLocked)
          const Positioned.fill(
            child: LockScreen(),
          )
        else if (isPrivacyShieldVisible)
          const Positioned.fill(
            child: _PrivacyShieldOverlay(),
          ),
      ],
    );
  }
}

class _PrivacyShieldOverlay extends StatelessWidget {
  const _PrivacyShieldOverlay();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ColoredBox(
      key: const ValueKey('app_lock_privacy_overlay'),
      color: theme.scaffoldBackgroundColor,
      child: Center(
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colorScheme.outline,
              width: 1,
            ),
          ),
          child: Icon(
            Icons.check_rounded,
            size: 34,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
