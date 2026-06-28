import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/models.dart';
import '../../../shared/repositories/mock_repositories.dart';

class HomeUiState {
  const HomeUiState({
    this.currentEpisode,
    this.nextEpisode,
    this.news = const [],
    this.lastVoteAggregate,
    this.isLoading = true,
    this.error,
  });

  final Episode? currentEpisode;
  final Episode? nextEpisode;
  final List<NewsItem> news;
  final VoteAggregate? lastVoteAggregate;
  final bool isLoading;
  final String? error;

  bool get isLive => currentEpisode != null;
}

class HomeNotifier extends AsyncNotifier<HomeUiState> {
  @override
  Future<HomeUiState> build() async {
    final episodes = ref.read(episodeRepositoryProvider);
    final newsRepo = ref.read(newsRepositoryProvider);
    final voteRepo = ref.read(voteRepositoryProvider);

    final current = await episodes.getCurrentEpisode();
    final next = await episodes.getNextEpisode();
    final news = await newsRepo.getLatestNews();
    final past = await episodes.getPastEpisodes();
    VoteAggregate? lastAgg;
    if (past.isNotEmpty) {
      lastAgg = await voteRepo.getVoteAggregate(
        past.first.id,
        const VoteFilter(),
      );
    }

    return HomeUiState(
      currentEpisode: current,
      nextEpisode: next ?? current,
      news: news,
      lastVoteAggregate: lastAgg,
      isLoading: false,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await build());
  }
}

final homeNotifierProvider =
    AsyncNotifierProvider<HomeNotifier, HomeUiState>(HomeNotifier.new);
