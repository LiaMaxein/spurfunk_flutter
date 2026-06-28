import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/assets/app_assets.dart';
import '../models/models.dart';

final _rng = Random(42);

Episode get mockCurrentEpisode {
  final now = DateTime.now();
  final sunday = now.weekday == DateTime.sunday ? now : now.add(Duration(days: (7 - now.weekday) % 7));
  final start = DateTime(sunday.year, sunday.month, sunday.day, 20, 15);
  if (now.isAfter(start) && now.hour < 22) {
    return Episode(
      id: 'ep-live',
      title: 'Borowski und das Haupt der Medusa',
      sender: 'Das Erste',
      startsAt: start,
      endsAt: start.add(const Duration(minutes: 90)),
      description:
          'Ein mysteriöser Fund führt Borowski und Sahin in die Welt antiker Mythen.',
      location: 'Kiel',
      imageAssetPath: AppAssets.homeLive,
    );
  }
  return Episode(
    id: 'ep-next',
    title: 'Borowski und das Haupt der Medusa',
    sender: 'Das Erste',
    startsAt: start,
    endsAt: start.add(const Duration(minutes: 90)),
    description: 'Nächster Sonntagskrimi – gemeinsam miträtseln.',
    location: 'Kiel',
    imageAssetPath: AppAssets.homeNoLive,
  );
}

final mockPastEpisodes = [
  Episode(
    id: 'ep-past-1',
    title: 'Tatort: Rebellen',
    sender: 'Das Erste',
    startsAt: DateTime(2025, 5, 11, 20, 15),
    endsAt: DateTime(2025, 5, 11, 21, 45),
    description: 'Ein Fall voller Spannung in Hamburg.',
    location: 'Hamburg',
  ),
  Episode(
    id: 'ep-past-2',
    title: 'Tatort: Schatten über Kiel',
    sender: 'Das Erste',
    startsAt: DateTime(2025, 5, 4, 20, 15),
    endsAt: DateTime(2025, 5, 4, 21, 45),
    description: 'Borowski ermittelt in seinem Heimatrevier.',
    location: 'Kiel',
  ),
];

final mockNewsItems = [
  NewsItem(
    id: 'news-1',
    title: 'Neue Folge angekündigt',
    teaser: 'Tatort – Rebellen am 16. Juni',
    body: 'Die nächste Folge verspricht Spannung in Hamburg.',
    category: 'Polizeifunk',
    publishedAt: DateTime(2025, 5, 18),
  ),
  NewsItem(
    id: 'news-2',
    title: 'Community-Highlight',
    teaser: 'Über 3.000 Stimmen bei letzter Abstimmung',
    body: 'Die Community war live dabei und hat kräftig mitgerätselt.',
    category: 'Community',
    publishedAt: DateTime(2025, 5, 17),
  ),
  NewsItem(
    id: 'news-3',
    title: 'Hintergrundwissen',
    teaser: 'Wie Spurensicherung im Krimi funktioniert',
    body: 'Ein Blick hinter die Kulissen der Ermittlungsarbeit.',
    category: 'Hintergrund',
    publishedAt: DateTime(2025, 5, 15),
  ),
];

const mockChatSeed = [
  ('Spurensucherin', 'Hat jemand den Hinweis mit der Statue gesehen?'),
  ('Nachtfalke', 'Borowski wirkt heute besonders misstrauisch.'),
  ('KrimiFan83', 'Die Musik ist wieder perfekt noir!'),
  ('Mitwisser_42', 'Ich tippe auf den Zeugen im Café.'),
  ('Profilerin', 'Der Dialog um Minute 32 war goldwert.'),
];

VoteAggregate mockAggregateFor(String episodeId, {VoteFilter? filter}) {
  final base = VoteAggregate(
    episodeId: episodeId,
    schlecht: 210,
    langweilig: 348,
    okay: 837,
    gut: 1395,
    mega: 697,
  );
  if (filter == null ||
      (filter.region == null &&
          filter.ageCohort == null &&
          filter.gender == null)) {
    return base;
  }
  final factor = 0.55 + _rng.nextDouble() * 0.35;
  return VoteAggregate(
    episodeId: episodeId,
    schlecht: (base.schlecht * factor).round(),
    langweilig: (base.langweilig * factor).round(),
    okay: (base.okay * factor).round(),
    gut: (base.gut * factor).round(),
    mega: (base.mega * factor).round(),
  );
}

/// Role portraits for onboarding (12 roles).
class RoleAvatarPreset {
  const RoleAvatarPreset({
    required this.id,
    required this.name,
    required this.icon,
    required this.colors,
  });

  final String id;
  final String name;
  final IconData icon;
  final List<Color> colors;
}

const roleAvatarPresets = [
  RoleAvatarPreset(
    id: 'kommissar',
    name: 'Kommissar:in',
    icon: Icons.local_police_outlined,
    colors: [Color(0xFF8B4513), Color(0xFF3D2314)],
  ),
  RoleAvatarPreset(
    id: 'profiler',
    name: 'Profiler:in',
    icon: Icons.psychology_outlined,
    colors: [Color(0xFF6B4BCE), Color(0xFF241B55)],
  ),
  RoleAvatarPreset(
    id: 'spurensicherung',
    name: 'Spurensicherung',
    icon: Icons.fingerprint,
    colors: [Color(0xFF556B2F), Color(0xFF2A3518)],
  ),
  RoleAvatarPreset(
    id: 'nachtfalke',
    name: 'Nachtfalke',
    icon: Icons.nightlight_round,
    colors: [Color(0xFF293241), Color(0xFF070B12)],
  ),
  RoleAvatarPreset(
    id: 'coldcase',
    name: 'Cold Case',
    icon: Icons.ac_unit_outlined,
    colors: [Color(0xFF4A6FA5), Color(0xFF1A2F4A)],
  ),
  RoleAvatarPreset(
    id: 'taeter',
    name: 'Täter:in',
    icon: Icons.theater_comedy_outlined,
    colors: [Color(0xFF5C4033), Color(0xFF2A1A14)],
  ),
  RoleAvatarPreset(
    id: 'reporter',
    name: 'Reporter:in',
    icon: Icons.mic_outlined,
    colors: [Color(0xFFB22222), Color(0xFF4A0E0E)],
  ),
  RoleAvatarPreset(
    id: 'rechercheur',
    name: 'Rechercheur:in',
    icon: Icons.search,
    colors: [Color(0xFF2F4F4F), Color(0xFF0F1A1A)],
  ),
  RoleAvatarPreset(
    id: 'staatsanwalt',
    name: 'Staatsanwalt:in',
    icon: Icons.gavel_outlined,
    colors: [Color(0xFF4B0082), Color(0xFF1A0030)],
  ),
  RoleAvatarPreset(
    id: 'fan_erste_stunde',
    name: 'Fan der ersten Stunde',
    icon: Icons.star_outline,
    colors: [Color(0xFFDAA520), Color(0xFF5C4A10)],
  ),
  RoleAvatarPreset(
    id: 'beobachter',
    name: 'Beobachter:in',
    icon: Icons.visibility_outlined,
    colors: [Color(0xFF708090), Color(0xFF2A3038)],
  ),
  RoleAvatarPreset(
    id: 'taxifahrer',
    name: 'Taxifahrer:in',
    icon: Icons.local_taxi_outlined,
    colors: [Color(0xFFFFD700), Color(0xFF5C4A00)],
  ),
];

/// Symbolic noir icons for chat/profile display.
class SymbolicAvatar {
  const SymbolicAvatar({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  final String id;
  final String name;
  final IconData icon;
  final Color color;
}

const symbolicAvatars = [
  SymbolicAvatar(
    id: 'ermittler',
    name: 'Einsamer Ermittler',
    icon: Icons.person_outline,
    color: Color(0xFF4A6FA5),
  ),
  SymbolicAvatar(
    id: 'analytikerin',
    name: 'Analytikerin',
    icon: Icons.face_3_outlined,
    color: Color(0xFF8B6B61),
  ),
  SymbolicAvatar(
    id: 'fingerabdruck',
    name: 'Fingerabdruck',
    icon: Icons.fingerprint,
    color: Color(0xFF556B2F),
  ),
  SymbolicAvatar(
    id: 'verdeckt',
    name: 'Verdeckter Ermittler',
    icon: Icons.dark_mode_outlined,
    color: Color(0xFF293241),
  ),
  SymbolicAvatar(
    id: 'spurensicherung_icon',
    name: 'Spurensicherung',
    icon: Icons.science_outlined,
    color: Color(0xFF2E8B57),
  ),
  SymbolicAvatar(
    id: 'beobachter_icon',
    name: 'Beobachter',
    icon: Icons.remove_red_eye_outlined,
    color: Color(0xFF708090),
  ),
];

SymbolicAvatar symbolicAvatarForRole(String roleId) {
  final index = roleAvatarPresets.indexWhere((r) => r.id == roleId);
  if (index < 0) return symbolicAvatars.first;
  return symbolicAvatars[index % symbolicAvatars.length];
}
