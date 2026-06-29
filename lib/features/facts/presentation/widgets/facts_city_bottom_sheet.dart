import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../data/facts_models.dart';

class FactsCityBottomSheet extends StatelessWidget {
  const FactsCityBottomSheet({required this.city, super.key});

  final TatortCity city;

  static Future<void> show(BuildContext context, TatortCity city) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FactsCityBottomSheet(city: city),
    );
  }

  @override
  Widget build(BuildContext context) {
    final episodeLabel = NumberFormat.decimalPattern('de_DE').format(
      city.episodeCount,
    );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                city.imageAssetPath,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Text(
                    city.name.toUpperCase(),
                    style: GoogleFonts.bebasNeue(
                      fontSize: 28,
                      color: AppColors.textPrimary,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: city.isActive
                        ? AppColors.red.withValues(alpha: 0.15)
                        : AppColors.surfaceHigh,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: city.isActive ? AppColors.red : AppColors.divider,
                    ),
                  ),
                  child: Text(
                    city.isActive ? 'Aktiv' : 'Ehemalig',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: city.isActive ? AppColors.red : AppColors.textMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${city.country} · seit ${city.sinceYear} · $episodeLabel Folgen',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            if (city.teamName != null) ...[
              const SizedBox(height: 6),
              Text(
                city.teamName!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
            if (city.teamId != null || city.leadInvestigatorId != null) ...[
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'TEAM ANSEHEN',
                onPressed: () {
                  Navigator.of(context).pop();
                  if (city.teamId != null) {
                    context.push('/live/team-detail/${city.teamId}');
                  } else {
                    context.push('/live/team/${city.leadInvestigatorId}');
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
