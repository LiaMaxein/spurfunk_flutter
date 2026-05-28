import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

class HomeTickerItem {
  const HomeTickerItem({required this.text});
  final String text;
}

class HomeNewsItem {
  const HomeNewsItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
}

class HomeEpisodePreview {
  const HomeEpisodePreview({
    required this.day,
    required this.title,
    required this.time,
  });

  final String day;
  final String title;
  final String time;
}

class HomeTeam {
  const HomeTeam({required this.name, required this.city, required this.color});
  final String name;
  final String city;
  final Color color;
}

class HomeDiscussion {
  const HomeDiscussion({
    required this.title,
    required this.replies,
    required this.lastActivity,
  });

  final String title;
  final int replies;
  final String lastActivity;
}

class HomeState {
  const HomeState({
    required this.liveActive,
    required this.selectedTeam,
    required this.selectedDiscussion,
  });

  final bool liveActive;
  final int selectedTeam;
  final int selectedDiscussion;

  HomeState copyWith({
    bool? liveActive,
    int? selectedTeam,
    int? selectedDiscussion,
  }) {
    return HomeState(
      liveActive: liveActive ?? this.liveActive,
      selectedTeam: selectedTeam ?? this.selectedTeam,
      selectedDiscussion: selectedDiscussion ?? this.selectedDiscussion,
    );
  }
}

const homeTickerItems = [
  HomeTickerItem(text: 'LIVE: Borowski folgt der Spur im Hafen'),
  HomeTickerItem(text: 'Community: 1.280 neue Reaktionen in den letzten 5 Min.'),
  HomeTickerItem(text: 'Nächster Tatort: Sonntag, 20:15 Uhr'),
];

const homeNewsItems = [
  HomeNewsItem(
    title: 'Drehstart in Kiel bestätigt',
    subtitle: 'Neue Folge mit Fokus auf Cyberkriminalität.',
    icon: Icons.newspaper_rounded,
    color: AppColors.redSoft,
  ),
  HomeNewsItem(
    title: 'Interview mit dem Regisseur',
    subtitle: 'Heute 22:30 Uhr als Audio-Live-Talk.',
    icon: Icons.mic_rounded,
    color: AppColors.orange,
  ),
  HomeNewsItem(
    title: 'Community-Highlight',
    subtitle: 'Top-Theorie knackt 900 Likes.',
    icon: Icons.bolt_rounded,
    color: AppColors.greenSoft,
  ),
];

const homeUpcomingEpisodes = [
  HomeEpisodePreview(
    day: 'So',
    title: 'Das Mädchen am Strand',
    time: '20:15 · ARD',
  ),
  HomeEpisodePreview(
    day: 'So',
    title: 'Mord im Schattenpark',
    time: '20:15 · ARD',
  ),
  HomeEpisodePreview(
    day: 'So',
    title: 'Kalte Spuren',
    time: '20:15 · ARD',
  ),
];

const homeTeams = [
  HomeTeam(name: 'Borowski', city: 'Kiel', color: AppColors.red),
  HomeTeam(name: 'Thiel & Boerne', city: 'Münster', color: AppColors.orange),
  HomeTeam(name: 'Rubin & Karow', city: 'Berlin', color: AppColors.green),
  HomeTeam(name: 'Lindholm', city: 'Göttingen', color: AppColors.greenSoft),
];

const homeDiscussions = [
  HomeDiscussion(
    title: 'War die Galerieszene ein bewusstes Ablenkungsmanöver?',
    replies: 143,
    lastActivity: 'vor 2 Min.',
  ),
  HomeDiscussion(
    title: 'Ist der Nachbar wirklich nur Nebenfigur?',
    replies: 89,
    lastActivity: 'vor 4 Min.',
  ),
  HomeDiscussion(
    title: 'Beste Tatort-Folge 2026 bisher?',
    replies: 211,
    lastActivity: 'vor 6 Min.',
  ),
];

final homeStateProvider = NotifierProvider<HomeStateNotifier, HomeState>(
  HomeStateNotifier.new,
);

class HomeStateNotifier extends Notifier<HomeState> {
  @override
  HomeState build() => const HomeState(
    liveActive: true,
    selectedTeam: 0,
    selectedDiscussion: 0,
  );

  void selectTeam(int index) => state = state.copyWith(selectedTeam: index);
  void selectDiscussion(int index) =>
      state = state.copyWith(selectedDiscussion: index);
  void toggleLiveActive() => state = state.copyWith(liveActive: !state.liveActive);
}
