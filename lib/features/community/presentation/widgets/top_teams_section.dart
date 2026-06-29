import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../core/widgets/investigator_portrait.dart';
import '../../../../shared/models/models.dart';
import '../../data/community_mock_data.dart';

class TopTeamsCard extends StatelessWidget {
  const TopTeamsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          for (var i = 0; i < mockPopularTeams.length; i++) ...[
            if (i > 0) const Divider(color: AppColors.divider),
            _TeamRow(team: mockPopularTeams[i]),
          ],
        ],
      ),
    );
  }
}

class _TeamRow extends StatelessWidget {
  const _TeamRow({required this.team});

  final PopularTeam team;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '${team.rank}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color:
                    team.rank == 1 ? AppColors.yellow : AppColors.textSecondary,
              ),
            ),
          ),
          InvestigatorPortrait(
            assetPath: team.portraitAssetPath,
            size: 44,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(team.name, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  '${NumberFormat.decimalPattern('de_DE').format(team.favoriteCount)} Favoriten',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.star_rounded, color: AppColors.red, size: 20),
        ],
      ),
    );
  }
}
