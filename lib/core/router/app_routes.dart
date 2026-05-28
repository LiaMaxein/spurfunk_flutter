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
  static const community = AppRouteData(
    path: '/community',
    label: 'Community',
    icon: Icons.forum_rounded,
  );
  static const profile = AppRouteData(
    path: '/profile',
    label: 'Profil',
    icon: Icons.person_rounded,
  );

  // Standalone (not part of bottom navigation)
  static const votingPath = '/voting';
  static const statisticsPath = '/statistics';

  // Nested under profile (not part of bottom navigation)
  static const profileSettingsPath = '/profile/settings';
  static const profileSettingsAboutPath = '/profile/settings/about';
  static const profileSettingsPrivacyPath = '/profile/settings/privacy';

  static const navigationRoutes = [
    home,
    liveEpisode,
    community,
    profile,
  ];
}
