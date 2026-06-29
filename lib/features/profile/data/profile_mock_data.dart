import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import 'profile_models.dart';

const profileXpProgress = ProfileXpProgress(
  currentXp: 2450,
  nextLevelXp: 3000,
  level: 12,
  title: 'Mitwisser der Extraklasse',
);

const profileQuickStats = ProfileQuickStats(
  posts: 1248,
  liveChats: 87,
  quizzes: 156,
  activeDays: 32,
);

const profileTotalXp = 12450;

const profileTodayXpTotal = 280;

const profileBadgesUnlocked = 24;
const profileBadgesTotal = 40;

const profileActivityMonthLabel = 'MAI 2025';

const profileActivitySelectedDay = 18;

final profileXpTrend = [
  const ProfileXpDataPoint(dayOffset: 0, xp: 2000),
  const ProfileXpDataPoint(dayOffset: 5, xp: 4200),
  const ProfileXpDataPoint(dayOffset: 10, xp: 6100),
  const ProfileXpDataPoint(dayOffset: 15, xp: 7800),
  const ProfileXpDataPoint(dayOffset: 20, xp: 9400),
  const ProfileXpDataPoint(dayOffset: 25, xp: 11000),
  const ProfileXpDataPoint(dayOffset: 29, xp: 12450),
];

const profileActivityMetricsOverview = [
  ProfileActivityMetric(
    label: 'Live-Abstimmungen',
    value: 236,
    icon: Icons.how_to_vote_outlined,
  ),
  ProfileActivityMetric(
    label: 'Live-Chat Nachrichten',
    value: 1248,
    icon: Icons.chat_bubble_outline,
  ),
  ProfileActivityMetric(
    label: 'Quiz gespielt',
    value: 156,
    icon: Icons.quiz_outlined,
  ),
  ProfileActivityMetric(
    label: 'Memory Spiele',
    value: 87,
    icon: Icons.grid_view_rounded,
  ),
  ProfileActivityMetric(
    label: 'Tage aktiv',
    value: 32,
    icon: Icons.calendar_today_outlined,
  ),
];

const profileActivityMetricsLive = [
  ProfileActivityMetric(
    label: 'Live-Abstimmungen',
    value: 236,
    icon: Icons.how_to_vote_outlined,
  ),
  ProfileActivityMetric(
    label: 'Live-Chat Nachrichten',
    value: 1248,
    icon: Icons.chat_bubble_outline,
  ),
  ProfileActivityMetric(
    label: 'Live-Abende',
    value: 18,
    icon: Icons.sensors,
  ),
];

const profileActivityMetricsQuiz = [
  ProfileActivityMetric(
    label: 'Quiz gespielt',
    value: 156,
    icon: Icons.quiz_outlined,
  ),
  ProfileActivityMetric(
    label: 'Richtige Antworten',
    value: 412,
    icon: Icons.check_circle_outline,
  ),
  ProfileActivityMetric(
    label: 'Bestes Ergebnis',
    value: 14,
    icon: Icons.emoji_events_outlined,
  ),
];

const profileActivityMetricsMemory = [
  ProfileActivityMetric(
    label: 'Memory Spiele',
    value: 87,
    icon: Icons.grid_view_rounded,
  ),
  ProfileActivityMetric(
    label: 'Beste Zeit',
    value: 42,
    icon: Icons.timer_outlined,
  ),
  ProfileActivityMetric(
    label: 'Perfekte Runden',
    value: 9,
    icon: Icons.star_outline,
  ),
];

const profileTodayActivities = [
  ProfileActivityEvent(
    title: 'Live-Stream angeschaut',
    xpDelta: 50,
    timeLabel: '20:15',
    type: ProfileActivityType.liveStream,
  ),
  ProfileActivityEvent(
    title: 'Im Live-Chat aktiv',
    xpDelta: 30,
    timeLabel: '20:42',
    type: ProfileActivityType.liveChat,
  ),
  ProfileActivityEvent(
    title: 'Abstimmung abgegeben',
    xpDelta: 20,
    timeLabel: '21:10',
    type: ProfileActivityType.vote,
  ),
  ProfileActivityEvent(
    title: 'Quiz gespielt',
    xpDelta: 100,
    timeLabel: '18:30',
    type: ProfileActivityType.quiz,
  ),
  ProfileActivityEvent(
    title: 'Memory gespielt',
    xpDelta: 80,
    timeLabel: '16:15',
    type: ProfileActivityType.memory,
  ),
];

const profileUnlockedBadges = [
  ProfileBadge(
    id: 'serial_offender',
    name: 'Serientäter',
    subtitle: '10x Live dabei',
    icon: Icons.live_tv,
    isUnlocked: true,
    accentColor: AppColors.red,
  ),
  ProfileBadge(
    id: 'knowledge_fox',
    name: 'Wissensfuchs',
    subtitle: '50 Quiz richtig',
    icon: Icons.psychology_outlined,
    isUnlocked: true,
    accentColor: AppColors.blue,
  ),
  ProfileBadge(
    id: 'team_player',
    name: 'Teamplayer',
    subtitle: '5 Teams favorisiert',
    icon: Icons.groups_outlined,
    isUnlocked: true,
    accentColor: AppColors.green,
  ),
  ProfileBadge(
    id: 'trace_collector',
    name: 'Spurensicherer',
    subtitle: '100 Fakten gelesen',
    icon: Icons.fingerprint,
    isUnlocked: true,
    accentColor: AppColors.orange,
  ),
  ProfileBadge(
    id: 'insider',
    name: 'Mitwisser',
    subtitle: 'Level 10 erreicht',
    icon: Icons.visibility_outlined,
    isUnlocked: true,
    accentColor: AppColors.yellow,
  ),
  ProfileBadge(
    id: 'chat_pro',
    name: 'Chat-Profi',
    subtitle: '500 Chat-Nachrichten',
    icon: Icons.chat_bubble_outline,
    isUnlocked: true,
    accentColor: Color(0xFF9C27B0),
  ),
];

const profileLockedBadges = [
  ProfileBadge(
    id: 'tatort_expert',
    name: 'Tatort-Experte',
    subtitle: 'Level 20',
    icon: Icons.military_tech_outlined,
    isUnlocked: false,
    accentColor: Color(0xFF607D8B),
  ),
  ProfileBadge(
    id: 'legend',
    name: 'Legende',
    subtitle: '50 Folgen live',
    icon: Icons.workspace_premium_outlined,
    isUnlocked: false,
    accentColor: Color(0xFFFFD700),
  ),
  ProfileBadge(
    id: 'night_owl',
    name: 'Nachteule',
    subtitle: '5 Nacht-Folgen live',
    icon: Icons.nightlight_round,
    isUnlocked: false,
    accentColor: Color(0xFF3F51B5),
  ),
  ProfileBadge(
    id: 'commissioner_fan',
    name: 'Kommissar-Fan',
    subtitle: '3 Teams max. Level',
    icon: Icons.badge_outlined,
    isUnlocked: false,
    accentColor: Color(0xFF009688),
  ),
  ProfileBadge(
    id: 'marathon_live',
    name: 'Marathon-Live',
    subtitle: '8h am Stück aktiv',
    icon: Icons.sensors,
    isUnlocked: false,
    accentColor: Color(0xFFFF5722),
  ),
];

const profileDefaultFavorites = [
  FavoriteInvestigatorItem(
    name: 'Borowski',
    city: 'Kiel',
    portraitAssetPath: AppAssets.portraitKlausBorowski,
    routePath: '/live/team/klaus_borowski',
  ),
  FavoriteInvestigatorItem(
    name: 'Thiel & Boerne',
    city: 'Münster',
    portraitAssetPath: AppAssets.portraitFrankThiel,
    routePath: '/live/team-detail/team_muenster',
    isTeam: true,
  ),
  FavoriteInvestigatorItem(
    name: 'Lena Odenthal',
    city: 'Ludwigshafen',
    portraitAssetPath: AppAssets.portraitMilaSahin,
    routePath: '/live/team/mila_sahin',
  ),
];

List<ProfileActivityMetric> metricsForTab(ProfileStatsTab tab) {
  return switch (tab) {
    ProfileStatsTab.overview => profileActivityMetricsOverview,
    ProfileStatsTab.live => profileActivityMetricsLive,
    ProfileStatsTab.quiz => profileActivityMetricsQuiz,
    ProfileStatsTab.memory => profileActivityMetricsMemory,
  };
}

List<ProfileBadge> badgesForFilter(ProfileBadgeFilter filter) {
  return switch (filter) {
    ProfileBadgeFilter.all => [...profileUnlockedBadges, ...profileLockedBadges],
    ProfileBadgeFilter.unlocked => profileUnlockedBadges,
    ProfileBadgeFilter.locked => profileLockedBadges,
  };
}

String formatProfileCount(int value) {
  return NumberFormat.decimalPattern('de_DE').format(value);
}

IconData iconForActivityType(ProfileActivityType type) {
  return switch (type) {
    ProfileActivityType.liveStream => Icons.play_circle_outline,
    ProfileActivityType.liveChat => Icons.chat_bubble_outline,
    ProfileActivityType.vote => Icons.how_to_vote_outlined,
    ProfileActivityType.quiz => Icons.quiz_outlined,
    ProfileActivityType.memory => Icons.grid_view_rounded,
  };
}
