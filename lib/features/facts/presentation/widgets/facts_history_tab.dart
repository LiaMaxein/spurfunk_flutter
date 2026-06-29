import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../data/facts_models.dart';
import '../../data/facts_mock_data.dart';
import 'facts_timeline.dart';

class FactsHistoryTab extends StatelessWidget {
  const FactsHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'GESCHICHTE',
          style: GoogleFonts.bebasNeue(
            fontSize: 28,
            color: AppColors.textPrimary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Meilensteine der Tatort-Reihe seit 1970.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 20),
        FactsTimeline(milestones: factsTimelineMilestones),
        const SizedBox(height: 24),
        _BehindTheScenesCard(teaser: factsBehindTheScenes),
      ],
    );
  }
}

class _BehindTheScenesCard extends StatelessWidget {
  const _BehindTheScenesCard({required this.teaser});

  final BehindTheScenesTeaser teaser;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
            child: Image.asset(
              teaser.imageAssetPath,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  teaser.title.toUpperCase(),
                  style: GoogleFonts.bebasNeue(
                    fontSize: 22,
                    color: AppColors.textPrimary,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  teaser.body,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
