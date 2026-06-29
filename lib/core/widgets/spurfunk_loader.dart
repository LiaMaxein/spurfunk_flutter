import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Red partial-circle loader matching the Spurfunk splash mockup.
class SpurfunkArcLoader extends StatefulWidget {
  const SpurfunkArcLoader({
    super.key,
    this.size = 34,
    this.strokeWidth = 3,
    this.color = AppColors.red,
  });

  final double size;
  final double strokeWidth;
  final Color color;

  @override
  State<SpurfunkArcLoader> createState() => _SpurfunkArcLoaderState();
}

class _SpurfunkArcLoaderState extends State<SpurfunkArcLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.square(widget.size),
          painter: _ArcLoaderPainter(
            progress: _controller.value,
            strokeWidth: widget.strokeWidth,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class _ArcLoaderPainter extends CustomPainter {
  const _ArcLoaderPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
  });

  final double progress;
  final double strokeWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    const sweep = math.pi * 1.45;
    final start = -math.pi / 2 + progress * math.pi * 2;
    canvas.drawArc(rect, start, sweep, false, paint);
  }

  @override
  bool shouldRepaint(covariant _ArcLoaderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
