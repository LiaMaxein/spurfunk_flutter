/// Central asset paths for Spurfunk.
abstract final class AppAssets {
  static const _mockups = 'assets/mockups';
  static const _branding = 'assets/branding';
  static const _photos = 'assets/photos';

  // Photos (Noir hero imagery)
  static const splashNoirCouple = '$_photos/splash_noir_couple.png';
  static const communityNoirHero = '$_photos/community_noir_hero.png';
  static const homeLiveHero = '$_photos/home_live_hero.png';
  static const factsPageHero = homeLiveHero;
  static const communityHero = communityNoirHero;
  static const liveCaseKielNoirHero = '$_photos/live_case_kiel_noir_hero.png';

  static const profileHeroBackgrounds = [
    '$_photos/profile_hero_01.png',
    '$_photos/profile_hero_02.png',
    '$_photos/profile_hero_03.png',
    '$_photos/profile_hero_04.png',
    '$_photos/profile_hero_05.png',
    '$_photos/profile_hero_06.png',
    '$_photos/profile_hero_07.png',
    '$_photos/profile_hero_08.png',
    '$_photos/profile_hero_09.png',
    '$_photos/profile_hero_10.png',
  ];
  static const episodeSchattenUeberKiel = '$_photos/episode_schatten_ueber_kiel.png';
  static const episodeRebellenHamburg = '$_photos/episode_rebellen_hamburg.png';
  static const episodeMedusaKiel = '$_photos/episode_medusa_kiel.png';

  // Investigator portraits
  static const portraitKlausBorowski = '$_photos/portrait_klaus_borowski.png';
  static const portraitMilaSahin = '$_photos/portrait_mila_sahin.png';
  static const portraitFrankThiel = '$_photos/portrait_frank_thiel.png';
  static const portraitSarahBrandt = '$_photos/portrait_sarah_brandt.png';

  // Branding (SVG)
  static const logoNameIcon = '$_branding/spurfunk_logo_name_icon.svg';
  static const logoNameClaim = '$_branding/spurfunk_logo_name_clain.svg';
  static const appIconSvg = '$_branding/spurfunk_app_icon.svg';

  static const avatarLaterne = '$_branding/avatar_01_laterne.svg';
  static const avatarFrauProfil = '$_branding/avatar_02_frau_profil.svg';
  static const avatarFingerabdruck = '$_branding/avatar_03_fingerabdruck.svg';
  static const avatarDetektivHut = '$_branding/avatar_04_detektiv_hut.svg';
  static const avatarLupe = '$_branding/avatar_05_lupe.svg';
  static const avatarMannProfil = '$_branding/avatar_06_mann_profil.svg';
  static const avatarAktenordner = '$_branding/avatar_07_aktenordner.svg';
  static const avatarFussabdruecke = '$_branding/avatar_08_fussabdruecke.svg';
  static const avatarFrauRuecken = '$_branding/avatar_09_frau_ruecken.svg';
  static const avatarPistole = '$_branding/avatar_10_pistole.svg';
  static const avatarBeweisbeutel = '$_branding/avatar_11_beweisbeutel.svg';
  static const avatarLampe = '$_branding/avatar_12_lampe.svg';

  static const splash = '$_mockups/mockup_splashscreen.png';
  static const onboardingWelcome = '$_mockups/mockup_onboarding-willkommen.png';
  static const onboardingIdentity = '$_mockups/mockup_onboarding-identitaet-waehlen.png';
  static const onboardingAlias = '$_mockups/mockup_onboarding-namen-waehlen.png';
  static const onboardingConfirm = '$_mockups/mockup_onboarding_identitaet-bestaetigt.png';
  static const homeNoLive = '$_mockups/mockup_home-kein-live.png';
  static const homeLive = '$_mockups/mockup_home-live.png';
  static const liveArea = '$_mockups/mockup_bereich-live.png';
  static const liveChatMockup =
      '$_mockups/SpurFunk_Live-Bereich_Mitwisser-Chat-Tatort-gerade-Live.png';
  static const liveCountdownMockup =
      '$_mockups/SpurFunk_Live-Bereich_Kein-Tatort-Live-Countdown.png';
  static const liveCurrentCaseMockup =
      '$_mockups/SpurFunk_Live-Bereich_Aktueller-Fall-Uebersicht.png';
  static const liveTeamDetailMockup =
      '$_mockups/SpurFunk_Live-Bereich_Team-Detail.png';
  static const community = '$_mockups/mockup_community-bereich.png';
  static const facts = '$_mockups/mockup_bereich-fakten.png';
  static const profile = '$_mockups/mockup_bereich-profil.png';
  static const avatars = '$_mockups/mockup_avatare.png';
  static const appIcon = '$_mockups/mockup_app-icon.png';
  static const logoHeader = '$_mockups/mockup_horizontales-logo-header.png';
  static const logoWithSubtitle = '$_mockups/mockup_horizontales-logo-mit-untertitel.png';
  static const logoFullMockup =
      '$_mockups/mockup_horizontales-logo-mit-untertitel-und-app-icon.png';

  /// Hero imagery for episodes and home cards.
  static const heroEpisode = homeLive;

  static String heroForLocation(String? location) {
    switch (location?.toLowerCase()) {
      case 'hamburg':
        return episodeRebellenHamburg;
      case 'kiel':
        return liveCaseKielNoirHero;
      default:
        return homeLiveHero;
    }
  }
}
