import '../../../core/assets/app_assets.dart';
import 'facts_models.dart';

/// Additional active Tatort teams (Wikipedia stand 2025/26).
const factsExtendedInvestigatorTeams = [
  InvestigatorTeamSummary(
    id: 'team_berlin',
    city: 'Berlin',
    teamLabel: 'Team Berlin',
    investigatorNames: 'Karow, Bonard',
    sinceYear: 2014,
    thumbnailAssetPath: AppAssets.portraitRobertKarow,
    leadInvestigatorId: 'robert_karow',
    teamBio:
        'Robert Karow und Semir Bonard ermitteln seit 2014 in Berlin – '
        'zwei unterschiedliche Charaktere in der Hauptstadt.',
    members: [
      TeamMemberSummary(
        name: 'Robert Karow',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitRobertKarow,
        investigatorId: 'robert_karow',
      ),
      TeamMemberSummary(
        name: 'Semir Bonard',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitSemirBonard,
        investigatorId: 'semir_bonard',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_koeln',
    city: 'Köln',
    teamLabel: 'Team Köln',
    investigatorNames: 'Ballauf, Schenk',
    sinceYear: 1997,
    thumbnailAssetPath: AppAssets.portraitMaxBallauf,
    leadInvestigatorId: 'max_ballauf',
    teamBio:
        'Max Ballauf und Freddy Schenk sind seit 1997 das Kölner Tatort-Duo – '
        'eines der beliebtesten Teams der Reihe.',
    members: [
      TeamMemberSummary(
        name: 'Max Ballauf',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitMaxBallauf,
        investigatorId: 'max_ballauf',
      ),
      TeamMemberSummary(
        name: 'Freddy Schenk',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitFreddySchenk,
        investigatorId: 'freddy_schenk',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_dortmund',
    city: 'Dortmund',
    teamLabel: 'Team Dortmund',
    investigatorNames: 'Faber, Herzog',
    sinceYear: 2012,
    thumbnailAssetPath: AppAssets.portraitPeterFaber,
    leadInvestigatorId: 'peter_faber',
    teamBio:
        'Peter Faber und Rosa Herzog ermitteln seit 2012 im Ruhrgebiet – '
        'roh, direkt und nah am sozialen Brennpunkt.',
    members: [
      TeamMemberSummary(
        name: 'Peter Faber',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitPeterFaber,
        investigatorId: 'peter_faber',
      ),
      TeamMemberSummary(
        name: 'Rosa Herzog',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitRosaHerzog,
        investigatorId: 'rosa_herzog',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_dresden',
    city: 'Dresden',
    teamLabel: 'Team Dresden',
    investigatorNames: 'Schnabel, Winkler',
    sinceYear: 2016,
    thumbnailAssetPath: AppAssets.portraitPeterMichaelSchnabel,
    leadInvestigatorId: 'peter_michael_schnabel',
    teamBio:
        'Peter Michael Schnabel und Leonie Winkler bilden seit 2016 '
        'das sächsische Tatort-Team.',
    members: [
      TeamMemberSummary(
        name: 'Peter Michael Schnabel',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitPeterMichaelSchnabel,
        investigatorId: 'peter_michael_schnabel',
      ),
      TeamMemberSummary(
        name: 'Leonie Winkler',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitLeonieWinkler,
        investigatorId: 'leonie_winkler',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_frankfurt',
    city: 'Frankfurt',
    teamLabel: 'Team Frankfurt',
    investigatorNames: 'Azadi, Kulina',
    sinceYear: 2019,
    thumbnailAssetPath: AppAssets.portraitAdamAzadi,
    leadInvestigatorId: 'adam_azadi',
    teamBio:
        'Adam Azadi und Aline Kulina sind seit 2019 das Frankfurter '
        'Tatort-Duo am Main.',
    members: [
      TeamMemberSummary(
        name: 'Adam Azadi',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitAdamAzadi,
        investigatorId: 'adam_azadi',
      ),
      TeamMemberSummary(
        name: 'Aline Kulina',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitAlineKulina,
        investigatorId: 'aline_kulina',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_freiburg',
    city: 'Freiburg',
    teamLabel: 'Team Freiburg',
    investigatorNames: 'Tobler, Berg',
    sinceYear: 2020,
    thumbnailAssetPath: AppAssets.portraitThorstenTobler,
    leadInvestigatorId: 'thorsten_tobler',
    teamBio:
        'Thorsten Tobler und Sebastian Berg ermitteln seit 2020 '
        'in Freiburg und dem Breisgau.',
    members: [
      TeamMemberSummary(
        name: 'Thorsten Tobler',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitThorstenTobler,
        investigatorId: 'thorsten_tobler',
      ),
      TeamMemberSummary(
        name: 'Sebastian Berg',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitSebastianBerg,
        investigatorId: 'sebastian_berg',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_hannover',
    city: 'Hannover',
    teamLabel: 'Team Hannover',
    investigatorNames: 'Lindholm',
    sinceYear: 2014,
    thumbnailAssetPath: AppAssets.portraitAnnegretLindholm,
    leadInvestigatorId: 'annegret_lindholm',
    teamBio:
        'Annegret Lindholm ermittelt seit 2014 als Solo-Ermittlerin in Hannover.',
    members: [
      TeamMemberSummary(
        name: 'Annegret Lindholm',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitAnnegretLindholm,
        investigatorId: 'annegret_lindholm',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_ludwigshafen',
    city: 'Ludwigshafen',
    teamLabel: 'Team Ludwigshafen',
    investigatorNames: 'Odenthal, Stern',
    sinceYear: 1989,
    thumbnailAssetPath: AppAssets.portraitLenaOdenthal,
    leadInvestigatorId: 'lena_odenthal',
    teamBio:
        'Lena Odenthal und Frank Stern sind das dienstälteste aktive Duo '
        'der Tatort-Reihe – seit 1989 in Ludwigshafen.',
    members: [
      TeamMemberSummary(
        name: 'Lena Odenthal',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitLenaOdenthal,
        investigatorId: 'lena_odenthal',
      ),
      TeamMemberSummary(
        name: 'Frank Stern',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitFrankStern,
        investigatorId: 'frank_stern',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_nuernberg',
    city: 'Nürnberg',
    teamLabel: 'Team Nürnberg',
    investigatorNames: 'Voss, Rathgeber',
    sinceYear: 2015,
    thumbnailAssetPath: AppAssets.portraitFelixVoss,
    leadInvestigatorId: 'felix_voss',
    teamBio:
        'Felix Voss und Emilia Rathgeber ermitteln seit 2015 im Franken-Tatort.',
    members: [
      TeamMemberSummary(
        name: 'Felix Voss',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitFelixVoss,
        investigatorId: 'felix_voss',
      ),
      TeamMemberSummary(
        name: 'Emilia Rathgeber',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitEmiliaRathgeber,
        investigatorId: 'emilia_rathgeber',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_wiesbaden',
    city: 'Wiesbaden',
    teamLabel: 'Team Wiesbaden',
    investigatorNames: 'Murot',
    sinceYear: 2014,
    thumbnailAssetPath: AppAssets.portraitThorstenMurot,
    leadInvestigatorId: 'thorsten_murot',
    teamBio:
        'Thorsten Murot ermittelt seit 2014 als Solo-Ermittler in Wiesbaden.',
    members: [
      TeamMemberSummary(
        name: 'Thorsten Murot',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitThorstenMurot,
        investigatorId: 'thorsten_murot',
      ),
    ],
  ),
  InvestigatorTeamSummary(
    id: 'team_saarbruecken',
    city: 'Saarbrücken',
    teamLabel: 'Team Saarbrücken',
    investigatorNames: 'Schürk, Hölzer, Baumann, Heinrich',
    sinceYear: 2020,
    thumbnailAssetPath: AppAssets.portraitAdamSchuerk,
    leadInvestigatorId: 'adam_schuerk',
    teamBio:
        'Adam Schürk, Leo Hölzer, Esther Baumann und Pia Heinrich bilden '
        'seit 2020 das vierköpfige Tatort-Team des Saarländischen Rundfunks.',
    members: [
      TeamMemberSummary(
        name: 'Adam Schürk',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitAdamSchuerk,
        investigatorId: 'adam_schuerk',
      ),
      TeamMemberSummary(
        name: 'Leo Hölzer',
        role: 'Kommissar',
        portraitAssetPath: AppAssets.portraitLeoHoelzer,
        investigatorId: 'leo_hoelzer',
      ),
      TeamMemberSummary(
        name: 'Esther Baumann',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitEstherBaumann,
        investigatorId: 'esther_baumann',
      ),
      TeamMemberSummary(
        name: 'Pia Heinrich',
        role: 'Kommissarin',
        portraitAssetPath: AppAssets.portraitPiaHeinrich,
        investigatorId: 'pia_heinrich',
      ),
    ],
  ),
];
