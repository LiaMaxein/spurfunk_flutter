import 'package:flutter/material.dart';

enum ProfileActivityType {
  liveStream,
  liveChat,
  vote,
  quiz,
  memory,
}

enum ProfileStatsTab { overview, live, quiz, memory }

enum ProfileBadgeFilter { all, unlocked, locked }

class ProfileXpProgress {
  const ProfileXpProgress({
    required this.currentXp,
    required this.nextLevelXp,
    required this.level,
    required this.title,
  });

  final int currentXp;
  final int nextLevelXp;
  final int level;
  final String title;

  double get progress => currentXp / nextLevelXp;
}

class ProfileQuickStats {
  const ProfileQuickStats({
    required this.posts,
    required this.liveChats,
    required this.quizzes,
    required this.activeDays,
  });

  final int posts;
  final int liveChats;
  final int quizzes;
  final int activeDays;
}

class ProfileActivityMetric {
  const ProfileActivityMetric({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final int value;
  final IconData icon;
}

class ProfileXpDataPoint {
  const ProfileXpDataPoint({required this.dayOffset, required this.xp});

  final int dayOffset;
  final int xp;
}

class ProfileActivityEvent {
  const ProfileActivityEvent({
    required this.title,
    required this.xpDelta,
    required this.timeLabel,
    required this.type,
  });

  final String title;
  final int xpDelta;
  final String timeLabel;
  final ProfileActivityType type;
}

class ProfileBadge {
  const ProfileBadge({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.isUnlocked,
    required this.accentColor,
    this.iconAssetPath,
  });

  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final bool isUnlocked;
  final Color accentColor;
  final String? iconAssetPath;
}

class FavoriteInvestigatorItem {
  const FavoriteInvestigatorItem({
    required this.name,
    required this.city,
    required this.portraitAssetPath,
    required this.routePath,
    this.isTeam = false,
  });

  final String name;
  final String city;
  final String portraitAssetPath;
  final String routePath;
  final bool isTeam;
}
