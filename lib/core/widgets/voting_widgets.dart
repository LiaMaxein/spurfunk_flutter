import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../../shared/models/models.dart';

extension VoteValueUi on VoteValue {
  String get emoji => switch (this) {
    VoteValue.schlecht => '😡',
    VoteValue.langweilig => '🥱',
    VoteValue.okay => '😐',
    VoteValue.gut => '😊',
    VoteValue.mega => '😍',
  };

  String get liveEmoji => emoji;

  Color? get liveEmojiTint => switch (this) {
    VoteValue.schlecht => AppColors.red,
    VoteValue.langweilig => AppColors.orange,
    VoteValue.okay => null,
    VoteValue.gut => AppColors.blue,
    VoteValue.mega => const Color(0xFF81C784),
  };

  String get label => switch (this) {
    VoteValue.schlecht => 'Schlecht',
    VoteValue.langweilig => 'Langweilig',
    VoteValue.okay => 'Okay',
    VoteValue.gut => 'Gut',
    VoteValue.mega => 'Mega',
  };

  Color get color => switch (this) {
    VoteValue.schlecht => AppColors.voteSchlecht,
    VoteValue.langweilig => AppColors.voteLangweilig,
    VoteValue.okay => AppColors.voteOkay,
    VoteValue.gut => AppColors.voteGut,
    VoteValue.mega => AppColors.voteMega,
  };
}

class VoteSegmentBar extends StatelessWidget {
  const VoteSegmentBar({required this.aggregate, super.key});

  final VoteAggregate aggregate;

  @override
  Widget build(BuildContext context) {
    if (aggregate.total == 0) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 8,
        child: Row(
          children: [
            for (final value in VoteValue.values)
              if (aggregate.fractionFor(value) > 0)
                Expanded(
                  flex: (aggregate.fractionFor(value) * 1000).round().clamp(1, 1000),
                  child: ColoredBox(color: value.color),
                ),
          ],
        ),
      ),
    );
  }
}

class StatBar extends StatelessWidget {
  const StatBar({
    required this.label,
    required this.fraction,
    required this.color,
    super.key,
    this.emoji,
    this.count,
  });

  final String label;
  final double fraction;
  final Color color;
  final String? emoji;
  final int? count;

  @override
  Widget build(BuildContext context) {
    final percent = (fraction * 100).round();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
              if (count != null) ...[
                Text(
                  ' · ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '$count',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
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
        ],
      ),
    );
  }
}
