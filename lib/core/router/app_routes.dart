import 'package:flutter/material.dart';

class AppRouteData {
  const AppRouteData({
    required this.path,
    required this.label,
    required this.icon,
  });

  final String path;
  final String label;
  final IconData icon;
}

abstract final class AppRoutes {
  static const onboardingPath = '/onboarding';

  static const home = AppRouteData(
    path: '/',
    label: 'Home',
    icon: Icons.home_rounded,
  );
  static const liveEpisode = AppRouteData(
    path: '/live',
    label: 'Live',
    icon: Icons.live_tv_rounded,
  );
  static const voting = AppRouteData(
    path: '/voting',
    label: 'Voting',
    icon: Icons.how_to_vote_rounded,
  );
  static const community = AppRouteData(
    path: '/community',
    label: 'Community',
    icon: Icons.forum_rounded,
  );
  static const statistics = AppRouteData(
    path: '/statistics',
    label: 'Stats',
    icon: Icons.analytics_rounded,
  );
  static const profile = AppRouteData(
    path: '/profile',
    label: 'Profile',
    icon: Icons.person_rounded,
  );
  static const settings = AppRouteData(
    path: '/settings',
    label: 'Settings',
    icon: Icons.settings_rounded,
  );

  static const navigationRoutes = [
    home,
    liveEpisode,
    voting,
    community,
    statistics,
    profile,
    settings,
  ];
}
