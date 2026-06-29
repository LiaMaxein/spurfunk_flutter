import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/persistence/shared_preferences_provider.dart';
import '../../facts/data/facts_mock_data.dart';
import '../data/profile_mock_data.dart';
import '../data/profile_models.dart';
import '../../live_episode/data/live_case_mock_data.dart';

final profileFavoritesProvider = Provider<List<FavoriteInvestigatorItem>>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final favorites = <FavoriteInvestigatorItem>[];

  for (final investigator in liveCaseInvestigators) {
    final key = 'favorite_investigator_${investigator.id}';
    if (prefs.getBool(key) == true || investigator.isFavorite) {
      favorites.add(
        FavoriteInvestigatorItem(
          name: investigator.name.split(' ').last,
          city: investigator.teamName?.replaceFirst('Team ', '') ?? 'Kiel',
          portraitAssetPath: investigator.portraitAssetPath,
          routePath: '/live/team/${investigator.id}',
        ),
      );
    }
  }

  for (final team in factsInvestigatorTeams) {
    final key = 'favorite_team_${team.id}';
    if (prefs.getBool(key) == true) {
      final names = team.investigatorNames.split(', ');
      final label = names.length >= 2 ? '${names[0]} & ${names[1]}' : team.teamLabel;
      favorites.add(
        FavoriteInvestigatorItem(
          name: label,
          city: team.city,
          portraitAssetPath: team.thumbnailAssetPath,
          routePath: '/live/team-detail/${team.id}',
          isTeam: true,
        ),
      );
    }
  }

  if (favorites.isEmpty) {
    return profileDefaultFavorites;
  }

  return favorites;
});
