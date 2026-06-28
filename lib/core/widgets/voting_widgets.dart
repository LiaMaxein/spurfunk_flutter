import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../../shared/models/models.dart';

extension VoteValueUi on VoteValue {
  String get emoji => switch (this) {
    VoteValue.schlecht => '😡',
    VoteValue.langweilig => '🙁',
    VoteValue.okay => '😐',
    VoteValue.gut => '🙂',
    VoteValue.mega => '😍',
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

class VoteOptionButton extends StatelessWidget {
  const VoteOptionButton({
    required this.value,
    required this.selected,
    required this.onTap,
    super.key,
    this.enabled = true,
  });

  final VoteValue value;
  final bool selected;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${value.label} bewerten',
      button: true,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Opacity(
          opacity: enabled ? 1 : 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selected
                      ? value.color.withValues(alpha: 0.2)
                      : AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: selected ? value.color : AppColors.divider,
                    width: selected ? 2 : 1,
                  ),
                ),
                child: Text(value.emoji, style: const TextStyle(fontSize: 28)),
              ),
              const SizedBox(height: 4),
              Text(
                value.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 11,
                  color: selected ? value.color : AppColors.textMuted,
                ),
              ),
            ],
          ),
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
                '$percent%${count != null ? ' · $count' : ''}',
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
        ],
      ),
    );
  }
}

class AvatarCard extends StatelessWidget {
  const AvatarCard({
    required this.selected,
    required this.onTap,
    required this.child,
    super.key,
  });

  final bool selected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.red : AppColors.divider,
            width: selected ? 2.5 : 1,
          ),
        ),
        child: Stack(
          children: [
            child,
            if (selected)
              const Positioned(
                top: 6,
                right: 6,
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.red,
                  size: 22,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
