import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../data/profile_models.dart';

class ProfileXpLineChart extends StatelessWidget {
  const ProfileXpLineChart({
    required this.points,
    required this.totalXp,
    super.key,
  });

  final List<ProfileXpDataPoint> points;
  final int totalXp;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PUNKTEVERLAUF',
            style: GoogleFonts.bebasNeue(
              fontSize: 20,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Letzte 30 Tage',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 160,
            child: CustomPaint(
              painter: _XpLineChartPainter(points: points),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4, bottom: 4),
                  child: Text(
                    '${NumberFormat.decimalPattern('de_DE').format(totalXp)} XP',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _XpLineChartPainter extends CustomPainter {
  _XpLineChartPainter({required this.points});

  final List<ProfileXpDataPoint> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    const minY = 2000.0;
    const maxY = 12450.0;
    final maxDay = points.last.dayOffset.toDouble();

    final gridPaint = Paint()
      ..color = AppColors.divider
      ..strokeWidth = 1;

    for (var i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final path = Path();
    final fillPath = Path();

    for (var i = 0; i < points.length; i++) {
      final x = (points[i].dayOffset / maxDay) * size.width;
      final y = size.height -
          ((points[i].xp - minY) / (maxY - minY)) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.red.withValues(alpha: 0.35),
            AppColors.red.withValues(alpha: 0.02),
          ],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.red
        ..strokeWidth = 2.5
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    final last = points.last;
    final lastX = (last.dayOffset / maxDay) * size.width;
    final lastY =
        size.height - ((last.xp - minY) / (maxY - minY)) * size.height;
    canvas.drawCircle(
      Offset(lastX, lastY),
      5,
      Paint()..color = AppColors.red,
    );
  }

  @override
  bool shouldRepaint(covariant _XpLineChartPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}

class ProfileActivityMetricsList extends StatelessWidget {
  const ProfileActivityMetricsList({required this.metrics, super.key});

  final List<ProfileActivityMetric> metrics;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DEINE AKTIVITÄT',
            style: GoogleFonts.bebasNeue(
              fontSize: 20,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          for (var i = 0; i < metrics.length; i++) ...[
            Row(
              children: [
                Icon(metrics[i].icon, color: AppColors.red, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    metrics[i].label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Text(
                  NumberFormat.decimalPattern('de_DE').format(metrics[i].value),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            if (i < metrics.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(color: AppColors.divider, height: 1),
              ),
          ],
        ],
      ),
    );
  }
}
