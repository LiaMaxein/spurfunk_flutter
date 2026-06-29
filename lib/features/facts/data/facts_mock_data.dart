import '../../../core/assets/app_assets.dart';
import 'facts_extended_teams.dart';
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
  TatortStatistic(label: 'Über 19 aktive Tatort-Teams im DACH-Raum'),
  TatortStatistic(label: 'Über 50 Ermittler:innen in der Geschichte'),
  TatortStatistic(label: 'Produktionsbudget ca. 1,5–2 Mio. € pro Folge'),
];

const factsInvestigatorTeams = [
  InvestigatorTeamSummary(
    id: 'team_kiel',
    city: 'Kiel',
    teamLabel: 'Team Kiel',
    investigatorNames: 'Borowski, Brandt, Sahin',
    sinceYear: 2003,
    thumbnailAssetPath: AppAssets.portraitKlausBorowski,
    leadInvestigatorId: 'klaus_borowski',
    teamBio:
        'Das Kieler Team um Kommissar Borowski ermittelt seit 2003 an der '
        'Küste – mit Rechtsmedizinerin Sarah Brandt und Kommissarin Mila Sahin.',
    members: [
      TeamMemberSummary(
        name: 'Klaus Borowski',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitKlausBorowski,
        investigatorId: 'klaus_borowski',
      ),
      TeamMemberSummary(
        name: 'Sarah Brandt',
        role: 'Rechtsmedizinerin',
        portraitAssetPath: AppAssets.portraitSarahBrandt,
        investigatorId: 'sarah_brandt',
      ),
      TeamMemberSummary(
        name: 'Mila Sahin',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitMilaSahin,
        investigatorId: 'mila_sahin',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_muenster',
    city: 'Münster',
    teamLabel: 'Team Münster',
    investigatorNames: 'Thiel, Boerne',
    sinceYear: 2002,
    thumbnailAssetPath: AppAssets.portraitFrankThiel,
    leadInvestigatorId: 'frank_thiel',
    teamBio:
        'Seit 2002 arbeiten Kriminalhauptkommissar Thiel und der Pathologe '
        'Prof. Boerne in Münster als eingespieltes Duo – mit trockenem Humor.',
    members: [
      TeamMemberSummary(
        name: 'Frank Thiel',
        role: 'Kriminalhauptkommissar',
        portraitAssetPath: AppAssets.portraitFrankThiel,
        investigatorId: 'frank_thiel',
      ),
      TeamMemberSummary(
        name: 'Prof. Karl-Friedrich Boerne',
        role: 'Pathologe',
        portraitAssetPath: AppAssets.portraitKarlFriedrichBoerne,
        investigatorId: 'karl_friedrich_boerne',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_hamburg',
    city: 'Hamburg',
    teamLabel: 'Team Hamburg',
    investigatorNames: 'Falke, Grosz',
    sinceYear: 2013,
    thumbnailAssetPath: AppAssets.portraitThorstenFalke,
    leadInvestigatorId: 'thorsten_falke',
    teamBio:
        'Thorsten Falke und Julia Grosz ermitteln seit 2013 in Hamburg – '
        'das aktuelle NDR-Tatort-Team der Hansestadt.',
    members: [
      TeamMemberSummary(
        name: 'Thorsten Falke',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitThorstenFalke,
        investigatorId: 'thorsten_falke',
      ),
      TeamMemberSummary(
        name: 'Julia Grosz',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitJuliaGrosz,
        investigatorId: 'julia_grosz',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_wien',
    city: 'Wien',
    teamLabel: 'Team Wien',
    investigatorNames: 'Eisner, Fellner',
    sinceYear: 1999,
    thumbnailAssetPath: AppAssets.portraitMoritzEisner,
    leadInvestigatorId: 'moritz_eisner',
    teamBio:
        'Moritz Eisner und Bibi Fellner sind seit 1999 das österreichische '
        'Tatort-Duo – Fellner stieß 2011 zum Team.',
    members: [
      TeamMemberSummary(
        name: 'Moritz Eisner',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitMoritzEisner,
        investigatorId: 'moritz_eisner',
      ),
      TeamMemberSummary(
        name: 'Bibi Fellner',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitBibiFellner,
        investigatorId: 'bibi_fellner',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_muenchen',
    city: 'München',
    teamLabel: 'Team München',
    investigatorNames: 'Batic, Leitmayr',
    sinceYear: 1991,
    thumbnailAssetPath: AppAssets.portraitIvoBatic,
    leadInvestigatorId: 'ivo_batic',
    teamBio:
        'Ivo Batic und Franz Leitmayr ermitteln seit 1991 in München – '
        'das dienstälteste aktive Tatort-Duo mit über 100 Filmen.',
    members: [
      TeamMemberSummary(
        name: 'Ivo Batic',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitIvoBatic,
        investigatorId: 'ivo_batic',
      ),
      TeamMemberSummary(
        name: 'Franz Leitmayr',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitFranzLeitmayr,
        investigatorId: 'franz_leitmayr',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_stuttgart',
    city: 'Stuttgart',
    teamLabel: 'Team Stuttgart',
    investigatorNames: 'Lannert, Bootz',
    sinceYear: 2008,
    thumbnailAssetPath: AppAssets.portraitThorstenLannert,
    leadInvestigatorId: 'thorsten_lannert',
    teamBio:
        'Thorsten Lannert und Sebastian Bootz ermitteln seit 2008 in '
        'Stuttgart – zwei unterschiedliche Charaktere, ein Team.',
    members: [
      TeamMemberSummary(
        name: 'Thorsten Lannert',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitThorstenLannert,
        investigatorId: 'thorsten_lannert',
      ),
      TeamMemberSummary(
        name: 'Sebastian Bootz',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitSebastianBootz,
        investigatorId: 'sebastian_bootz',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_bremen',
    city: 'Bremen',
    teamLabel: 'Team Bremen',
    investigatorNames: 'Moormann, Selb',
    sinceYear: 2021,
    thumbnailAssetPath: AppAssets.portraitLivMoormann,
    leadInvestigatorId: 'liv_moormann',
    teamBio:
        'Liv Moormann und Linda Selb sind seit 2021 das Tatort-Team von '
        'Radio Bremen – norddeutsch, modern und scharf im Verhör.',
    members: [
      TeamMemberSummary(
        name: 'Liv Moormann',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitLivMoormann,
        investigatorId: 'liv_moormann',
      ),
      TeamMemberSummary(
        name: 'Linda Selb',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitLindaSelb,
        investigatorId: 'linda_selb',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_zuerich',
    city: 'Zürich',
    teamLabel: 'Team Zürich',
    investigatorNames: 'Grandjean, Ott',
    sinceYear: 2020,
    thumbnailAssetPath: AppAssets.portraitIsabelleGrandjean,
    leadInvestigatorId: 'isabelle_grandjean',
    teamBio:
        'Isabelle Grandjean und Tessa Ott bilden seit 2020 das Schweizer '
        'Tatort-Duo aus Zürich.',
    members: [
      TeamMemberSummary(
        name: 'Isabelle Grandjean',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitIsabelleGrandjean,
        investigatorId: 'isabelle_grandjean',
      ),
      TeamMemberSummary(
        name: 'Tessa Ott',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitTessaOtt,
        investigatorId: 'tessa_ott',
      ),
    ],
  ),
  ...factsExtendedInvestigatorTeams,
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
    id: 'berlin',
    name: 'Berlin',
    country: 'Deutschland',
    latitude: 52.5200,
    longitude: 13.4050,
    sinceYear: 2014,
    episodeCount: 12,
    isActive: true,
    imageAssetPath: AppAssets.cityBerlin,
    teamName: 'Team Berlin',
    teamId: 'team_berlin',
    leadInvestigatorId: 'robert_karow',
  ),
  TatortCity(
    id: 'hamburg',
    name: 'Hamburg',
    country: 'Deutschland',
    latitude: 53.5511,
    longitude: 9.9937,
    sinceYear: 1986,
    episodeCount: 42,
    isActive: true,
    imageAssetPath: AppAssets.cityHamburg,
    teamName: 'Team Hamburg',
    teamId: 'team_hamburg',
    leadInvestigatorId: 'thorsten_falke',
  ),
  TatortCity(
    id: 'hannover',
    name: 'Hannover',
    country: 'Deutschland',
    latitude: 52.3759,
    longitude: 9.7320,
    sinceYear: 2014,
    episodeCount: 10,
    isActive: true,
    imageAssetPath: AppAssets.cityHannover,
    teamName: 'Team Hannover',
    teamId: 'team_hannover',
    leadInvestigatorId: 'annegret_lindholm',
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
    sinceYear: 2002,
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
    sinceYear: 1997,
    episodeCount: 95,
    isActive: true,
    imageAssetPath: AppAssets.cityKoeln,
    teamName: 'Team Köln',
    teamId: 'team_koeln',
    leadInvestigatorId: 'max_ballauf',
  ),
  TatortCity(
    id: 'dortmund',
    name: 'Dortmund',
    country: 'Deutschland',
    latitude: 51.5136,
    longitude: 7.4653,
    sinceYear: 2012,
    episodeCount: 28,
    isActive: true,
    imageAssetPath: AppAssets.cityDortmund,
    teamName: 'Team Dortmund',
    teamId: 'team_dortmund',
    leadInvestigatorId: 'peter_faber',
  ),
  TatortCity(
    id: 'dresden',
    name: 'Dresden',
    country: 'Deutschland',
    latitude: 51.0504,
    longitude: 13.7373,
    sinceYear: 2016,
    episodeCount: 16,
    isActive: true,
    imageAssetPath: AppAssets.cityDresden,
    teamName: 'Team Dresden',
    teamId: 'team_dresden',
    leadInvestigatorId: 'peter_michael_schnabel',
  ),
  TatortCity(
    id: 'frankfurt',
    name: 'Frankfurt',
    country: 'Deutschland',
    latitude: 50.1109,
    longitude: 8.6821,
    sinceYear: 2019,
    episodeCount: 12,
    isActive: true,
    imageAssetPath: AppAssets.cityFrankfurt,
    teamName: 'Team Frankfurt',
    teamId: 'team_frankfurt',
    leadInvestigatorId: 'adam_azadi',
  ),
  TatortCity(
    id: 'freiburg',
    name: 'Freiburg',
    country: 'Deutschland',
    latitude: 47.9990,
    longitude: 7.8421,
    sinceYear: 2020,
    episodeCount: 8,
    isActive: true,
    imageAssetPath: AppAssets.cityFreiburg,
    teamName: 'Team Freiburg',
    teamId: 'team_freiburg',
    leadInvestigatorId: 'thorsten_tobler',
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
    imageAssetPath: AppAssets.cityStuttgart,
    teamName: 'Team Stuttgart',
    teamId: 'team_stuttgart',
    leadInvestigatorId: 'thorsten_lannert',
  ),
  TatortCity(
    id: 'nuernberg',
    name: 'Nürnberg',
    country: 'Deutschland',
    latitude: 49.4521,
    longitude: 11.0767,
    sinceYear: 2015,
    episodeCount: 14,
    isActive: true,
    imageAssetPath: AppAssets.cityNuernberg,
    teamName: 'Team Nürnberg',
    teamId: 'team_nuernberg',
    leadInvestigatorId: 'felix_voss',
  ),
  TatortCity(
    id: 'ludwigshafen',
    name: 'Ludwigshafen',
    country: 'Deutschland',
    latitude: 49.4774,
    longitude: 8.4452,
    sinceYear: 1989,
    episodeCount: 72,
    isActive: true,
    imageAssetPath: AppAssets.cityLudwigshafen,
    teamName: 'Team Ludwigshafen',
    teamId: 'team_ludwigshafen',
    leadInvestigatorId: 'lena_odenthal',
  ),
  TatortCity(
    id: 'wiesbaden',
    name: 'Wiesbaden',
    country: 'Deutschland',
    latitude: 50.0782,
    longitude: 8.2398,
    sinceYear: 2014,
    episodeCount: 12,
    isActive: true,
    imageAssetPath: AppAssets.cityWiesbaden,
    teamName: 'Team Wiesbaden',
    teamId: 'team_wiesbaden',
    leadInvestigatorId: 'thorsten_murot',
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
    imageAssetPath: AppAssets.cityMuenchen,
    teamName: 'Team München',
    teamId: 'team_muenchen',
    leadInvestigatorId: 'ivo_batic',
  ),
  TatortCity(
    id: 'wien',
    name: 'Wien',
    country: 'Österreich',
    latitude: 48.2082,
    longitude: 16.3738,
    sinceYear: 1999,
    episodeCount: 36,
    isActive: true,
    imageAssetPath: AppAssets.homeLiveHero,
    teamName: 'Team Wien',
    teamId: 'team_wien',
    leadInvestigatorId: 'moritz_eisner',
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
    sinceYear: 2020,
    episodeCount: 24,
    isActive: true,
    imageAssetPath: AppAssets.episodeSchattenUeberKiel,
    teamName: 'Team Zürich',
    teamId: 'team_zuerich',
    leadInvestigatorId: 'isabelle_grandjean',
  ),
  TatortCity(
    id: 'bremen',
    name: 'Bremen',
    country: 'Deutschland',
    latitude: 53.0793,
    longitude: 8.8017,
    sinceYear: 2021,
    episodeCount: 8,
    isActive: true,
    imageAssetPath: AppAssets.episodeRebellenHamburg,
    teamName: 'Team Bremen',
    teamId: 'team_bremen',
    leadInvestigatorId: 'liv_moormann',
  ),
  TatortCity(
    id: 'saarbruecken',
    name: 'Saarbrücken',
    country: 'Deutschland',
    latitude: 49.2402,
    longitude: 6.9969,
    sinceYear: 2020,
    episodeCount: 6,
    isActive: true,
    imageAssetPath: AppAssets.citySaarbruecken,
    teamName: 'Team Saarbrücken',
    teamId: 'team_saarbruecken',
    leadInvestigatorId: 'adam_schuerk',
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
