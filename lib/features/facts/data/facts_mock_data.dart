import '../../../core/assets/app_assets.dart';
import 'facts_models.dart';

const factsFunFactCarousel = [
  FunFactCarouselItem(
    imageAssetPath: AppAssets.episodeMedusaKiel,
    title: 'Längste Ermittlung',
    body:
        'Die durchschnittliche Tatort-Folge dauert 90 Minuten – '
        'aber die Dreharbeiten erstrecken sich oft über mehrere Wochen.',
  ),
  FunFactCarouselItem(
    imageAssetPath: AppAssets.episodeRebellenHamburg,
    title: 'Über 1.200 Folgen',
    body:
        'Seit 1970 wurden mehr als 1.200 Tatort-Folgen produziert – '
        'eine der längsten laufenden Krimireihen im deutschsprachigen Raum.',
  ),
  FunFactCarouselItem(
    imageAssetPath: AppAssets.liveCaseKielNoirHero,
    title: '13 Drehstädte',
    body:
        'Von Hamburg bis Zürich: Tatort-Teams ermitteln in Städten '
        'in Deutschland, Österreich und der Schweiz.',
  ),
  FunFactCarouselItem(
    imageAssetPath: AppAssets.communityNoirHero,
    title: 'Sonntagabend-Ritual',
    body:
        'Der Tatort ist seit Jahrzehnten fester Bestandteil des '
        'Sonntagabend-Programms im Ersten.',
  ),
];

const factsTatortStatistics2024 = [
  TatortStatistic(label: 'Über 1.200 produzierte Folgen seit 1970'),
  TatortStatistic(label: 'Durchschnittlich 90 Minuten pro Episode'),
  TatortStatistic(label: 'Rund 6–8 Mio. Zuschauer:innen pro Folge'),
  TatortStatistic(label: '13 aktive und ehemalige Drehstädte'),
  TatortStatistic(label: 'Über 50 Ermittler:innen in der Geschichte'),
  TatortStatistic(label: 'Produktionsbudget ca. 1,5–2 Mio. € pro Folge'),
];

const factsInvestigatorTeams = [
  InvestigatorTeamSummary(
    id: 'team_kiel',
    city: 'Kiel',
    teamLabel: 'Team Kiel',
    investigatorNames: 'Borowski, Sahin, Thiel, Brandt',
    sinceYear: 2003,
    thumbnailAssetPath: AppAssets.portraitKlausBorowski,
    leadInvestigatorId: 'klaus_borowski',
    teamBio:
        'Das Kieler Team um Kommissar Borowski ermittelt seit Jahren an der '
        'Küste – mit Blick für Details und moralische Grauzonen.',
    members: [
      TeamMemberSummary(
        name: 'Klaus Borowski',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitKlausBorowski,
        investigatorId: 'klaus_borowski',
      ),
      TeamMemberSummary(
        name: 'Mila Sahin',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitMilaSahin,
        investigatorId: 'mila_sahin',
      ),
      TeamMemberSummary(
        name: 'Frank Thiel',
        role: 'Kriminalhauptkommissar',
        portraitAssetPath: AppAssets.portraitFrankThiel,
        investigatorId: 'frank_thiel',
      ),
      TeamMemberSummary(
        name: 'Sarah Brandt',
        role: 'Rechtsmedizinerin',
        portraitAssetPath: AppAssets.portraitSarahBrandt,
        investigatorId: 'sarah_brandt',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_muenster',
    city: 'Münster',
    teamLabel: 'Team Münster',
    investigatorNames: 'Thiel, Boerne',
    sinceYear: 1999,
    thumbnailAssetPath: AppAssets.portraitFrankThiel,
    leadInvestigatorId: 'frank_thiel',
    teamBio:
        'In Münster arbeiten Kommissar Thiel und der Pathologe Boerne seit '
        'Jahren als eingespieltes Duo – oft mit trockenem Humor und scharfem Blick.',
    members: [
      TeamMemberSummary(
        name: 'Frank Thiel',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitFrankThiel,
        investigatorId: 'frank_thiel',
      ),
      TeamMemberSummary(
        name: 'Prof. Karl-Friedrich Boerne',
        role: 'Pathologe',
        portraitAssetPath: AppAssets.portraitKlausBorowski,
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_hamburg',
    city: 'Hamburg',
    teamLabel: 'Team Hamburg',
    investigatorNames: 'Cenk, Yalcin',
    sinceYear: 2019,
    thumbnailAssetPath: AppAssets.portraitMilaSahin,
    leadInvestigatorId: 'mila_sahin',
    teamBio:
        'Das Hamburger Team verbindet Hafenstadt-Atmosphäre mit modernen '
        'Ermittlungsmethoden.',
    members: [
      TeamMemberSummary(
        name: 'Nick Cenk',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitMilaSahin,
        investigatorId: 'mila_sahin',
      ),
      TeamMemberSummary(
        name: 'Yalcin Gümer',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitFrankThiel,
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_wien',
    city: 'Wien',
    teamLabel: 'Team Wien',
    investigatorNames: 'Fellner, Nowak',
    sinceYear: 2006,
    thumbnailAssetPath: AppAssets.portraitSarahBrandt,
    leadInvestigatorId: 'sarah_brandt',
    teamBio:
        'Das Wiener Team bringt österreichisches Flair und internationale '
        'Fälle in die Tatort-Welt.',
    members: [
      TeamMemberSummary(
        name: 'Moritz Fellner',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitSarahBrandt,
        investigatorId: 'sarah_brandt',
      ),
      TeamMemberSummary(
        name: 'Bibi Nowak',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitMilaSahin,
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_muenchen',
    city: 'München',
    teamLabel: 'Team München',
    investigatorNames: 'Leitmayr, Batic',
    sinceYear: 1991,
    thumbnailAssetPath: AppAssets.portraitKlausBorowski,
    leadInvestigatorId: 'klaus_borowski',
    teamBio:
        'Leitmayr und Batic sind eines der bekanntesten Tatort-Duos – '
        'München als Kulisse für komplexe Kriminalfälle.',
    members: [
      TeamMemberSummary(
        name: 'Franz Leitmayr',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitKlausBorowski,
        investigatorId: 'klaus_borowski',
      ),
      TeamMemberSummary(
        name: 'Ivo Batic',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitFrankThiel,
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_stuttgart',
    city: 'Stuttgart',
    teamLabel: 'Team Stuttgart',
    investigatorNames: 'Lannert, Bootz',
    sinceYear: 2008,
    thumbnailAssetPath: AppAssets.portraitFrankThiel,
    leadInvestigatorId: 'frank_thiel',
    teamBio:
        'Lannert und Bootz ermitteln in Stuttgart mit unterschiedlichen '
        'Temperamenten, aber gemeinsamem Ehrgeiz.',
    members: [
      TeamMemberSummary(
        name: 'Claus Lannert',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitFrankThiel,
        investigatorId: 'frank_thiel',
      ),
      TeamMemberSummary(
        name: 'Josef Bootz',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitKlausBorowski,
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_bremen',
    city: 'Bremen',
    teamLabel: 'Team Bremen',
    investigatorNames: 'Stark, Lüttge',
    sinceYear: 2019,
    thumbnailAssetPath: AppAssets.portraitMilaSahin,
    leadInvestigatorId: 'mila_sahin',
    teamBio:
        'Das Bremer Team verbindet norddeutsche Gelassenheit mit '
        'präziser Ermittlungsarbeit.',
    members: [
      TeamMemberSummary(
        name: 'Paula Maria Stark',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitMilaSahin,
        investigatorId: 'mila_sahin',
      ),
      TeamMemberSummary(
        name: 'Boris Lüttge',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitSarahBrandt,
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_zuerich',
    city: 'Zürich',
    teamLabel: 'Team Zürich',
    investigatorNames: 'Flückiger, Marti',
    sinceYear: 2011,
    thumbnailAssetPath: AppAssets.portraitSarahBrandt,
    leadInvestigatorId: 'sarah_brandt',
    teamBio:
        'Das Zürcher Team bringt Schweizer Tatort-Kultur in die Reihe – '
        'mit internationalen Bezügen und lokaler Tiefe.',
    members: [
      TeamMemberSummary(
        name: 'Reto Flückiger',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitSarahBrandt,
        investigatorId: 'sarah_brandt',
      ),
      TeamMemberSummary(
        name: 'Antonia Marti',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitMilaSahin,
      ),
    ],
  ),
];

InvestigatorTeamSummary? teamById(String id) {
  for (final team in factsInvestigatorTeams) {
    if (team.id == id) return team;
  }
  return null;
}

const factsTimelineMilestones = [
  TimelineMilestone(
    period: '1970',
    title: 'Der erste Tatort',
    description:
        'Am 29. November 1970 startet die Reihe mit „Taxi nach Basel". '
        'Ein Meilenstein für das deutsche Fernsehen.',
  ),
  TimelineMilestone(
    period: '1980er',
    title: 'Wachstum der Reihe',
    description:
        'Neue Teams in verschiedenen Städten etablieren sich. '
        'Der Tatort wird zum Sonntagabend-Ritual.',
  ),
  TimelineMilestone(
    period: '1990',
    title: '20 Jahre Tatort',
    description:
        'Die Reihe feiert ihr 20-jähriges Jubiläum mit über 400 Folgen '
        'und fest etablierten Ermittler:innen-Teams.',
  ),
  TimelineMilestone(
    period: '2000',
    title: 'Neue Ära',
    description:
        'Frische Teams in Münster, Wien und anderen Städten bringen '
        'neue Perspektiven in die Krimireihe.',
  ),
  TimelineMilestone(
    period: '2010',
    title: 'Internationaler Ausbau',
    description:
        'Teams in der Schweiz und weiteren Regionen erweitern '
        'den Tatort über die deutschen Grenzen hinaus.',
  ),
  TimelineMilestone(
    period: '2020',
    title: '50 Jahre Tatort',
    description:
        'Halbes Jahrhundert Krimigeschichte: Über 1.200 Folgen '
        'und eine treue Fangemeinde im gesamten DACH-Raum.',
  ),
];

const factsBehindTheScenes = BehindTheScenesTeaser(
  title: 'Hinter den Kulissen',
  body:
      'Eine Tatort-Folge entsteht in mehreren Drehphasen: Location-Scouting, '
      'Drehbuchentwicklung, Dreharbeiten vor Ort und Postproduktion. '
      'Kriminalist:innen beraten die Autor:innen, Regie und Kamera '
      'arbeiten im dokumentarischen Stil – für den authentischen Tatort-Look.',
  imageAssetPath: AppAssets.episodeSchattenUeberKiel,
);

const factsTatortCities = [
  TatortCity(
    id: 'hamburg',
    name: 'Hamburg',
    country: 'Deutschland',
    latitude: 53.5511,
    longitude: 9.9937,
    sinceYear: 1986,
    episodeCount: 42,
    isActive: true,
    imageAssetPath: AppAssets.episodeRebellenHamburg,
    teamName: 'Team Hamburg',
    teamId: 'team_hamburg',
    leadInvestigatorId: 'mila_sahin',
  ),
  TatortCity(
    id: 'kiel',
    name: 'Kiel',
    country: 'Deutschland',
    latitude: 54.3233,
    longitude: 10.1228,
    sinceYear: 2003,
    episodeCount: 38,
    isActive: true,
    imageAssetPath: AppAssets.liveCaseKielNoirHero,
    teamName: 'Team Kiel',
    teamId: 'team_kiel',
    leadInvestigatorId: 'klaus_borowski',
  ),
  TatortCity(
    id: 'muenster',
    name: 'Münster',
    country: 'Deutschland',
    latitude: 51.9607,
    longitude: 7.6261,
    sinceYear: 1999,
    episodeCount: 52,
    isActive: true,
    imageAssetPath: AppAssets.portraitFrankThiel,
    teamName: 'Team Münster',
    teamId: 'team_muenster',
    leadInvestigatorId: 'frank_thiel',
  ),
  TatortCity(
    id: 'koeln',
    name: 'Köln',
    country: 'Deutschland',
    latitude: 50.9375,
    longitude: 6.9603,
    sinceYear: 1984,
    episodeCount: 48,
    isActive: false,
    imageAssetPath: AppAssets.homeNoLive,
  ),
  TatortCity(
    id: 'dortmund',
    name: 'Dortmund',
    country: 'Deutschland',
    latitude: 51.5136,
    longitude: 7.4653,
    sinceYear: 1981,
    episodeCount: 44,
    isActive: false,
    imageAssetPath: AppAssets.homeLiveHero,
  ),
  TatortCity(
    id: 'frankfurt',
    name: 'Frankfurt',
    country: 'Deutschland',
    latitude: 50.1109,
    longitude: 8.6821,
    sinceYear: 1996,
    episodeCount: 28,
    isActive: false,
    imageAssetPath: AppAssets.communityNoirHero,
  ),
  TatortCity(
    id: 'stuttgart',
    name: 'Stuttgart',
    country: 'Deutschland',
    latitude: 48.7758,
    longitude: 9.1829,
    sinceYear: 2008,
    episodeCount: 32,
    isActive: true,
    imageAssetPath: AppAssets.episodeMedusaKiel,
    teamName: 'Team Stuttgart',
    teamId: 'team_stuttgart',
    leadInvestigatorId: 'frank_thiel',
  ),
  TatortCity(
    id: 'muenchen',
    name: 'München',
    country: 'Deutschland',
    latitude: 48.1351,
    longitude: 11.5820,
    sinceYear: 1991,
    episodeCount: 56,
    isActive: true,
    imageAssetPath: AppAssets.splashNoirCouple,
    teamName: 'Team München',
    teamId: 'team_muenchen',
    leadInvestigatorId: 'klaus_borowski',
  ),
  TatortCity(
    id: 'wien',
    name: 'Wien',
    country: 'Österreich',
    latitude: 48.2082,
    longitude: 16.3738,
    sinceYear: 2006,
    episodeCount: 36,
    isActive: true,
    imageAssetPath: AppAssets.portraitSarahBrandt,
    teamName: 'Team Wien',
    teamId: 'team_wien',
    leadInvestigatorId: 'sarah_brandt',
  ),
  TatortCity(
    id: 'graz',
    name: 'Graz',
    country: 'Österreich',
    latitude: 47.0707,
    longitude: 15.4395,
    sinceYear: 2010,
    episodeCount: 14,
    isActive: false,
    imageAssetPath: AppAssets.homeNoLive,
  ),
  TatortCity(
    id: 'linz',
    name: 'Linz',
    country: 'Österreich',
    latitude: 48.3069,
    longitude: 14.2858,
    sinceYear: 2012,
    episodeCount: 12,
    isActive: false,
    imageAssetPath: AppAssets.homeLiveHero,
  ),
  TatortCity(
    id: 'zuerich',
    name: 'Zürich',
    country: 'Schweiz',
    latitude: 47.3769,
    longitude: 8.5417,
    sinceYear: 2011,
    episodeCount: 24,
    isActive: true,
    imageAssetPath: AppAssets.episodeSchattenUeberKiel,
    teamName: 'Team Zürich',
    teamId: 'team_zuerich',
    leadInvestigatorId: 'sarah_brandt',
  ),
  TatortCity(
    id: 'bern',
    name: 'Bern',
    country: 'Schweiz',
    latitude: 46.9480,
    longitude: 7.4474,
    sinceYear: 2014,
    episodeCount: 10,
    isActive: false,
    imageAssetPath: AppAssets.communityNoirHero,
  ),
];
