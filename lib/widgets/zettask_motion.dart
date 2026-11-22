import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:flutter/physics.dart';
import 'package:material_ui/material_ui.dart';

import '../core/theme/app_theme.dart';

class ZettaskSpringCurve extends Curve {
  const ZettaskSpringCurve({
    this.mass = 1.0,
    this.stiffness = 420.0,
    this.damping = 24.0,
    this.simulationSeconds = 0.45,
  });

  static const ZettaskSpringCurve expressive = ZettaskSpringCurve(
    mass: 1.0,
    stiffness: 420.0,
    damping: 22.0,
    simulationSeconds: 0.46,
  );

  static const ZettaskSpringCurve snappy = ZettaskSpringCurve(
    mass: 1.0,
    stiffness: 520.0,
    damping: 28.0,
    simulationSeconds: 0.42,
  );

  final double mass;
  final double stiffness;
  final double damping;
  final double simulationSeconds;

  @override
  double transformInternal(double t) {
    if (t <= 0.0) return 0.0;
    if (t >= 1.0) return 1.0;

    final simulation = SpringSimulation(
      SpringDescription(mass: mass, stiffness: stiffness, damping: damping),
      0.0,
      1.0,
      0.0,
    );
    final simValue = simulation.x(t * simulationSeconds);
    // Smoothly converge to exact 1.0 on the tail so bounded animations terminate without jump.
    if (t > 0.85) {
      final blend = (t - 0.85) / 0.15;
      return simValue + (1.0 - simValue) * blend;
    }
    return simValue;
  }
}

class ZettaskSpringTap extends StatefulWidget {
  const ZettaskSpringTap({
    super.key,
    required this.child,
    this.pressedScale = 0.95,
    this.enabled = true,
  });

  final Widget child;
  final double pressedScale;
  final bool enabled;

  @override
  State<ZettaskSpringTap> createState() => _ZettaskSpringTapState();
}

class _ZettaskSpringTapState extends State<ZettaskSpringTap> {
  bool _isPressed = false;

  void _setPressed(bool next) {
    if (!widget.enabled || _isPressed == next) return;
    setState(() => _isPressed = next);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled || MediaQuery.disableAnimationsOf(context)) {
      return widget.child;
    }

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _setPressed(true),
      onPointerUp: (_) => _setPressed(false),
      onPointerCancel: (_) => _setPressed(false),
      child: AnimatedScale(
        scale: _isPressed ? widget.pressedScale : 1.0,
        duration: _isPressed
            ? const Duration(milliseconds: 110)
            : const Duration(milliseconds: 280),
        curve: _isPressed ? Curves.easeOutCubic : ZettaskSpringCurve.snappy,
        child: widget.child,
      ),
    );
  }
}

class ZettaskSpringCheckBounce extends StatefulWidget {
  const ZettaskSpringCheckBounce({
    super.key,
    required this.stateKey,
    required this.child,
    this.minScale = 0.84,
    this.duration = const Duration(milliseconds: 340),
  });

  final Object? stateKey;
  final Widget child;
  final double minScale;
  final Duration duration;

  @override
  State<ZettaskSpringCheckBounce> createState() =>
      _ZettaskSpringCheckBounceState();
}

class _ZettaskSpringCheckBounceState extends State<ZettaskSpringCheckBounce>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: 1.0,
    );
  }

  @override
  void didUpdateWidget(covariant ZettaskSpringCheckBounce oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
    if (oldWidget.stateKey != widget.stateKey) {
      if (MediaQuery.disableAnimationsOf(context)) {
        _controller.value = 1.0;
      } else {
        _controller.forward(from: 0.0);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final t = _controller.value;
        if (t >= 1.0) return child!;
        final double scale;
        if (t < 0.22) {
          final downProgress = Curves.easeOut.transform(t / 0.22);
          scale = lerpDouble(1.0, widget.minScale, downProgress) ?? 1.0;
        } else {
          final upProgress = ZettaskSpringCurve.expressive
              .transform(((t - 0.22) / 0.78).clamp(0.0, 1.0));
          scale = lerpDouble(widget.minScale, 1.0, upProgress) ?? 1.0;
        }
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
    );
  }
}

class ZettaskPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  ZettaskPinnedHeaderDelegate({
    required this.height,
    this.child,
    this.builder,
    this.backgroundColor,
    this.padding = const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
  }) : assert(
          child != null || builder != null,
          'Provide either child or builder.',
        );

  final double height;
  final Widget? child;
  final Widget Function(BuildContext context, bool isPinned)? builder;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final isAmoled = AppTheme.isAmoled(theme);
    final isPinned = shrinkOffset > 0.5 || overlapsContent;
    final baseSurface = backgroundColor ?? theme.scaffoldBackgroundColor;
    final pinnedSurface = backgroundColor ??
        (isAmoled ? AppTheme.amoledBackground : colorScheme.surfaceContainerLow);
    final surfaceColor = isPinned ? pinnedSurface : baseSurface;
    final dividerColor = isAmoled
        ? colorScheme.outline
        : colorScheme.outlineVariant.withValues(alpha: 0.45);
    final content = builder != null ? builder!(context, isPinned) : child!;

    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(color: surfaceColor),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: padding,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: content,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 1,
              child: disableAnimations
                  ? Opacity(
                      opacity: isPinned ? 1.0 : 0.0,
                      child: ColoredBox(color: dividerColor),
                    )
                  : AnimatedOpacity(
                      opacity: isPinned ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      child: ColoredBox(color: dividerColor),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant ZettaskPinnedHeaderDelegate oldDelegate) {
    return oldDelegate.height != height ||
        oldDelegate.child != child ||
        oldDelegate.builder != builder ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.padding != padding;
  }
}

class ZettaskLineReveal extends StatefulWidget {
  const ZettaskLineReveal({
    super.key,
    required this.index,
    required this.child,
    this.maxStaggerIndex = 8,
    this.duration = const Duration(milliseconds: 260),
    this.stepDelay = const Duration(milliseconds: 40),
    this.verticalOffset = 10.0,
  });

  final int index;
  final Widget child;
  final int maxStaggerIndex;
  final Duration duration;
  final Duration stepDelay;
  final double verticalOffset;

  @override
  State<ZettaskLineReveal> createState() => _ZettaskLineRevealState();
}

class _ZettaskLineRevealState extends State<ZettaskLineReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _progress;
  bool _hasStarted = false;

  bool get _shouldAnimate => widget.index < widget.maxStaggerIndex;

  @override
  void initState() {
    super.initState();
    final clampedIndex = math.min(
      math.max(0, widget.index),
      widget.maxStaggerIndex,
    );
    final delayMs =
        _shouldAnimate ? clampedIndex * widget.stepDelay.inMilliseconds : 0;
    final revealMs = math.max(1, widget.duration.inMilliseconds);
    final totalMs = delayMs + revealMs;

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalMs),
    );
    final startFrac = (delayMs / totalMs).clamp(0.0, 0.95);
    _progress = CurvedAnimation(
      parent: _controller,
      curve: Interval(startFrac, 1.0, curve: ZettaskSpringCurve.snappy),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (disableAnimations || !_shouldAnimate) {
      _controller.value = 1.0;
      _hasStarted = true;
      return;
    }
    if (!_hasStarted) {
      _hasStarted = true;
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context) || !_shouldAnimate) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: _progress,
      child: widget.child,
      builder: (context, child) {
        final t = _progress.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1.0 - t) * widget.verticalOffset),
            child: child,
          ),
        );
      },
    );
  }
}

class ZettaskStackingCard extends StatefulWidget {
  const ZettaskStackingCard({
    super.key,
    required this.child,
    this.scrollController,
    this.minScale = 0.96,
    this.minOpacity = 0.85,
    this.threshold = 110.0,
  });

  final Widget child;
  final ScrollController? scrollController;
  final double minScale;
  final double minOpacity;
  final double threshold;

  @override
  State<ZettaskStackingCard> createState() => _ZettaskStackingCardState();
}

class _ZettaskStackingCardState extends State<ZettaskStackingCard> {
  ScrollPosition? _attachedPosition;
  ScrollController? _attachedController;
  double _collapseFactor = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reattachScrollListener();
  }

  @override
  void didUpdateWidget(covariant ZettaskStackingCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.scrollController != widget.scrollController) {
      _reattachScrollListener();
    }
  }

  void _detachListeners() {
    _attachedController?.removeListener(_onScroll);
    _attachedPosition?.removeListener(_onScroll);
    _attachedController = null;
    _attachedPosition = null;
  }

  void _reattachScrollListener() {
    _detachListeners();
    if (MediaQuery.disableAnimationsOf(context)) {
      if (_collapseFactor != 0.0) {
        _collapseFactor = 0.0;
      }
      return;
    }

    if (widget.scrollController != null) {
      _attachedController = widget.scrollController;
      _attachedController!.addListener(_onScroll);
    } else {
      final scrollable = Scrollable.maybeOf(context);
      if (scrollable != null) {
        _attachedPosition = scrollable.position;
        _attachedPosition!.addListener(_onScroll);
      }
    }
  }

  void _onScroll() {
    if (!mounted) return;
    if (widget.scrollController != null && !widget.scrollController!.hasClients) {
      return;
    }

    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.attached) return;

    final scrollableState = Scrollable.maybeOf(context);
    final ancestor = scrollableState?.context.findRenderObject();
    if (ancestor is! RenderBox || !ancestor.attached) return;

    final double topOffset;
    try {
      topOffset = renderObject
          .localToGlobal(Offset.zero, ancestor: ancestor)
          .dy;
    } catch (_) {
      return;
    }

    final threshold = widget.threshold <= 0 ? 1.0 : widget.threshold;
    final raw = ((threshold - topOffset) / threshold).clamp(0.0, 1.0);
    final eased = Curves.easeOut.transform(raw);

    if ((eased - _collapseFactor).abs() > 0.005) {
      setState(() => _collapseFactor = eased);
    }
  }

  @override
  void dispose() {
    _detachListeners();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context) || _collapseFactor <= 0.001) {
      return widget.child;
    }

    final scale = lerpDouble(1.0, widget.minScale, _collapseFactor) ?? 1.0;
    final opacity =
        lerpDouble(1.0, widget.minOpacity, _collapseFactor) ?? 1.0;

    return Transform.scale(
      scale: scale,
      alignment: Alignment.topCenter,
      child: Opacity(
        opacity: opacity.clamp(0.0, 1.0),
        child: widget.child,
      ),
    );
  }
}

class ZettaskFocusFrameSlider extends StatefulWidget {
  const ZettaskFocusFrameSlider({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.selectedIndex = 0,
    this.onPageChanged,
    this.onItemTap,
    this.height = 128.0,
    this.viewportFraction = 0.78,
    this.unfocusedScale = 0.90,
    this.unfocusedOpacity = 0.65,
  });

  final int itemCount;
  final Widget Function(BuildContext context, int index, bool isFocused)
      itemBuilder;
  final int selectedIndex;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onItemTap;
  final double height;
  final double viewportFraction;
  final double unfocusedScale;
  final double unfocusedOpacity;

  @override
  State<ZettaskFocusFrameSlider> createState() =>
      _ZettaskFocusFrameSliderState();
}

class _ZettaskFocusFrameSliderState extends State<ZettaskFocusFrameSlider> {
  late final PageController _pageController;
  late int _focusedIndex;

  int _clampIndex(int raw) {
    if (widget.itemCount <= 0) return 0;
    return raw.clamp(0, widget.itemCount - 1);
  }

  @override
  void initState() {
    super.initState();
    _focusedIndex = _clampIndex(widget.selectedIndex);
    _pageController = PageController(
      initialPage: _focusedIndex,
      viewportFraction: widget.viewportFraction,
    );
  }

  @override
  void didUpdateWidget(covariant ZettaskFocusFrameSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    final nextSelected = _clampIndex(widget.selectedIndex);
    if (oldWidget.selectedIndex != widget.selectedIndex &&
        nextSelected != _focusedIndex) {
      _focusedIndex = nextSelected;
      if (_pageController.hasClients) {
        if (MediaQuery.disableAnimationsOf(context)) {
          _pageController.jumpToPage(nextSelected);
        } else {
          _pageController.animateToPage(
            nextSelected,
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleTapItem(int index) {
    if (_focusedIndex != index && _pageController.hasClients) {
      if (MediaQuery.disableAnimationsOf(context)) {
        _pageController.jumpToPage(index);
      } else {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
        );
      }
    }
    widget.onItemTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isAmoled = AppTheme.isAmoled(theme);
    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.itemCount,
            onPageChanged: (index) {
              if (_focusedIndex != index) {
                setState(() => _focusedIndex = index);
              }
              widget.onPageChanged?.call(index);
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, _) {
                  final double currentPage;
                  if (!disableAnimations &&
                      _pageController.hasClients &&
                      _pageController.position.haveDimensions) {
                    currentPage =
                        _pageController.page ?? _focusedIndex.toDouble();
                  } else {
                    currentPage = _focusedIndex.toDouble();
                  }

                  final distance = (currentPage - index).abs().clamp(0.0, 1.0);
                  final isFocused = distance < 0.35;
                  final scale =
                      lerpDouble(1.0, widget.unfocusedScale, distance) ?? 1.0;
                  final opacity =
                      lerpDouble(1.0, widget.unfocusedOpacity, distance) ?? 1.0;

                  return Center(
                    child: Transform.scale(
                      scale: scale,
                      child: Opacity(
                        opacity: opacity.clamp(0.0, 1.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          child: Material(
                            color: isFocused
                                ? colorScheme.surfaceContainerLow
                                : colorScheme.surfaceContainer,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(22),
                              side: isFocused
                                  ? BorderSide(
                                      color: colorScheme.primary,
                                      width: 2,
                                    )
                                  : isAmoled
                                      ? BorderSide(
                                          color: colorScheme.outline,
                                          width: 1,
                                        )
                                      : BorderSide.none,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => _handleTapItem(index),
                              child: widget.itemBuilder(
                                context,
                                index,
                                isFocused,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        if (widget.itemCount > 1) ...[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.itemCount, (index) {
              final isActive = index == _focusedIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: disableAnimations
                    ? Container(
                        width: isActive ? 22 : 7,
                        height: 7,
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
                        width: isActive ? 22 : 7,
                        height: 7,
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
        ],
      ],
    );
  }
}
