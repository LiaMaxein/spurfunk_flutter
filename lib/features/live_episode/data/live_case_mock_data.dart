import '../../../core/assets/app_assets.dart';
import '../../../shared/models/models.dart';
import 'facts_investigator_stubs.dart';

const liveCaseInvestigatorIds = [
  'klaus_borowski',
  'mila_sahin',
  'sarah_brandt',
];

const liveCaseSpoilerWarningTitle = 'SPOILERWARNUNG';

const liveCaseSynopsis =
    'In der Kieler Foerde wird ein abgeschlagener Kopf gefunden. '
    'Die Spur fuehrt Kommissar Borowski und sein Team in ein Netz aus Macht, '
    'Gier und antiken Geheimnissen.';

final liveCaseInvestigators = [
  Investigator(
    id: 'klaus_borowski',
    name: 'Klaus Borowski',
    role: 'Kommissar',
    bio:
        'Ein Eigenbroetler mit Feingefuehl. Borowski loest Faelle auf seine ganz '
        'eigene Art - moralisch kompromisslos und tief menschlich.',
    portraitAssetPath: AppAssets.portraitKlausBorowski,
    teamMemberCount: 3,
    episodeCount: 38,
    averageRating: 4.6,
    teamName: 'Team Kiel',
    isFavorite: true,
    popularEpisodes: [
      PopularEpisode(
        id: 'medusa',
        title: 'Borowski und das Haupt der Medusa',
        airedAt: DateTime(2025, 5, 18),
        rating: 4.6,
        thumbnailAssetPath: AppAssets.episodeMedusaKiel,
      ),
      PopularEpisode(
        id: 'gaarden',
        title: 'Borowski und die Kinder von Gaarden',
        airedAt: DateTime(2023, 12, 10),
        rating: 4.3,
        thumbnailAssetPath: AppAssets.homeNoLive,
      ),
      PopularEpisode(
        id: 'engel',
        title: 'Borowski und die Engel',
        airedAt: DateTime(2022, 10, 22),
        rating: 4.2,
        thumbnailAssetPath: AppAssets.homeLive,
      ),
    ],
  ),
  Investigator(
    id: 'mila_sahin',
    name: 'Mila Sahin',
    role: 'Kommissarin',
    bio:
        'Sahin kombiniert analytische Schaerfe mit klarem moralischem Kompass '
        'und bringt Ruhe in eskalierende Ermittlungen.',
    portraitAssetPath: AppAssets.portraitMilaSahin,
    teamMemberCount: 3,
    episodeCount: 14,
    averageRating: 4.4,
    teamName: 'Team Kiel',
    popularEpisodes: [
      PopularEpisode(
        id: 'medusa',
        title: 'Borowski und das Haupt der Medusa',
        airedAt: DateTime(2025, 5, 18),
        rating: 4.6,
        thumbnailAssetPath: AppAssets.episodeMedusaKiel,
      ),
      PopularEpisode(
        id: 'foerde',
        title: 'Borowski und die Foerde',
        airedAt: DateTime(2024, 11, 17),
        rating: 4.1,
        thumbnailAssetPath: AppAssets.homeNoLive,
      ),
      PopularEpisode(
        id: 'spur',
        title: 'Borowski und die stumme Spur',
        airedAt: DateTime(2024, 3, 10),
        rating: 4.0,
        thumbnailAssetPath: AppAssets.homeLive,
      ),
    ],
  ),
  Investigator(
    id: 'sarah_brandt',
    name: 'Sarah Brandt',
    role: 'Rechtsmedizinerin',
    bio:
        'Brandt liefert praezise Einordnungen und den kuehlen Blick auf die '
        'forensischen Details, die Faelle kippen koennen.',
    portraitAssetPath: AppAssets.portraitSarahBrandt,
    teamMemberCount: 3,
    episodeCount: 33,
    averageRating: 4.5,
    teamName: 'Team Kiel',
    popularEpisodes: [
      PopularEpisode(
        id: 'medusa',
        title: 'Borowski und das Haupt der Medusa',
        airedAt: DateTime(2025, 5, 18),
        rating: 4.6,
        thumbnailAssetPath: AppAssets.episodeMedusaKiel,
      ),
      PopularEpisode(
        id: 'engel',
        title: 'Borowski und die Engel',
        airedAt: DateTime(2022, 10, 22),
        rating: 4.2,
        thumbnailAssetPath: AppAssets.homeLive,
      ),
      PopularEpisode(
        id: 'lab',
        title: 'Der Fall im Labor',
        airedAt: DateTime(2021, 4, 18),
        rating: 4.0,
        thumbnailAssetPath: AppAssets.homeNoLive,
      ),
    ],
  ),
  Investigator(
    id: 'frank_thiel',
    name: 'Frank Thiel',
    role: 'Kriminalhauptkommissar',
    bio:
        'Thiel bringt Direktheit und Tempo ins Team. Seine Staerke liegt in der '
        'Vernehmung und im Lesen sozialer Dynamiken – in Münster an der Seite '
        'von Prof. Boerne.',
    portraitAssetPath: AppAssets.portraitFrankThiel,
    teamMemberCount: 2,
    episodeCount: 45,
    averageRating: 4.3,
    teamName: 'Team Münster',
    popularEpisodes: [
      PopularEpisode(
        id: 'muenster-1',
        title: 'Summ, Summ, Summ',
        airedAt: DateTime(2024, 11, 10),
        rating: 4.2,
        thumbnailAssetPath: AppAssets.homeNoLive,
      ),
      PopularEpisode(
        id: 'muenster-2',
        title: 'Die Fette',
        airedAt: DateTime(2023, 5, 14),
        rating: 4.1,
        thumbnailAssetPath: AppAssets.homeLive,
      ),
      PopularEpisode(
        id: 'muenster-3',
        title: 'Der andere Schnitt',
        airedAt: DateTime(2022, 3, 6),
        rating: 4.0,
        thumbnailAssetPath: AppAssets.homeNoLive,
      ),
    ],
  ),
];

final allInvestigators = [
  ...liveCaseInvestigators,
  ...factsStubInvestigators,
];

Investigator investigatorById(String id) {
  return allInvestigators.firstWhere(
    (investigator) => investigator.id == id,
    orElse: () => liveCaseInvestigators.first,
  );
}

List<Investigator> investigatorsForEpisode(Episode episode) {
  final ids = episode.investigatorIds;
  if (ids.isEmpty) return const [];
  return [
    for (final id in ids) investigatorById(id),
  ];
}
