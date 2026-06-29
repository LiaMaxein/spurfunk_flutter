import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class EpisodeCountdown extends StatelessWidget {
  const EpisodeCountdown({
    required this.remaining,
    this.showSeconds = false,
    super.key,
  });

  final Duration remaining;
  final bool showSeconds;

  @override
  Widget build(BuildContext context) {
    final safe = remaining.isNegative ? Duration.zero : remaining;
    final days = safe.inDays;
    final hours = safe.inHours % 24;
    final minutes = safe.inMinutes % 60;
    final seconds = safe.inSeconds % 60;

    return Row(
      children: [
        Expanded(child: _CountdownBox(value: days, label: 'Tage')),
        const SizedBox(width: 8),
        Expanded(child: _CountdownBox(value: hours, label: 'Std.')),
        const SizedBox(width: 8),
        Expanded(child: _CountdownBox(value: minutes, label: 'Min.')),
        if (showSeconds) ...[
          const SizedBox(width: 8),
          Expanded(child: _CountdownBox(value: seconds, label: 'Sek.')),
        ],
      ],
    );
  }
}

class _CountdownBox extends StatelessWidget {
  const _CountdownBox({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.red.withValues(alpha: 0.45)),
      ),
      child: Column(
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: GoogleFonts.bebasNeue(
              fontSize: 28,
              color: AppColors.red,
              letterSpacing: 1,
            ),
          ),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
