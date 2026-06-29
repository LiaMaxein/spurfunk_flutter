import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../data/profile_mock_data.dart';
import '../../data/profile_models.dart';
import 'profile_sub_tab_bar.dart';

class ProfileBadgeProgress extends StatelessWidget {
  const ProfileBadgeProgress({
    required this.unlocked,
    required this.total,
    super.key,
  });

  final int unlocked;
  final int total;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          const Icon(Icons.star_rounded, color: AppColors.yellow, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FORTSCHRITT',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$unlocked / $total Badges',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: unlocked / total,
                    minHeight: 6,
                    backgroundColor: AppColors.divider,
                    color: AppColors.red,
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

class ProfileInlineBadgeCollection extends StatefulWidget {
  const ProfileInlineBadgeCollection({super.key});

  @override
  State<ProfileInlineBadgeCollection> createState() =>
      _ProfileInlineBadgeCollectionState();
}

class _ProfileInlineBadgeCollectionState
    extends State<ProfileInlineBadgeCollection> {
  ProfileBadgeFilter _filter = ProfileBadgeFilter.all;

  @override
  Widget build(BuildContext context) {
    final unlocked = badgesForFilter(ProfileBadgeFilter.unlocked);
    final locked = badgesForFilter(ProfileBadgeFilter.locked);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'BADGE-SAMMLUNG',
          style: GoogleFonts.bebasNeue(
            fontSize: 22,
            color: AppColors.textPrimary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),
        ProfileBadgeProgress(
          unlocked: profileBadgesUnlocked,
          total: profileBadgesTotal,
        ),
        const SizedBox(height: 16),
        ProfileBadgeTabBar(
          selected: _filter,
          onChanged: (filter) => setState(() => _filter = filter),
        ),
        const SizedBox(height: 16),
        if (_filter == ProfileBadgeFilter.all ||
            _filter == ProfileBadgeFilter.unlocked) ...[
          ProfileBadgeSection(
            title: 'FREIGESCHALTETE BADGES',
            badges: unlocked,
          ),
          const SizedBox(height: 20),
        ],
        if (_filter == ProfileBadgeFilter.all ||
            _filter == ProfileBadgeFilter.locked)
          ProfileBadgeSection(
            title: 'GESPERRTE BADGES',
            badges: locked,
          ),
      ],
    );
  }
}

class ProfileBadgeSection extends StatelessWidget {
  const ProfileBadgeSection({
    required this.title,
    required this.badges,
    super.key,
  });

  final String title;
  final List<ProfileBadge> badges;

  @override
  Widget build(BuildContext context) {
    if (badges.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.bebasNeue(
            fontSize: 18,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.15,
          ),
          itemCount: badges.length,
          itemBuilder: (context, index) => _BadgeTile(badge: badges[index]),
        ),
      ],
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.badge});

  final ProfileBadge badge;

  @override
  Widget build(BuildContext context) {
    final unlocked = badge.isUnlocked;
    final accent = badge.accentColor;
    final iconColor = unlocked ? accent : AppColors.textMuted;
    final ringColor = unlocked ? accent : accent.withValues(alpha: 0.35);

    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: unlocked
                      ? accent.withValues(alpha: 0.18)
                      : AppColors.surfaceHigh,
                  border: Border.all(color: ringColor, width: 1.5),
                ),
                child: Icon(badge.icon, color: iconColor),
              ),
              if (!unlocked)
                const Icon(Icons.lock_outline, size: 16, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            badge.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 13,
              color: unlocked ? AppColors.textPrimary : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            badge.subtitle,
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
