import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/facts_mock_data.dart';
import 'facts_team_card.dart';

class FactsTeamsTab extends StatelessWidget {
  const FactsTeamsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'ERMITTLER-TEAMS',
          style: GoogleFonts.bebasNeue(
            fontSize: 28,
            color: AppColors.textPrimary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Aktuelle Tatort-Teams im Überblick.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 16),
        for (final team in factsInvestigatorTeams) ...[
          FactsTeamCard(team: team),
          const SizedBox(height: 12),
        ],
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Alle ansehen',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward, color: AppColors.red, size: 18),
          ],
        ),
      ],
    );
  }
}
