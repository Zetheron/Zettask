import 'package:material_ui/material_ui.dart';

import '../l10n/app_localizations.dart';
import '../services/onboarding_service.dart';
import '../widgets/onboarding_illustrations.dart';
import '../widgets/zettask_motion.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    this.isReplay = false,
    this.onCompleted,
    this.onboardingService,
  });

  final bool isReplay;
  final VoidCallback? onCompleted;
  final OnboardingService? onboardingService;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const int _slideCount = 3;

  late final PageController _pageController;
  int _currentPage = 0;
  bool _isFinishing = false;

  OnboardingService get _service =>
      widget.onboardingService ?? OnboardingService.instance;

  bool get _isLastSlide => _currentPage == _slideCount - 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _handleNext() async {
    if (_isLastSlide) {
      await _finishOnboarding();
      return;
    }

    final nextPage = _currentPage + 1;
    if (MediaQuery.disableAnimationsOf(context)) {
      _pageController.jumpToPage(nextPage);
    } else {
      await _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<void> _finishOnboarding() async {
    if (_isFinishing) return;
    _isFinishing = true;

    await _service.markOnboardingCompleted();
    if (!mounted) return;

    if (widget.isReplay) {
      Navigator.of(context).pop();
      return;
    }
    widget.onCompleted?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    final slides = [
      (
        const QuickTaskIllustration(key: ValueKey('onboarding_ill_1')),
        l10n.onboardingSlide1Title,
        l10n.onboardingSlide1Body,
      ),
      (
        const TimelineProjectIllustration(key: ValueKey('onboarding_ill_2')),
        l10n.onboardingSlide2Title,
        l10n.onboardingSlide2Body,
      ),
      (
        const OfflinePrivacyIllustration(key: ValueKey('onboarding_ill_3')),
        l10n.onboardingSlide3Title,
        l10n.onboardingSlide3Body,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 56,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IgnorePointer(
                      ignoring: _isLastSlide,
                      child: disableAnimations
                          ? Opacity(
                              opacity: _isLastSlide ? 0.0 : 1.0,
                              child: ZettaskSpringTap(
                                child: TextButton(
                                  key: const ValueKey('onboarding_skip_button'),
                                  onPressed: _finishOnboarding,
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(48, 48),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    shape: const StadiumBorder(),
                                    foregroundColor:
                                        colorScheme.onSurfaceVariant,
                                  ),
                                  child: Text(l10n.onboardingSkip),
                                ),
                              ),
                            )
                          : AnimatedOpacity(
                              opacity: _isLastSlide ? 0.0 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              child: ZettaskSpringTap(
                                child: TextButton(
                                  key: const ValueKey('onboarding_skip_button'),
                                  onPressed: _finishOnboarding,
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(48, 48),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                    ),
                                    shape: const StadiumBorder(),
                                    foregroundColor:
                                        colorScheme.onSurfaceVariant,
                                  ),
                                  child: Text(l10n.onboardingSkip),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                key: const ValueKey('onboarding_page_view'),
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  if (_currentPage != index) {
                    setState(() => _currentPage = index);
                  }
                },
                itemBuilder: (context, index) {
                  final (illustration, title, body) = slides[index];
                  return Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 12,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          illustration,
                          const SizedBox(height: 36),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 320),
                            child: Text(
                              title,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.6,
                                height: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 320),
                            child: Text(
                              body,
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    key: const ValueKey('onboarding_page_indicator'),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_slideCount, (index) {
                      final isActive = index == _currentPage;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: disableAnimations
                            ? Container(
                                width: isActive ? 26 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? colorScheme.primary
                                      : colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              )
                            : AnimatedContainer(
                                duration: const Duration(milliseconds: 280),
                                curve: ZettaskSpringCurve.snappy,
                                width: isActive ? 26 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? colorScheme.primary
                                      : colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  ZettaskSpringTap(
                    child: SizedBox(
                      height: 54,
                      child: FilledButton(
                        key: const ValueKey('onboarding_primary_button'),
                        onPressed: _handleNext,
                        style: FilledButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size.fromHeight(54),
                          shape: const StadiumBorder(),
                        ),
                        child: disableAnimations
                            ? Text(
                                _isLastSlide
                                    ? l10n.onboardingGetStarted
                                    : l10n.onboardingNext,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : AnimatedSwitcher(
                                duration: const Duration(milliseconds: 180),
                                child: Text(
                                  _isLastSlide
                                      ? l10n.onboardingGetStarted
                                      : l10n.onboardingNext,
                                  key: ValueKey<bool>(_isLastSlide),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
