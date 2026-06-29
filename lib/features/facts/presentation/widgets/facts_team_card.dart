import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../core/widgets/investigator_portrait.dart';
import '../../data/facts_models.dart';

class FactsTeamCard extends StatelessWidget {
  const FactsTeamCard({required this.team, super.key});

  final InvestigatorTeamSummary team;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.push('/live/team-detail/${team.id}'),
      child: Row(
        children: [
          InvestigatorPortrait(
            assetPath: team.thumbnailAssetPath,
            size: 56,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  team.teamLabel.toUpperCase(),
                  style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                    color: AppColors.textPrimary,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  team.investigatorNames,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${team.city} · seit ${team.sinceYear}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}
