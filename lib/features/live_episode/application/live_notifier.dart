import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/models.dart';
import '../../../shared/mock_data/mock_data.dart';
import '../../../shared/repositories/mock_repositories.dart';

class LiveUiState {
  const LiveUiState({
    this.episode,
    this.messages = const [],
    this.onlineCount = 0,
    this.aggregate,
    this.hasVoted = false,
    this.selectedVote,
    this.votingOpen = false,
    this.isLoading = true,
  });

  final Episode? episode;
  final List<ChatMessage> messages;
  final int onlineCount;
  final VoteAggregate? aggregate;
  final bool hasVoted;
  final VoteValue? selectedVote;
  final bool votingOpen;
  final bool isLoading;

  bool get isLive => episode != null && episode!.isLiveAt(DateTime.now());
}

class LiveNotifier extends Notifier<LiveUiState> {
  StreamSubscription<List<ChatMessage>>? _chatSub;
  StreamSubscription<EmojiReaction>? _reactionSub;
  StreamSubscription<int>? _onlineSub;
  StreamSubscription<VoteAggregate>? _voteSub;
  String? _episodeId;

  @override
  LiveUiState build() {
    ref.onDispose(_dispose);
    _init();
    return const LiveUiState();
  }

  Future<void> _init() async {
    final episodeRepo = ref.read(episodeRepositoryProvider);
    final current = await episodeRepo.getCurrentEpisode();
    final next = await episodeRepo.getNextEpisode();
    final episode = current ?? next;
    if (episode == null) {
      state = const LiveUiState(isLoading: false);
      return;
    }

    _episodeId = episode.id;
    final voteRepo = ref.read(voteRepositoryProvider);
    final chatRepo = ref.read(chatRepositoryProvider);
    final hasVoted = await voteRepo.hasVoted(episode.id);
    final aggregate = await voteRepo.getVoteAggregate(
      episode.id,
      const VoteFilter(),
    );
    final votingOpen = episode.isVotingOpenAt(DateTime.now());

    _chatSub = chatRepo.watchMessages(episode.id).listen((messages) {
      state = state.copyWith(messages: messages);
    });
    _onlineSub = chatRepo.watchOnlineCount(episode.id).listen((count) {
      state = state.copyWith(onlineCount: count);
    });
    _voteSub = voteRepo.watchVoteAggregate(episode.id).listen((agg) {
      state = state.copyWith(aggregate: agg);
    });
    _reactionSub = chatRepo.watchEmojiReactions(episode.id).listen((_) {});

    state = LiveUiState(
      episode: episode,
      aggregate: aggregate,
      hasVoted: hasVoted,
      votingOpen: votingOpen,
      isLoading: false,
    );
  }

  Future<void> submitVote(VoteValue value) async {
    final id = _episodeId;
    if (id == null || state.hasVoted || !state.votingOpen) return;
    await ref.read(voteRepositoryProvider).submitVote(id, value);
    state = state.copyWith(hasVoted: true, selectedVote: value);
  }

  Future<void> sendMessage(String text) async {
    final id = _episodeId;
    if (id == null || text.trim().isEmpty) return;
    await ref.read(chatRepositoryProvider).sendMessage(id, text.trim());
  }

  Future<void> sendReaction(String emoji) async {
    final id = _episodeId;
    if (id == null) return;
    await ref.read(chatRepositoryProvider).sendEmojiReaction(id, emoji);
  }

  void _dispose() {
    _chatSub?.cancel();
    _reactionSub?.cancel();
    _onlineSub?.cancel();
    _voteSub?.cancel();
  }
}

extension on LiveUiState {
  LiveUiState copyWith({
    Episode? episode,
    List<ChatMessage>? messages,
    int? onlineCount,
    VoteAggregate? aggregate,
    bool? hasVoted,
    VoteValue? selectedVote,
    bool? votingOpen,
    bool? isLoading,
  }) {
    return LiveUiState(
      episode: episode ?? this.episode,
      messages: messages ?? this.messages,
      onlineCount: onlineCount ?? this.onlineCount,
      aggregate: aggregate ?? this.aggregate,
      hasVoted: hasVoted ?? this.hasVoted,
      selectedVote: selectedVote ?? this.selectedVote,
      votingOpen: votingOpen ?? this.votingOpen,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final liveNotifierProvider = NotifierProvider<LiveNotifier, LiveUiState>(
  LiveNotifier.new,
);

final floatingReactionsProvider =
    NotifierProvider<FloatingReactionsNotifier, List<FloatingReaction>>(
      FloatingReactionsNotifier.new,
    );

class FloatingReaction {
  const FloatingReaction({
    required this.id,
    required this.emoji,
    required this.createdAt,
  });

  final String id;
  final String emoji;
  final DateTime createdAt;
}

class FloatingReactionsNotifier extends Notifier<List<FloatingReaction>> {
  StreamSubscription<EmojiReaction>? _sub;

  @override
  List<FloatingReaction> build() {
    ref.onDispose(() => _sub?.cancel());
    ref.listen(liveNotifierProvider, (prev, next) {
      final id = next.episode?.id;
      if (id != null && _sub == null) {
        _sub = ref.read(chatRepositoryProvider).watchEmojiReactions(id).listen(
          (reaction) {
            final list = [
              ...state,
              FloatingReaction(
                id: reaction.id,
                emoji: reaction.emoji,
                createdAt: reaction.createdAt,
              ),
            ];
            if (list.length > 12) list.removeRange(0, list.length - 12);
            state = list;
          },
        );
      }
    });
    return [];
  }
}

SymbolicAvatar avatarForMessage(ChatMessage msg) {
  return symbolicAvatars.firstWhere(
    (a) => a.id == msg.avatarId,
    orElse: () => symbolicAvatars.first,
  );
}
