import 'package:flutter/material.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../voting/application/voting_state.dart';

class LiveEpisodeInfo {
  const LiveEpisodeInfo({
    required this.title,
    required this.station,
    required this.subtitle,
    required this.heroAsset,
    required this.remainingMinutes,
  });

  final String title;
  final String station;
  final String subtitle;
  final String heroAsset;
  final int remainingMinutes;
}

class LiveReactionTrend {
  const LiveReactionTrend({
    required this.rating,
    required this.count,
    required this.deltaPercent,
  });

  final VoteRating rating;
  final int count;
  final double deltaPercent;
}

class LiveActivityItem {
  const LiveActivityItem({
    required this.user,
    required this.message,
    required this.timeAgo,
    required this.icon,
    required this.color,
  });

  final String user;
  final String message;
  final String timeAgo;
  final IconData icon;
  final Color color;
}

const liveEpisodeDemo = LiveEpisodeInfo(
  title: 'Borowski und das Haupt der Medusa',
  station: 'ARD · Das Erste',
  subtitle: 'Krimi im Norden – Live mit der Community',
  heroAsset: AppAssets.mockupIntro,
  remainingMinutes: 32,
);

const liveReactionTrends = [
  LiveReactionTrend(
    rating: VoteRating.mega,
    count: 1842,
    deltaPercent: 12.4,
  ),
  LiveReactionTrend(
    rating: VoteRating.gut,
    count: 1260,
    deltaPercent: 6.1,
  ),
  LiveReactionTrend(
    rating: VoteRating.okay,
    count: 640,
    deltaPercent: -2.3,
  ),
  LiveReactionTrend(
    rating: VoteRating.nichtGut,
    count: 210,
    deltaPercent: -4.8,
  ),
];

const liveActivityFeed = [
  LiveActivityItem(
    user: 'TatortFan_22',
    message: '„Die Medusa-Metapher sitzt – mega Spannung!“',
    timeAgo: 'jetzt',
    icon: Icons.bolt_rounded,
    color: AppColors.redSoft,
  ),
  LiveActivityItem(
    user: 'Nordlicht_09',
    message: 'Theorie: Das Opfer kannte den Täter aus der Galerie.',
    timeAgo: '1 Min.',
    icon: Icons.psychology_alt_outlined,
    color: AppColors.orange,
  ),
  LiveActivityItem(
    user: 'KommissarX',
    message: 'Hat jemand die Szene im Hafen schon gesehen? 👀',
    timeAgo: '2 Min.',
    icon: Icons.forum_outlined,
    color: AppColors.greenSoft,
  ),
  LiveActivityItem(
    user: 'Spoilerfrei',
    message: 'Reaktion: 😍 Mega – ohne Spoiler!',
    timeAgo: '3 Min.',
    icon: Icons.favorite_rounded,
    color: AppColors.red,
  ),
  LiveActivityItem(
    user: 'Aktenkind',
    message: 'Countdown läuft – noch 30 Min. Spannung!',
    timeAgo: '4 Min.',
    icon: Icons.timer_outlined,
    color: AppColors.yellow,
  ),
];
