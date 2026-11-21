import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:material_ui/material_ui.dart';

double _intervalProgress(double value, double start, double end) {
  if (value <= start) return 0.0;
  if (value >= end) return 1.0;
  return (value - start) / (end - start);
}

class QuickTaskIllustration extends StatefulWidget {
  const QuickTaskIllustration({
    super.key,
    this.width = 248,
    this.height = 196,
  });

  final double width;
  final double height;

  @override
  State<QuickTaskIllustration> createState() => _QuickTaskIllustrationState();
}

class _QuickTaskIllustrationState extends State<QuickTaskIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller
        ..stop()
        ..value = 0.68;
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

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _QuickTaskPainter(
              progress: _controller.value,
              colorScheme: colorScheme,
            ),
          );
        },
      ),
    );
  }
}

class _QuickTaskPainter extends CustomPainter {
  const _QuickTaskPainter({
    required this.progress,
    required this.colorScheme,
  });

  final double progress;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final cardWidth = size.width - 16;
    const cardHeight = 48.0;
    const cardGap = 12.0;
    final startY = (size.height - (cardHeight * 3 + cardGap * 2)) / 2;

    // Reset phase fades hero card gently back before next loop
    final resetOut = Curves.easeInOut.transform(
      _intervalProgress(progress, 0.88, 1.0),
    );
    final slideIn = Curves.easeOutCubic.transform(
      _intervalProgress(progress, 0.02, 0.24),
    );
    final fillCircle = Curves.easeOutCubic.transform(
      _intervalProgress(progress, 0.28, 0.44),
    );
    final drawCheck = Curves.easeOutCubic.transform(
      _intervalProgress(progress, 0.40, 0.60),
    );
    final dimText = Curves.easeOut.transform(
      _intervalProgress(progress, 0.46, 0.66),
    );

    final heroEffectiveFill = (fillCircle * (1.0 - resetOut)).clamp(0.0, 1.0);
    final heroEffectiveCheck = (drawCheck * (1.0 - resetOut)).clamp(0.0, 1.0);
    final heroEffectiveDim = (dimText * (1.0 - resetOut)).clamp(0.0, 1.0);

    // Card 1 (ambient completed item)
    _drawStaticCard(
      canvas: canvas,
      rect: Rect.fromLTWH(8, startY, cardWidth, cardHeight),
      checked: true,
      titleWidthFrac: 0.56,
      subtitleWidthFrac: 0.30,
      opacity: 0.72,
    );

    // Card 2 (hero animated card)
    final slideOffsetX = lerpDouble(18.0, 0.0, slideIn) ?? 0.0;
    final heroRect = Rect.fromLTWH(
      8 + slideOffsetX,
      startY + cardHeight + cardGap,
      cardWidth,
      cardHeight,
    );
    _drawHeroCard(
      canvas: canvas,
      rect: heroRect,
      fillProgress: heroEffectiveFill,
      checkProgress: heroEffectiveCheck,
      dimProgress: heroEffectiveDim,
    );

    // Card 3 (ambient upcoming item)
    _drawStaticCard(
      canvas: canvas,
      rect: Rect.fromLTWH(
        8,
        startY + (cardHeight + cardGap) * 2,
        cardWidth,
        cardHeight,
      ),
      checked: false,
      titleWidthFrac: 0.62,
      subtitleWidthFrac: 0.36,
      opacity: 0.78,
    );
  }

  void _drawStaticCard({
    required Canvas canvas,
    required Rect rect,
    required bool checked,
    required double titleWidthFrac,
    required double subtitleWidthFrac,
    required double opacity,
  }) {
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(13));
    canvas.drawRRect(
      rrect,
      Paint()..color = colorScheme.surface.withValues(alpha: opacity),
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = colorScheme.outline.withValues(alpha: opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    final circleCenter = Offset(rect.left + 22, rect.center.dy);
    if (checked) {
      canvas.drawCircle(
        circleCenter,
        8.5,
        Paint()..color = colorScheme.primary.withValues(alpha: 0.22),
      );
      canvas.drawCircle(
        circleCenter,
        8.5,
        Paint()
          ..color = colorScheme.primary.withValues(alpha: 0.65)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
    } else {
      canvas.drawCircle(
        circleCenter,
        8.5,
        Paint()
          ..color = colorScheme.onSurfaceVariant.withValues(alpha: 0.45)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
    }

    final textLeft = rect.left + 42;
    final available = rect.right - textLeft - 14;
    final barColor = colorScheme.onSurfaceVariant.withValues(
      alpha: checked ? 0.22 : 0.32,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(textLeft, rect.top + 14, available * titleWidthFrac, 7),
        const Radius.circular(4),
      ),
      Paint()..color = barColor,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          textLeft,
          rect.top + 27,
          available * subtitleWidthFrac,
          5,
        ),
        const Radius.circular(3),
      ),
      Paint()..color = colorScheme.outline.withValues(alpha: 0.8),
    );
  }

  void _drawHeroCard({
    required Canvas canvas,
    required Rect rect,
    required double fillProgress,
    required double checkProgress,
    required double dimProgress,
  }) {
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(13));
    canvas.drawRRect(rrect, Paint()..color = colorScheme.surface);

    final borderColor = Color.lerp(
      colorScheme.outline,
      colorScheme.primary,
      0.35 + (fillProgress * 0.45),
    )!;
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.25,
    );

    final circleCenter = Offset(rect.left + 22, rect.center.dy);
    const circleRadius = 9.5;

    // Outer ring
    canvas.drawCircle(
      circleCenter,
      circleRadius,
      Paint()
        ..color = colorScheme.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );

    // Accent fill
    if (fillProgress > 0.01) {
      canvas.drawCircle(
        circleCenter,
        circleRadius * fillProgress,
        Paint()..color = colorScheme.primary,
      );
    }

    // Animated checkmark path
    if (checkProgress > 0.01) {
      final p1 = Offset(circleCenter.dx - 4.0, circleCenter.dy + 0.2);
      final p2 = Offset(circleCenter.dx - 1.1, circleCenter.dy + 3.2);
      final p3 = Offset(circleCenter.dx + 4.4, circleCenter.dy - 2.9);

      final checkPath = Path()
        ..moveTo(p1.dx, p1.dy)
        ..lineTo(p2.dx, p2.dy)
        ..lineTo(p3.dx, p3.dy);

      final metrics = checkPath.computeMetrics().toList();
      if (metrics.isNotEmpty) {
        final metric = metrics.first;
        final partial = metric.extractPath(0, metric.length * checkProgress);
        canvas.drawPath(
          partial,
          Paint()
            ..color = colorScheme.onPrimary
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.9
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round,
        );
      }
    }

    // Hero text lines
    final textLeft = rect.left + 42;
    final available = rect.right - textLeft - 14;
    final titleWidth = available * 0.74;
    final titleOpacity = lerpDouble(0.88, 0.36, dimProgress) ?? 0.88;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(textLeft, rect.top + 14, titleWidth, 7.5),
        const Radius.circular(4),
      ),
      Paint()..color = colorScheme.onSurface.withValues(alpha: titleOpacity),
    );

    if (dimProgress > 0.05) {
      final strikeY = rect.top + 17.75;
      canvas.drawLine(
        Offset(textLeft, strikeY),
        Offset(textLeft + titleWidth * dimProgress, strikeY),
        Paint()
          ..color = colorScheme.onSurfaceVariant.withValues(alpha: 0.7)
          ..strokeWidth = 1.3
          ..strokeCap = StrokeCap.round,
      );
    }

    // Small time pill chip
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(textLeft, rect.top + 27, 36, 6),
        const Radius.circular(3),
      ),
      Paint()
        ..color = colorScheme.primaryContainer.withValues(
          alpha: lerpDouble(1.0, 0.55, dimProgress) ?? 1.0,
        ),
    );
  }

  @override
  bool shouldRepaint(covariant _QuickTaskPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.colorScheme != colorScheme;
  }
}

class TimelineProjectIllustration extends StatefulWidget {
  const TimelineProjectIllustration({
    super.key,
    this.width = 248,
    this.height = 196,
  });

  final double width;
  final double height;

  @override
  State<TimelineProjectIllustration> createState() =>
      _TimelineProjectIllustrationState();
}

class _TimelineProjectIllustrationState
    extends State<TimelineProjectIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller
        ..stop()
        ..value = 0.72;
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

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _TimelineProjectPainter(
              progress: _controller.value,
              colorScheme: colorScheme,
            ),
          );
        },
      ),
    );
  }
}

class _TimelineProjectPainter extends CustomPainter {
  const _TimelineProjectPainter({
    required this.progress,
    required this.colorScheme,
  });

  final double progress;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final railX = 36.0;
    final topY = 18.0;
    final bottomY = size.height - 18.0;

    // Vertical timeline rail
    canvas.drawLine(
      Offset(railX, topY),
      Offset(railX, bottomY),
      Paint()
        ..color = colorScheme.outline
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );

    final resetFade = 1.0 -
        Curves.easeInOut.transform(_intervalProgress(progress, 0.88, 1.0));
    final block1T = Curves.easeOutCubic.transform(
      _intervalProgress(progress, 0.04, 0.24),
    );
    final calT = Curves.easeOutCubic.transform(
      _intervalProgress(progress, 0.22, 0.42),
    );
    final block2T = Curves.easeOutCubic.transform(
      _intervalProgress(progress, 0.40, 0.60),
    );
    final barFill = Curves.easeOutCubic.transform(
      _intervalProgress(progress, 0.48, 0.74),
    );

    final cardLeft = railX + 18.0;
    final cardWidth = size.width - cardLeft - 10.0;

    // 1. Task Block 1
    _drawTimelineBlock(
      canvas: canvas,
      railX: railX,
      rect: Rect.fromLTWH(cardLeft, 22, cardWidth, 44),
      reveal: block1T * resetFade,
      accentColor: colorScheme.primary,
      barWidthFrac: 0.68,
    );

    // 2. Calendar Event Badge
    _drawCalendarBadge(
      canvas: canvas,
      railX: railX,
      rect: Rect.fromLTWH(cardLeft, 78, cardWidth, 38),
      reveal: calT * resetFade,
    );

    // 3. Project Task Block 2 with mini progress bar
    _drawProjectBlock(
      canvas: canvas,
      railX: railX,
      rect: Rect.fromLTWH(cardLeft, 128, cardWidth, 48),
      reveal: block2T * resetFade,
      progressRatio: 0.25 + (barFill * 0.55),
    );

    // Active time indicator gliding smoothly down the rail
    final travelT = Curves.easeInOutSine.transform(
      _intervalProgress(progress, 0.05, 0.85),
    );
    final indicatorY = lerpDouble(topY + 12, bottomY - 12, travelT) ?? topY;

    canvas.drawLine(
      Offset(railX + 6, indicatorY),
      Offset(cardLeft - 4, indicatorY),
      Paint()
        ..color = colorScheme.primary.withValues(alpha: 0.75)
        ..strokeWidth = 1.5
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(
      Offset(railX, indicatorY),
      4.5,
      Paint()..color = colorScheme.primary,
    );
    canvas.drawCircle(
      Offset(railX, indicatorY),
      2.0,
      Paint()..color = colorScheme.onPrimary,
    );
  }

  void _drawTimelineBlock({
    required Canvas canvas,
    required double railX,
    required Rect rect,
    required double reveal,
    required Color accentColor,
    required double barWidthFrac,
  }) {
    if (reveal <= 0.01) return;
    final dy = (1.0 - reveal) * 8.0;
    final shifted = rect.shift(Offset(0, dy));

    // Left time label bone
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(4, shifted.center.dy - 3, railX - 14, 6),
        const Radius.circular(3),
      ),
      Paint()..color = colorScheme.onSurfaceVariant.withValues(alpha: 0.35 * reveal),
    );

    final rrect = RRect.fromRectAndRadius(shifted, const Radius.circular(12));
    canvas.drawRRect(
      rrect,
      Paint()..color = colorScheme.surface.withValues(alpha: reveal),
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = colorScheme.outline.withValues(alpha: reveal)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Accent pill strip
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(shifted.left + 10, shifted.top + 11, 3.5, 22),
        const Radius.circular(2),
      ),
      Paint()..color = accentColor.withValues(alpha: reveal),
    );

    final textLeft = shifted.left + 22;
    final available = shifted.right - textLeft - 12;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(textLeft, shifted.top + 13, available * barWidthFrac, 7),
        const Radius.circular(3.5),
      ),
      Paint()..color = colorScheme.onSurface.withValues(alpha: 0.78 * reveal),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(textLeft, shifted.top + 25, available * 0.40, 5),
        const Radius.circular(2.5),
      ),
      Paint()..color = colorScheme.onSurfaceVariant.withValues(alpha: 0.35 * reveal),
    );
  }

  void _drawCalendarBadge({
    required Canvas canvas,
    required double railX,
    required Rect rect,
    required double reveal,
  }) {
    if (reveal <= 0.01) return;
    final dy = (1.0 - reveal) * 8.0;
    final shifted = rect.shift(Offset(0, dy));

    final rrect = RRect.fromRectAndRadius(shifted, const Radius.circular(11));
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = colorScheme.primaryContainer.withValues(alpha: 0.45 * reveal),
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = colorScheme.primary.withValues(alpha: 0.45 * reveal)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // Mini calendar icon glyph
    final iconRect = Rect.fromLTWH(shifted.left + 11, shifted.center.dy - 7, 14, 14);
    canvas.drawRRect(
      RRect.fromRectAndRadius(iconRect, const Radius.circular(3)),
      Paint()
        ..color = colorScheme.primary.withValues(alpha: reveal)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.3,
    );
    canvas.drawLine(
      Offset(iconRect.left, iconRect.top + 4.5),
      Offset(iconRect.right, iconRect.top + 4.5),
      Paint()
        ..color = colorScheme.primary.withValues(alpha: reveal)
        ..strokeWidth = 1.2,
    );

    // Event title bone + small badge dot
    final textLeft = shifted.left + 33;
    final available = shifted.right - textLeft - 12;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(textLeft, shifted.center.dy - 3.5, available * 0.62, 7),
        const Radius.circular(3.5),
      ),
      Paint()..color = colorScheme.primary.withValues(alpha: 0.8 * reveal),
    );
    canvas.drawCircle(
      Offset(shifted.right - 14, shifted.center.dy),
      3.5,
      Paint()..color = colorScheme.primary.withValues(alpha: reveal),
    );
  }

  void _drawProjectBlock({
    required Canvas canvas,
    required double railX,
    required Rect rect,
    required double reveal,
    required double progressRatio,
  }) {
    if (reveal <= 0.01) return;
    final dy = (1.0 - reveal) * 8.0;
    final shifted = rect.shift(Offset(0, dy));

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(4, shifted.center.dy - 3, railX - 14, 6),
        const Radius.circular(3),
      ),
      Paint()..color = colorScheme.onSurfaceVariant.withValues(alpha: 0.35 * reveal),
    );

    final rrect = RRect.fromRectAndRadius(shifted, const Radius.circular(12));
    canvas.drawRRect(
      rrect,
      Paint()..color = colorScheme.surface.withValues(alpha: reveal),
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = colorScheme.outline.withValues(alpha: reveal)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    final contentLeft = shifted.left + 12;
    final contentWidth = shifted.width - 24;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(contentLeft, shifted.top + 12, contentWidth * 0.56, 7),
        const Radius.circular(3.5),
      ),
      Paint()..color = colorScheme.onSurface.withValues(alpha: 0.8 * reveal),
    );

    // Project progress track & animated fill
    final barY = shifted.top + 30;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(contentLeft, barY, contentWidth, 5),
        const Radius.circular(999),
      ),
      Paint()..color = colorScheme.outline.withValues(alpha: reveal),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          contentLeft,
          barY,
          contentWidth * progressRatio.clamp(0.0, 1.0),
          5,
        ),
        const Radius.circular(999),
      ),
      Paint()..color = colorScheme.primary.withValues(alpha: reveal),
    );
  }

  @override
  bool shouldRepaint(covariant _TimelineProjectPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.colorScheme != colorScheme;
  }
}

class OfflinePrivacyIllustration extends StatefulWidget {
  const OfflinePrivacyIllustration({
    super.key,
    this.width = 224,
    this.height = 196,
  });

  final double width;
  final double height;

  @override
  State<OfflinePrivacyIllustration> createState() =>
      _OfflinePrivacyIllustrationState();
}

class _OfflinePrivacyIllustrationState extends State<OfflinePrivacyIllustration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller
        ..stop()
        ..value = 0.42;
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

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return CustomPaint(
            painter: _OfflinePrivacyPainter(
              progress: _controller.value,
              colorScheme: colorScheme,
            ),
          );
        },
      ),
    );
  }
}

class _OfflinePrivacyPainter extends CustomPainter {
  const _OfflinePrivacyPainter({
    required this.progress,
    required this.colorScheme,
  });

  final double progress;
  final ColorScheme colorScheme;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.min(size.width, size.height) * 0.45;
    const minRadius = 38.0;

    // Two staggered expanding pulse rings
    for (final phaseShift in const [0.0, 0.5]) {
      final t = (progress + phaseShift) % 1.0;
      final eased = Curves.easeOutCubic.transform(t);
      final radius = lerpDouble(minRadius, maxRadius, eased) ?? minRadius;
      final alpha = (1.0 - eased) * 0.42;

      if (alpha > 0.01) {
        canvas.drawCircle(
          center,
          radius,
          Paint()
            ..color = colorScheme.primary.withValues(alpha: alpha)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.35,
        );
      }
    }

    // Minimalist rounded center surface card
    const badgeSize = 76.0;
    final badgeRect = Rect.fromCenter(
      center: center,
      width: badgeSize,
      height: badgeSize,
    );
    final badgeRRect = RRect.fromRectAndRadius(
      badgeRect,
      const Radius.circular(22),
    );
    canvas.drawRRect(badgeRRect, Paint()..color = colorScheme.surface);
    canvas.drawRRect(
      badgeRRect,
      Paint()
        ..color = colorScheme.outline
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.25,
    );

    // Shield silhouette
    final shieldPath = Path()
      ..moveTo(center.dx, center.dy - 21)
      ..lineTo(center.dx + 16, center.dy - 14)
      ..lineTo(center.dx + 16, center.dy - 1)
      ..quadraticBezierTo(
        center.dx + 16,
        center.dy + 13,
        center.dx,
        center.dy + 21,
      )
      ..quadraticBezierTo(
        center.dx - 16,
        center.dy + 13,
        center.dx - 16,
        center.dy - 1,
      )
      ..lineTo(center.dx - 16, center.dy - 14)
      ..close();

    canvas.drawPath(
      shieldPath,
      Paint()..color = colorScheme.primaryContainer.withValues(alpha: 0.7),
    );
    canvas.drawPath(
      shieldPath,
      Paint()
        ..color = colorScheme.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..strokeJoin = StrokeJoin.round,
    );

    // Crisp checkmark inside shield
    final checkPath = Path()
      ..moveTo(center.dx - 6.0, center.dy + 0.5)
      ..lineTo(center.dx - 1.5, center.dy + 5.0)
      ..lineTo(center.dx + 7.0, center.dy - 4.5);

    canvas.drawPath(
      checkPath,
      Paint()
        ..color = colorScheme.primary
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant _OfflinePrivacyPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.colorScheme != colorScheme;
  }
}
