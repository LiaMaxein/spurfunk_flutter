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

class LiveTimelineItem {
  const LiveTimelineItem({
    required this.minute,
    required this.label,
    required this.highlighted,
  });

  final String minute;
  final String label;
  final bool highlighted;
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

const liveTimelineItems = [
  LiveTimelineItem(minute: '20:15', label: 'Opener im Hafen', highlighted: false),
  LiveTimelineItem(minute: '20:28', label: 'Erste Spur gesichert', highlighted: false),
  LiveTimelineItem(minute: '20:43', label: 'Zeugin widerspricht', highlighted: true),
  LiveTimelineItem(minute: '20:58', label: 'Tatwaffe gefunden', highlighted: false),
  LiveTimelineItem(minute: '21:07', label: 'Verdächtiger flieht', highlighted: false),
];

const trendingTheory = 'Die Galerie war nur der Köder – die Spur führt ins Hafenamt.';
const suspiciousCharacter = 'Verdächtigste Figur: Hanno Kessler (Nachbar)';

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
  LiveActivityItem(
    user: 'NordNord',
    message: 'Die Handschuhe am Tatort wirkten absichtlich platziert.',
    timeAgo: '5 Min.',
    icon: Icons.search_rounded,
    color: AppColors.orange,
  ),
  LiveActivityItem(
    user: 'TrueCrimeMia',
    message: 'Diese Kamerafahrt war cineastisch brutal gut.',
    timeAgo: '6 Min.',
    icon: Icons.movie_creation_outlined,
    color: AppColors.redSoft,
  ),
  LiveActivityItem(
    user: 'Kompass',
    message: 'Poll: Ich gehe auf „Gut“ – starke Dialoge heute.',
    timeAgo: '7 Min.',
    icon: Icons.poll_outlined,
    color: AppColors.green,
  ),
  LiveActivityItem(
    user: 'NoirNacht',
    message: 'Der Kommissar wirkt heute ungewöhnlich nervös.',
    timeAgo: '8 Min.',
    icon: Icons.visibility_rounded,
    color: AppColors.yellow,
  ),
  LiveActivityItem(
    user: 'Spurensucher',
    message: 'Die Uhrzeit im Protokoll passt nicht zur Szene.',
    timeAgo: '9 Min.',
    icon: Icons.schedule_rounded,
    color: AppColors.greenSoft,
  ),
  LiveActivityItem(
    user: 'KielKrimi',
    message: 'Der Schnitt am Fensterrahmen war zu sauber.',
    timeAgo: '10 Min.',
    icon: Icons.content_cut_rounded,
    color: AppColors.orange,
  ),
  LiveActivityItem(
    user: 'Nora_17',
    message: 'Ich feier den Soundtrack im Hintergrund gerade total.',
    timeAgo: '11 Min.',
    icon: Icons.graphic_eq_rounded,
    color: AppColors.red,
  ),
  LiveActivityItem(
    user: 'TatortMünster',
    message: 'Theorie-Thread ist offen – wer macht mit?',
    timeAgo: '12 Min.',
    icon: Icons.forum_rounded,
    color: AppColors.greenSoft,
  ),
  LiveActivityItem(
    user: 'CaseClosed?',
    message: 'Kessler wusste zu viel über den Ablauf.',
    timeAgo: '13 Min.',
    icon: Icons.person_search_rounded,
    color: AppColors.redSoft,
  ),
  LiveActivityItem(
    user: 'SabrinaK',
    message: 'Die rote Mappe war schon in Minute 12 zu sehen.',
    timeAgo: '14 Min.',
    icon: Icons.folder_open_rounded,
    color: AppColors.orange,
  ),
  LiveActivityItem(
    user: 'Mordkommission',
    message: 'Im Norden kippt die Abstimmung Richtung „Mega“.',
    timeAgo: '15 Min.',
    icon: Icons.trending_up_rounded,
    color: AppColors.green,
  ),
  LiveActivityItem(
    user: 'Ermittlerin_01',
    message: 'Die Lichtsetzung in der Verhörszene war absolut brillant.',
    timeAgo: '16 Min.',
    icon: Icons.videocam_outlined,
    color: AppColors.redSoft,
  ),
  LiveActivityItem(
    user: 'BettBeste',
    message: 'Hab die letzte Minute verpasst – was ist passiert?!',
    timeAgo: '17 Min.',
    icon: Icons.help_outline_rounded,
    color: AppColors.yellow,
  ),
  LiveActivityItem(
    user: 'CouchPotato',
    message: 'Noch eine Tüte Chips aufgepackt. Es geht weiter! 🍿',
    timeAgo: '18 Min.',
    icon: Icons.weekend_rounded,
    color: AppColors.orange,
  ),
  LiveActivityItem(
    user: 'Krimi_89',
    message: 'Habe den Täter jetzt identifiziert! Poste im Theorie-Thread.',
    timeAgo: '19 Min.',
    icon: Icons.lightbulb_outlined,
    color: AppColors.greenSoft,
  ),
  LiveActivityItem(
    user: 'FilmFuchs',
    message: 'Hinweis: Das Notizbuch lag schon in der ersten Szene offen.',
    timeAgo: '20 Min.',
    icon: Icons.menu_book_rounded,
    color: AppColors.red,
  ),
  LiveActivityItem(
    user: 'Nachtfalke',
    message: 'Die Musik wird düsterer – es kommt der Showdown!',
    timeAgo: '21 Min.',
    icon: Icons.music_note_rounded,
    color: AppColors.redSoft,
  ),
];
