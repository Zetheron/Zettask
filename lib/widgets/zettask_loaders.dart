import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../core/theme/app_theme.dart';

bool _isAmoledTheme(ThemeData theme) {
  return theme.brightness == Brightness.dark &&
      theme.scaffoldBackgroundColor == AppTheme.amoledBackground;
}

class ZettaskSpinnerArc extends StatefulWidget {
  const ZettaskSpinnerArc({
    super.key,
    this.size = 20.0,
    this.strokeWidth = 2.2,
    this.color,
    this.trackColor,
    this.duration = const Duration(milliseconds: 900),
    this.semanticsLabel,
  });

  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? trackColor;
  final Duration duration;
  final String? semanticsLabel;

  @override
  State<ZettaskSpinnerArc> createState() => _ZettaskSpinnerArcState();
}

class _ZettaskSpinnerArcState extends State<ZettaskSpinnerArc>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimationState();
  }

  @override
  void didUpdateWidget(covariant ZettaskSpinnerArc oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _syncAnimationState();
    }
  }

  void _syncAnimationState() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller
        ..stop()
        ..value = 0.25;
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveColor = widget.color ?? colorScheme.primary;
    final effectiveTrackColor =
        widget.trackColor ?? effectiveColor.withValues(alpha: 0.18);

    return Semantics(
      label: widget.semanticsLabel,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _SpinnerArcPainter(
                progress: _controller.value,
                color: effectiveColor,
                trackColor: effectiveTrackColor,
                strokeWidth: widget.strokeWidth,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SpinnerArcPainter extends CustomPainter {
  const _SpinnerArcPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.max(0.0, (math.min(size.width, size.height) - strokeWidth) / 2);

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final startAngle = (progress * 2 * math.pi) - (math.pi / 2);
    const sweepAngle = math.pi * 1.38;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _SpinnerArcPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class ZettaskIndeterminateBar extends StatefulWidget {
  const ZettaskIndeterminateBar({
    super.key,
    this.height = 2.0,
    this.color,
    this.trackColor,
    this.duration = const Duration(milliseconds: 1300),
  });

  final double height;
  final Color? color;
  final Color? trackColor;
  final Duration duration;

  @override
  State<ZettaskIndeterminateBar> createState() =>
      _ZettaskIndeterminateBarState();
}

class _ZettaskIndeterminateBarState extends State<ZettaskIndeterminateBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimationState();
  }

  @override
  void didUpdateWidget(covariant ZettaskIndeterminateBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _syncAnimationState();
    }
  }

  void _syncAnimationState() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller
        ..stop()
        ..value = 0.5;
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveColor = widget.color ?? colorScheme.primary;
    final effectiveTrack =
        widget.trackColor ?? effectiveColor.withValues(alpha: 0.14);
    final reducedMotion = MediaQuery.disableAnimationsOf(context);

    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _IndeterminateBarPainter(
              progress: _controller.value,
              color: effectiveColor,
              trackColor: effectiveTrack,
              reducedMotion: reducedMotion,
            ),
          );
        },
      ),
    );
  }
}

class _IndeterminateBarPainter extends CustomPainter {
  const _IndeterminateBarPainter({
    required this.progress,
    required this.color,
    required this.trackColor,
    required this.reducedMotion,
  });

  final double progress;
  final Color color;
  final Color trackColor;
  final bool reducedMotion;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Radius.circular(size.height / 2);
    final trackRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      radius,
    );
    canvas.drawRRect(trackRect, Paint()..color = trackColor);

    final double startFrac;
    final double endFrac;
    if (reducedMotion) {
      startFrac = 0.30;
      endFrac = 0.70;
    } else {
      final eased = Curves.easeInOutCubic.transform(progress);
      final segmentWidth = 0.24 + (0.16 * math.sin(progress * math.pi));
      final head = -segmentWidth + eased * (1.0 + segmentWidth);
      startFrac = head.clamp(0.0, 1.0);
      endFrac = (head + segmentWidth).clamp(0.0, 1.0);
    }

    if (endFrac <= startFrac) return;

    final barRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        startFrac * size.width,
        0,
        endFrac * size.width,
        size.height,
      ),
      radius,
    );
    canvas.drawRRect(barRect, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _IndeterminateBarPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.reducedMotion != reducedMotion;
  }
}

class ZettaskSkeletonShimmer extends StatefulWidget {
  const ZettaskSkeletonShimmer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 1400),
    this.baseColor,
    this.highlightColor,
  });

  final Widget child;
  final Duration duration;
  final Color? baseColor;
  final Color? highlightColor;

  static ({Color base, Color highlight}) resolveColors(ThemeData theme) {
    if (_isAmoledTheme(theme)) {
      return (
        base: const Color(0xFF121212),
        highlight: const Color(0xFF1F1F1F),
      );
    }
    if (theme.brightness == Brightness.dark) {
      return (
        base: const Color(0xFF1C1C1C),
        highlight: const Color(0xFF2B2B2B),
      );
    }
    return (
      base: const Color(0xFFEBEAE8),
      highlight: const Color(0xFFF7F6F5),
    );
  }

  @override
  State<ZettaskSkeletonShimmer> createState() => _ZettaskSkeletonShimmerState();
}

class _ZettaskSkeletonShimmerState extends State<ZettaskSkeletonShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimationState();
  }

  @override
  void didUpdateWidget(covariant ZettaskSkeletonShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _syncAnimationState();
    }
  }

  void _syncAnimationState() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller
        ..stop()
        ..value = 0.5;
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = ZettaskSkeletonShimmer.resolveColors(theme);
    final base = widget.baseColor ?? palette.base;
    final highlight = widget.highlightColor ?? palette.highlight;
    final reducedMotion = MediaQuery.disableAnimationsOf(context);

    if (reducedMotion) {
      return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => LinearGradient(
          colors: [base, base],
        ).createShader(bounds),
        child: widget.child,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        final slide = -1.2 + (_controller.value * 2.4);
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(slide - 0.65, -0.2),
              end: Alignment(slide + 0.65, 0.2),
              colors: [base, highlight, base],
              stops: const [0.15, 0.5, 0.85],
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}

class ZettaskTaskListSkeleton extends StatelessWidget {
  const ZettaskTaskListSkeleton({
    super.key,
    this.itemCount = 4,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 24),
    this.shrinkWrap = false,
    this.physics,
  });

  final int itemCount;
  final EdgeInsetsGeometry padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  static const List<double> _titleFractions = [0.72, 0.58, 0.80, 0.64];
  static const List<double> _subtitleFractions = [0.42, 0.34, 0.48, 0.38];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isAmoled = AppTheme.isAmoled(theme);

    return ListView.separated(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics ??
          (shrinkWrap ? const NeverScrollableScrollPhysics() : null),
      itemCount: itemCount,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final titleFrac = _titleFractions[index % _titleFractions.length];
        final subtitleFrac =
            _subtitleFractions[index % _subtitleFractions.length];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
            border: isAmoled
                ? Border.all(color: colorScheme.outline, width: 1)
                : null,
          ),
          child: ZettaskSkeletonShimmer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: SizedBox(width: 20, height: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FractionallySizedBox(
                        widthFactor: titleFrac,
                        child: Container(
                          height: 13,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      FractionallySizedBox(
                        widthFactor: subtitleFrac,
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
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
      },
    );
  }
}

class ZettaskTextShimmer extends StatefulWidget {
  const ZettaskTextShimmer({
    super.key,
    required this.text,
    this.style,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 1400),
    this.maxLines,
    this.overflow,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final Color? baseColor;
  final Color? highlightColor;
  final Duration duration;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  State<ZettaskTextShimmer> createState() => _ZettaskTextShimmerState();
}

class _ZettaskTextShimmerState extends State<ZettaskTextShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimationState();
  }

  @override
  void didUpdateWidget(covariant ZettaskTextShimmer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _syncAnimationState();
    }
  }

  void _syncAnimationState() {
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller
        ..stop()
        ..value = 0.5;
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final resolvedStyle = widget.style ?? theme.textTheme.bodySmall;
    final base = widget.baseColor ??
        resolvedStyle?.color ??
        colorScheme.onSurfaceVariant;
    final highlight = widget.highlightColor ??
        Color.lerp(
          base,
          theme.brightness == Brightness.dark
              ? colorScheme.onSurface
              : colorScheme.primary,
          0.65,
        ) ??
        colorScheme.primary;

    final textWidget = Text(
      widget.text,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      textAlign: widget.textAlign,
      style: resolvedStyle?.copyWith(color: base) ?? TextStyle(color: base),
    );

    if (MediaQuery.disableAnimationsOf(context)) {
      return textWidget;
    }

    return AnimatedBuilder(
      animation: _controller,
      child: Text(
        widget.text,
        maxLines: widget.maxLines,
        overflow: widget.overflow,
        textAlign: widget.textAlign,
        style: resolvedStyle?.copyWith(color: Colors.white) ??
            const TextStyle(color: Colors.white),
      ),
      builder: (context, child) {
        final slide = -1.2 + (_controller.value * 2.4);
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment(slide - 0.55, 0),
              end: Alignment(slide + 0.55, 0),
              colors: [base, highlight, base],
              stops: const [0.15, 0.5, 0.85],
            ).createShader(bounds);
          },
          child: child,
        );
      },
    );
  }
}
