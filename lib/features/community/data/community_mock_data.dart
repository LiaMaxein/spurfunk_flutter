import '../../../core/assets/app_assets.dart';
import '../../../shared/models/models.dart';

const communityRegisteredUsers = 28734;
const communityTotalPosts = 152869;
const communityOnlineMembers = 1248;

final mockPopularTeams = [
  const PopularTeam(
    rank: 1,
    name: 'Team Kiel',
    imageAssetPath: AppAssets.liveCaseKielNoirHero,
    favoriteCount: 3842,
    teamId: 'team_kiel',
  ),
  const PopularTeam(
    rank: 2,
    name: 'Team Köln',
    imageAssetPath: AppAssets.cityKoeln,
    favoriteCount: 2910,
    teamId: 'team_koeln',
  ),
  const PopularTeam(
    rank: 3,
    name: 'Team Stuttgart',
    imageAssetPath: AppAssets.cityStuttgart,
    favoriteCount: 2156,
    teamId: 'team_stuttgart',
  ),
];