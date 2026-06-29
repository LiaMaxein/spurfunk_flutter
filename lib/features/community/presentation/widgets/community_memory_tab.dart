import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../shared/models/gamification_models.dart';
import '../../data/memory_mock_data.dart';
import 'gamification_replay_dialogs.dart';

class CommunityMemoryTab extends StatelessWidget {
  const CommunityMemoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'KRIMI-MEMORY',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Finde Motiv-Paare aus Spurensicherung, Tatort & Ermittlung.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 16),
        for (final difficulty in memoryDifficulties) ...[
          _DifficultyCard(
            difficulty: difficulty,
            onTap: () => context.push(memoryPlayPath(difficulty)),
          ),
          const SizedBox(height: 10),
        ],
        AppCard(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: AppColors.red, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Weniger Züge und schnellere Zeit bedeuten mehr Punkte und XP.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DifficultyCard extends StatelessWidget {
  const _DifficultyCard({
    required this.difficulty,
    required this.onTap,
  });

  final MemoryDifficulty difficulty;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceHigh,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Center(
              child: Text(
                difficulty.gridLabel,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 13,
                  color: AppColors.red,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  difficulty.label,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${difficulty.pairCount} Paare · ${difficulty.gridLabel} Raster',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        ],
      ),
    );
  }
}
