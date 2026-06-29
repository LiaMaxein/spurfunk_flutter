import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../../shared/models/models.dart';
import 'voting_widgets.dart';

class VoteResultsPanel extends StatelessWidget {
  const VoteResultsPanel({
    required this.aggregate,
    super.key,
    this.showTotal = true,
  });

  final VoteAggregate aggregate;
  final bool showTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VoteSegmentBar(aggregate: aggregate),
        const SizedBox(height: 12),
        for (final value in VoteValue.values.reversed)
          _DetailedStatBar(
            label: value.label,
            emoji: value.emoji,
            fraction: aggregate.fractionFor(value),
            color: value.color,
            count: aggregate.countFor(value),
          ),
        if (showTotal && aggregate.total > 0) ...[
          const SizedBox(height: 4),
          Text(
            'Gesamt: ${_formatTotal(aggregate.total)} Stimmen',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textMuted,
            ),
          ),
        ],
      ],
    );
  }

  String _formatTotal(int total) {
    return total.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
  }
}

class _DetailedStatBar extends StatelessWidget {
  const _DetailedStatBar({
    required this.label,
    required this.fraction,
    required this.color,
    required this.count,
    this.emoji,
  });

  final String label;
  final double fraction;
  final Color color;
  final int count;
  final String? emoji;

  @override
  Widget build(BuildContext context) {
    final percent = (fraction * 100).round();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (emoji != null) Text(emoji!, style: const TextStyle(fontSize: 16)),
              if (emoji != null) const SizedBox(width: 6),
              Text(label, style: Theme.of(context).textTheme.labelLarge),
              const Spacer(),
              Text(
                '$percent%',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction.clamp(0, 1),
              minHeight: 8,
              backgroundColor: AppColors.divider,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$count Stimmen',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
