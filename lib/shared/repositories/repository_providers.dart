import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/config/app_config.dart';
import '../../core/demo/force_live_demo_provider.dart';
import '../../core/persistence/shared_preferences_provider.dart';
import 'mock_repositories.dart';
import 'repositories.dart';

/// Central repository wiring. Switches to remote implementations once
/// [AppConfig.useMockRepositories] is false and Supabase is configured.
final episodeRepositoryProvider = Provider<EpisodeRepository>((ref) {
  _ensureMockMode();
  final forceLive = ref.watch(forceLiveDemoProvider);
  return MockEpisodeRepository(forceLiveDemo: forceLive);
});

final voteRepositoryProvider = Provider<VoteRepository>((ref) {
  _ensureMockMode();
  final repo = MockVoteRepository(ref.watch(sharedPreferencesProvider));
  ref.onDispose(repo.dispose);
  return repo;
});

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  _ensureMockMode();
  final repo = MockChatRepository();
  ref.onDispose(repo.dispose);
  return repo;
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  _ensureMockMode();
  return MockNewsRepository();
});

final communityStatsRepositoryProvider =
    Provider<CommunityStatsRepository>((ref) {
  _ensureMockMode();
  return MockCommunityStatsRepository();
});

void _ensureMockMode() {
  assert(
    AppConfig.current.useMockRepositories,
    'Remote repositories are not implemented yet.',
  );
}
