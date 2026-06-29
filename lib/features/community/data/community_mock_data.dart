import '../../../core/assets/app_assets.dart';
import '../../../shared/models/models.dart';

const communityRegisteredUsers = 28734;
const communityTotalPosts = 152869;
const communityOnlineMembers = 1248;

final mockPopularTeams = [
  const PopularTeam(
    rank: 1,
    name: 'Team Borowski',
    portraitAssetPath: AppAssets.portraitKlausBorowski,
    favoriteCount: 3842,
  ),
  const PopularTeam(
    rank: 2,
    name: 'Team Ballauf & Schenk',
    portraitAssetPath: AppAssets.portraitFrankThiel,
    favoriteCount: 2910,
  ),
  const PopularTeam(
    rank: 3,
    name: 'Team Thiel & Borowski',
    portraitAssetPath: AppAssets.portraitMilaSahin,
    favoriteCount: 2156,
  ),
];