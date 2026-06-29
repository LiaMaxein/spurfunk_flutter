import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/app_shell.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../data/profile_mock_data.dart';
import '../data/profile_models.dart';
import 'widgets/profile_activity_widgets.dart';
import 'widgets/profile_badge_section.dart';
import 'widgets/profile_statistics_teaser.dart';
import 'widgets/profile_sub_tab_bar.dart';
import 'widgets/profile_xp_line_chart.dart';

class ProfileStatsScreen extends StatefulWidget {
  const ProfileStatsScreen({super.key});

  @override
  State<ProfileStatsScreen> createState() => _ProfileStatsScreenState();
}

class _ProfileStatsScreenState extends State<ProfileStatsScreen> {
  ProfileStatsTab _tab = ProfileStatsTab.overview;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProfileDetailHeader(title: 'STATISTIKEN'),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: ProfileStatsTabBar(
                selected: _tab,
                onChanged: (tab) => setState(() => _tab = tab),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ProfileXpLineChart(
                      points: profileXpTrend,
                      totalXp: profileTotalXp,
                    ),
                    const SizedBox(height: 16),
                    ProfileActivityMetricsList(
                      metrics: metricsForTab(_tab),
                    ),
                    const SizedBox(height: 16),
                    ProfileNavRow(
                      label: 'Aktivitätstracker',
                      onTap: () => context.push(AppRoutes.profileActivityPath),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileActivityScreen extends StatelessWidget {
  const ProfileActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      header: const ProfileDetailHeader(title: 'AKTIVITÄTSTRACKER'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ProfileActivityCalendar(),
          const SizedBox(height: 16),
          ProfileActivityList(events: profileTodayActivities),
          const SizedBox(height: 16),
          ProfileTodayXpFooter(totalXp: profileTodayXpTotal),
        ],
      ),
    );
  }
}

class ProfileBadgesScreen extends StatefulWidget {
  const ProfileBadgesScreen({super.key});

  @override
  State<ProfileBadgesScreen> createState() => _ProfileBadgesScreenState();
}

class _ProfileBadgesScreenState extends State<ProfileBadgesScreen> {
  ProfileBadgeFilter _filter = ProfileBadgeFilter.all;

  @override
  Widget build(BuildContext context) {
    final unlocked = badgesForFilter(ProfileBadgeFilter.unlocked);
    final locked = badgesForFilter(ProfileBadgeFilter.locked);

    return ColoredBox(
      color: AppColors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProfileDetailHeader(title: 'BADGE-SAMMLUNG'),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: ProfileBadgeTabBar(
                selected: _filter,
                onChanged: (filter) => setState(() => _filter = filter),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileBadgeProgress(
                      unlocked: profileBadgesUnlocked,
                      total: profileBadgesTotal,
                    ),
                    const SizedBox(height: 20),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
