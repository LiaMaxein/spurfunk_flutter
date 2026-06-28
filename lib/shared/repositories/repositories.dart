import '../models/models.dart';

abstract class AuthRepository {
  Future<UserProfile> createLocalProfile(CreateProfileInput input);
  Future<UserProfile?> getCurrentProfile();
  Future<void> updateProfile(UserProfile profile);
  Future<void> logout();
}

abstract class EpisodeRepository {
  Future<Episode?> getCurrentEpisode();
  Future<Episode?> getNextEpisode();
  Future<List<Episode>> getPastEpisodes();
}

abstract class VoteRepository {
  Future<void> submitVote(String episodeId, VoteValue value);
  Stream<VoteAggregate> watchVoteAggregate(String episodeId);
  Future<VoteAggregate> getVoteAggregate(String episodeId, VoteFilter filter);
  Future<bool> hasVoted(String episodeId);
}

abstract class ChatRepository {
  Stream<List<ChatMessage>> watchMessages(String episodeId);
  Future<void> sendMessage(String episodeId, String content);
  Future<void> sendEmojiReaction(String episodeId, String emoji);
  Stream<EmojiReaction> watchEmojiReactions(String episodeId);
  Stream<int> watchOnlineCount(String episodeId);
}

abstract class NewsRepository {
  Future<List<NewsItem>> getLatestNews();
  Future<NewsItem> getNewsById(String id);
}

abstract class CommunityStatsRepository {
  Future<List<PastEpisodeStats>> getPastEpisodeStats(VoteFilter filter);
}
