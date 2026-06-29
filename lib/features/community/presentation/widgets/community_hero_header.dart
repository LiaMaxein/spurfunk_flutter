import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/assets/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/spurfunk_branding_widgets.dart';
import '../../data/community_mock_data.dart';

class CommunityHeroHeader extends StatelessWidget {
  const CommunityHeroHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'COMMUNITY',
          textAlign: TextAlign.center,
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
            color: AppColors.textPrimary,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 132,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  AppAssets.communityHero,
                  fit: BoxFit.cover,
                  alignment: const Alignment(0, 0.55),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.28),
                        Colors.black.withValues(alpha: 0.5),
                        Colors.black.withValues(alpha: 0.78),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SpurfunkLogo(
                        variant: SpurfunkLogoVariant.horizontal,
                        height: 42,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Gemeinsam schauen. Gemeinsam rätseln.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _KpiTile(
                icon: Icons.person_outline,
                value: _formatCount(communityRegisteredUsers),
                label: 'registrierte Nutzer',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _KpiTile(
                icon: Icons.forum_outlined,
                value: _formatCount(communityTotalPosts),
                label: 'Beiträge',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _KpiTile(
                icon: Icons.sensors,
                value: _formatCount(communityOnlineMembers),
                label: 'online',
                showOnlineDot: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatCount(int value) {
    return NumberFormat.decimalPattern('de_DE').format(value);
  }
}

class _KpiTile extends StatelessWidget {
  const _KpiTile({
    required this.icon,
    required this.value,
    required this.label,
    this.showOnlineDot = false,
  });

  final IconData icon;
  final String value;
  final String label;
  final bool showOnlineDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(icon, color: AppColors.red, size: 18),
              if (showOnlineDot)
                const Positioned(
                  right: -4,
                  top: -2,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: AppColors.green,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 10,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
