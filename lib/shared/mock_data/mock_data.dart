import 'dart:math';

import '../../core/assets/app_assets.dart';
import '../../features/live_episode/data/live_case_mock_data.dart';
import '../../core/widgets/voting_widgets.dart';
import '../models/models.dart';

final _rng = Random(42);

Episode get mockCurrentEpisode {
  final now = DateTime.now();
  final currentSunday =
      now.weekday == DateTime.sunday
          ? now
          : now.add(Duration(days: (7 - now.weekday) % 7));
  var start = DateTime(currentSunday.year, currentSunday.month, currentSunday.day, 20, 15);
  final end = start.add(const Duration(minutes: 90));
  if (now.isAfter(start) && now.isBefore(end)) {
    return Episode(
      id: 'ep-live',
      title: 'Borowski und das Haupt der Medusa',
      sender: 'Das Erste',
      startsAt: start,
      endsAt: start.add(const Duration(minutes: 90)),
      description:
          'Ein mysteriöser Fund führt Borowski und Sahin in die Welt antiker Mythen.',
      location: 'Kiel',
      investigatorIds: liveCaseInvestigatorIds,
      imageAssetPath: AppAssets.liveCaseKielNoirHero,
    );
  }
  if (now.isAfter(end)) {
    start = start.add(const Duration(days: 7));
  }
  return Episode(
    id: 'ep-next',
    title: 'Borowski und das Haupt der Medusa',
    sender: 'Das Erste',
    startsAt: start,
    endsAt: start.add(const Duration(minutes: 90)),
    description: 'Nächster Sonntagskrimi – gemeinsam miträtseln.',
    location: 'Kiel',
    investigatorIds: liveCaseInvestigatorIds,
    imageAssetPath: AppAssets.liveCaseKielNoirHero,
  );
}

final mockPastEpisodes = [
  Episode(
    id: 'ep-past-3',
    title: 'Tatort: Borowski und das Haupt der Medusa',
    sender: 'Das Erste',
    startsAt: DateTime(2025, 5, 4, 20, 15),
    endsAt: DateTime(2025, 5, 4, 21, 45),
    description: 'Ein mysteriöser Fund in Kiel.',
    location: 'Kiel',
    investigatorIds: liveCaseInvestigatorIds,
    imageAssetPath: AppAssets.episodeMedusaKiel,
  ),
  Episode(
    id: 'ep-past-2',
    title: 'Tatort: Schatten über Kiel',
    sender: 'Das Erste',
    startsAt: DateTime(2025, 5, 18, 20, 15),
    endsAt: DateTime(2025, 5, 18, 21, 45),
    description: 'Borowski ermittelt in seinem Heimatrevier.',
    location: 'Kiel',
    investigatorIds: liveCaseInvestigatorIds,
    imageAssetPath: AppAssets.episodeSchattenUeberKiel,
  ),
  Episode(
    id: 'ep-past-1',
    title: 'Tatort: Rebellen',
    sender: 'Das Erste',
    startsAt: DateTime(2025, 5, 11, 20, 15),
    endsAt: DateTime(2025, 5, 11, 21, 45),
    description: 'Ein Fall voller Spannung in Hamburg.',
    location: 'Hamburg',
    investigatorIds: const ['frank_thiel', 'sarah_brandt'],
    imageAssetPath: AppAssets.episodeRebellenHamburg,
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
  final seeds = {
    'ep-past-1': (210, 348, 837, 1395, 697),
    'ep-past-2': (180, 420, 910, 1280, 820),
    'ep-past-3': (240, 310, 760, 1510, 940),
  };
  final values = seeds[episodeId] ?? (210, 348, 837, 1395, 697);
  final base = VoteAggregate(
    episodeId: episodeId,
    schlecht: values.$1,
    langweilig: values.$2,
    okay: values.$3,
    gut: values.$4,
    mega: values.$5,
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

String averageLabelForAggregate(VoteAggregate aggregate) {
  if (aggregate.total == 0) return '–';
  final top = VoteValue.values.reduce(
    (a, b) =>
        aggregate.fractionFor(a) >= aggregate.fractionFor(b) ? a : b,
  );
  return top.label;
}

/// Noir avatar motifs for onboarding, chat and profile.
class RoleAvatarPreset {
  const RoleAvatarPreset({
    required this.id,
    required this.name,
    required this.description,
    required this.assetPath,
  });

  final String id;
  final String name;
  final String description;
  final String assetPath;
}

const roleAvatarPresets = [
  RoleAvatarPreset(
    id: 'laterne',
    name: 'Der einsame Ermittler',
    description: 'Geduld, Ausdauer und die Suche nach der Wahrheit.',
    assetPath: AppAssets.avatarLaterne,
  ),
  RoleAvatarPreset(
    id: 'frau_profil',
    name: 'Die Analytikerin',
    description: 'Beobachtungsgabe, Intuition und analytisches Denken.',
    assetPath: AppAssets.avatarFrauProfil,
  ),
  RoleAvatarPreset(
    id: 'fingerabdruck',
    name: 'Der Fingerabdruck',
    description: 'Identität, Spuren und kriminalistische Beweisführung.',
    assetPath: AppAssets.avatarFingerabdruck,
  ),
  RoleAvatarPreset(
    id: 'detektiv_hut',
    name: 'Der verdeckte Ermittler',
    description: 'Klassische Detektivarbeit und Undercover-Ermittlungen.',
    assetPath: AppAssets.avatarDetektivHut,
  ),
  RoleAvatarPreset(
    id: 'lupe',
    name: 'Die Spurensicherung',
    description: 'Forensik, Detailgenauigkeit und entscheidende Hinweise.',
    assetPath: AppAssets.avatarLupe,
  ),
  RoleAvatarPreset(
    id: 'mann_profil',
    name: 'Der Beobachter',
    description: 'Neutralität und objektive Analyse.',
    assetPath: AppAssets.avatarMannProfil,
  ),
  RoleAvatarPreset(
    id: 'aktenordner',
    name: 'Die Ermittlungsakte',
    description: 'Wissen, Hintergrundinformationen und Indizien.',
    assetPath: AppAssets.avatarAktenordner,
  ),
  RoleAvatarPreset(
    id: 'fussabdruecke',
    name: 'Die Fußspuren',
    description: 'Tatorte, Ermittlungswege und Spurenverfolgung.',
    assetPath: AppAssets.avatarFussabdruecke,
  ),
  RoleAvatarPreset(
    id: 'frau_ruecken',
    name: 'Die Zeugin',
    description: 'Perspektiven, Beobachtungen und Aussagen.',
    assetPath: AppAssets.avatarFrauRuecken,
  ),
  RoleAvatarPreset(
    id: 'pistole',
    name: 'Die Dienstwaffe',
    description: 'Polizeiarbeit und Ernsthaftigkeit der Ermittlung.',
    assetPath: AppAssets.avatarPistole,
  ),
  RoleAvatarPreset(
    id: 'beweisbeutel',
    name: 'Der Laborfund',
    description: 'Spurensicherung und kriminaltechnische Untersuchungen.',
    assetPath: AppAssets.avatarBeweisbeutel,
  ),
  RoleAvatarPreset(
    id: 'lampe',
    name: 'Der Tatort',
    description: 'Spannung, Schatten und ungelöste Fälle.',
    assetPath: AppAssets.avatarLampe,
  ),
];

const symbolicAvatars = roleAvatarPresets;

RoleAvatarPreset avatarPresetForId(String id) {
  return roleAvatarPresets.firstWhere(
    (avatar) => avatar.id == id,
    orElse: () => roleAvatarPresets.first,
  );
}
