import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../onboarding/application/onboarding_state.dart';
import '../application/profile_favorites_provider.dart';
import '../application/profile_hero_provider.dart';
import '../data/profile_mock_data.dart';
import 'widgets/profile_avatar_picker_sheet.dart';
import 'widgets/profile_badge_section.dart';
import 'widgets/profile_favorite_carousel.dart';
import 'widgets/profile_hero_header.dart';
import 'widgets/profile_identity_row.dart';
import 'widgets/profile_statistics_teaser.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(selectedAvatarProvider);
    final displayName = ref.watch(displayNameProvider);
    final favorites = ref.watch(profileFavoritesProvider);
    final heroBackground = ref.watch(profileHeroBackgroundProvider);

    return ColoredBox(
      color: AppColors.black,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileHeroHeader(
                onSettingsTap: () => context.go(AppRoutes.profileSettingsPath),
              ),
              const SizedBox(height: 10),
              ProfileIdentityBanner(
                backgroundAsset: heroBackground,
                child: ProfileIdentityRow(
                  avatarAssetPath: role.assetPath,
                  displayName: displayName,
                  progress: profileXpProgress,
                  onAvatarTap: () => showProfileAvatarPicker(
                    context: context,
                    ref: ref,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileXpBar(progress: profileXpProgress),
                    const SizedBox(height: 20),
                    ProfileQuickStatsRow(stats: profileQuickStats),
                    const SizedBox(height: 24),
                    ProfileFavoriteCarousel(favorites: favorites),
                    const SizedBox(height: 24),
                    ProfileStatisticsTeaser(totalXp: profileTotalXp),
                    const SizedBox(height: 24),
                    const ProfileInlineBadgeCollection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
