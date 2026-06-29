import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/models.dart';
import '../../../shared/repositories/mock_repositories.dart';

class CommunityStatsState {
  const CommunityStatsState({
    this.episodes = const [],
    this.filter = const VoteFilter(),
    this.isLoading = true,
  });

  final List<PastEpisodeStats> episodes;
  final VoteFilter filter;
  final bool isLoading;

  static const regions = ['Deutschland', 'Österreich', 'Schweiz'];
  static const ageCohorts = ['18-29', '30-39', '40-49', '50+'];
  static const genders = ['weiblich', 'männlich', 'divers'];
}

class CommunityStatsNotifier extends Notifier<CommunityStatsState> {
  @override
  CommunityStatsState build() {
    Future.microtask(_load);
    return const CommunityStatsState();
  }

  Future<void> _load() async {
    final repo = ref.read(communityStatsRepositoryProvider);
    final episodes = await repo.getPastEpisodeStats(state.filter);
    state = CommunityStatsState(
      episodes: episodes,
      filter: state.filter,
      isLoading: false,
    );
  }

  Future<void> setRegion(String? region) async {
    state = CommunityStatsState(
      episodes: state.episodes,
      filter: VoteFilter(
        region: region,
        ageCohort: state.filter.ageCohort,
        gender: state.filter.gender,
      ),
      isLoading: true,
    );
    await _load();
  }

  Future<void> setAgeCohort(String? cohort) async {
    state = CommunityStatsState(
      episodes: state.episodes,
      filter: VoteFilter(
        region: state.filter.region,
        ageCohort: cohort,
        gender: state.filter.gender,
      ),
      isLoading: true,
    );
    await _load();
  }

  Future<void> setGender(String? gender) async {
    state = CommunityStatsState(
      episodes: state.episodes,
      filter: VoteFilter(
        region: state.filter.region,
        ageCohort: state.filter.ageCohort,
        gender: gender,
      ),
      isLoading: true,
    );
    await _load();
  }

  Future<void> clearFilters() async {
    state = const CommunityStatsState(isLoading: true);
    await _load();
  }

  PastEpisodeStats? episodeStatsById(String episodeId) {
    for (final item in state.episodes) {
      if (item.episode.id == episodeId) return item;
    }
    return null;
  }
}

final communityStatsProvider =
    NotifierProvider<CommunityStatsNotifier, CommunityStatsState>(
      CommunityStatsNotifier.new,
    );
