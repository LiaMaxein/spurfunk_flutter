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
    icon: Icons.home_outlined,
  );
  static const community = AppRouteData(
    path: '/community',
    label: 'Community',
    icon: Icons.groups_outlined,
  );
  static const liveEpisode = AppRouteData(
    path: '/live',
    label: 'Live',
    icon: Icons.sensors_outlined,
  );
  static const facts = AppRouteData(
    path: '/facts',
    label: 'Fakten',
    icon: Icons.folder_outlined,
  );
  static const profile = AppRouteData(
    path: '/profile',
    label: 'Meine Akte',
    icon: Icons.person_outline,
  );

  static const votingPath = '/voting';
  static const statisticsPath = '/statistics';
  static const liveCasePath = '/live/case';

  static const profileSettingsPath = '/profile/settings';
  static const profileStatsPath = '/profile/stats';
  static const profileActivityPath = '/profile/activity';
  static const profileBadgesPath = '/profile/badges';
  static const profileSettingsAboutPath = '/profile/settings/about';
  static const profileSettingsPrivacyPath = '/profile/settings/privacy';

  static const navigationRoutes = [
    home,
    community,
    liveEpisode,
    facts,
    profile,
  ];
}
