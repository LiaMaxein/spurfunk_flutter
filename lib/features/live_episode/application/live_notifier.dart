import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/models/models.dart';
import '../../../shared/mock_data/mock_data.dart';
import '../../../shared/repositories/repository_providers.dart';

class LiveUiState {
  const LiveUiState({
    this.episode,
    this.currentTime,
    this.messages = const [],
    this.onlineCount = 0,
    this.aggregate,
    this.lastEpisodeStats,
    this.hasVoted = false,
    this.selectedVote,
    this.votingOpen = false,
    this.rateLimitHint,
    this.messageTick = 0,
    this.isLoading = true,
  });

  final Episode? episode;
  final DateTime? currentTime;
  final List<ChatMessage> messages;
  final int onlineCount;
  final VoteAggregate? aggregate;
  final PastEpisodeStats? lastEpisodeStats;
  final bool hasVoted;
  final VoteValue? selectedVote;
  final bool votingOpen;
  final String? rateLimitHint;
  final int messageTick;
  final bool isLoading;

  DateTime get now => currentTime ?? DateTime.now();

  bool get isLive => episode != null && episode!.isLiveAt(now);
  bool get chatOpen => isLive;
}

class LiveNotifier extends Notifier<LiveUiState> {
  StreamSubscription<List<ChatMessage>>? _chatSub;
  StreamSubscription<EmojiReaction>? _reactionSub;
  StreamSubscription<int>? _onlineSub;
  StreamSubscription<VoteAggregate>? _voteSub;
  Timer? _ticker;
  String? _episodeId;
  DateTime? _lastMessageAt;
  final List<DateTime> _reactionTimes = [];

  static const _messageCooldown = Duration(seconds: 3);
  static const _reactionWindow = Duration(seconds: 10);
  static const _maxReactionsPerWindow = 5;

  @override
  LiveUiState build() {
    ref.onDispose(_dispose);
    unawaited(_init());
    return const LiveUiState();
  }

  Future<void> _init() async {
    _startTicker();
    await _reloadEpisode();
  }

  Future<void> _reloadEpisode() async {
    await _chatSub?.cancel();
    await _reactionSub?.cancel();
    await _onlineSub?.cancel();
    await _voteSub?.cancel();
    _chatSub = null;
    _reactionSub = null;
    _onlineSub = null;
    _voteSub = null;

    final episodeRepo = ref.read(episodeRepositoryProvider);
    final current = await episodeRepo.getCurrentEpisode();
    final next = await episodeRepo.getNextEpisode();
    final episode = current ?? next;
    final voteRepo = ref.read(voteRepositoryProvider);
    final pastEpisodes = await episodeRepo.getPastEpisodes();
    PastEpisodeStats? lastEpisodeStats;

    if (pastEpisodes.isNotEmpty) {
      final latestPast = pastEpisodes.first;
      lastEpisodeStats = PastEpisodeStats(
        episode: latestPast,
        aggregate: await voteRepo.getVoteAggregate(
          latestPast.id,
          const VoteFilter(),
        ),
        averageLabel: 'Gut',
      );
    }

    if (episode == null) {
      state = LiveUiState(
        currentTime: DateTime.now(),
        lastEpisodeStats: lastEpisodeStats,
        isLoading: false,
      );
      return;
    }

    _episodeId = episode.id;
    final hasVoted = await voteRepo.hasVoted(episode.id);
    final aggregate = await voteRepo.getVoteAggregate(
      episode.id,
      const VoteFilter(),
    );
    final now = DateTime.now();
    final votingOpen = episode.isVotingOpenAt(now);

    state = LiveUiState(
      episode: episode,
      currentTime: now,
      messages: state.messages,
      onlineCount: state.onlineCount,
      aggregate: aggregate,
      lastEpisodeStats: lastEpisodeStats,
      hasVoted: hasVoted,
      votingOpen: votingOpen,
      rateLimitHint: state.rateLimitHint,
      messageTick: state.messageTick,
      isLoading: false,
    );

    if (!episode.isLiveAt(now)) return;

    final chatRepo = ref.read(chatRepositoryProvider);
    _chatSub = chatRepo.watchMessages(episode.id).listen((messages) {
      state = state.copyWith(messages: messages, messageTick: state.messageTick + 1);
    });
    _onlineSub = chatRepo.watchOnlineCount(episode.id).listen((count) {
      state = state.copyWith(onlineCount: count);
    });
    _voteSub = voteRepo.watchVoteAggregate(episode.id).listen((agg) {
      state = state.copyWith(aggregate: agg);
    });
    _reactionSub = chatRepo.watchEmojiReactions(episode.id).listen((_) {});
  }

  Future<void> submitVote(VoteValue value) async {
    final id = _episodeId;
    if (id == null || !state.votingOpen) return;
    final remaining = await ref.read(voteRepositoryProvider).voteCooldownRemaining(id);
    if (remaining != null) {
      final minutes = remaining.inMinutes.clamp(1, 30);
      state = state.copyWith(
        rateLimitHint:
            'Du hast vor Kurzem abgestimmt. Nächste Stimme in ca. $minutes Min.',
      );
      return;
    }
    final ok = await ref.read(voteRepositoryProvider).submitVote(id, value);
    if (!ok) return;
    state = state.copyWith(
      hasVoted: true,
      selectedVote: value,
      rateLimitHint: null,
    );
  }

  Future<void> sendMessage(String text) async {
    final id = _episodeId;
    final trimmed = text.trim();
    if (id == null || trimmed.isEmpty || !state.chatOpen) return;
    final now = DateTime.now();
    if (_lastMessageAt != null &&
        now.difference(_lastMessageAt!) < _messageCooldown) {
      state = state.copyWith(
        rateLimitHint: 'Bitte warte kurz, bevor du erneut schreibst.',
      );
      return;
    }
    _lastMessageAt = now;
    state = state.copyWith(rateLimitHint: null);
    await ref.read(chatRepositoryProvider).sendMessage(id, trimmed);
  }

  Future<void> sendReaction(String emoji) async {
    final id = _episodeId;
    if (id == null || !state.chatOpen) return;
    final now = DateTime.now();
    _reactionTimes.removeWhere((time) => now.difference(time) > _reactionWindow);
    if (_reactionTimes.length >= _maxReactionsPerWindow) {
      state = state.copyWith(
        rateLimitHint: 'Zu viele Reaktionen auf einmal. Versuch es gleich erneut.',
      );
      return;
    }
    _reactionTimes.add(now);
    state = state.copyWith(rateLimitHint: null);
    await ref.read(chatRepositoryProvider).sendEmojiReaction(id, emoji);
  }

  void clearRateLimitHint() {
    if (state.rateLimitHint == null) return;
    state = state.copyWith(rateLimitHint: null);
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => _onTick());
  }

  void _onTick() {
    if (state.isLoading) return;
    final now = DateTime.now();
    final wasLive = state.isLive;
    final isLive = state.episode?.isLiveAt(now) ?? false;

    state = state.copyWith(
      currentTime: now,
      votingOpen: state.episode?.isVotingOpenAt(now) ?? false,
    );

    final shouldReload =
        state.episode == null ||
        wasLive != isLive ||
        (!isLive && state.episode != null && now.isAfter(state.episode!.endsAt));

    if (shouldReload) {
      unawaited(_reloadEpisode());
    }
  }

  void _dispose() {
    _ticker?.cancel();
    _chatSub?.cancel();
    _reactionSub?.cancel();
    _onlineSub?.cancel();
    _voteSub?.cancel();
  }
}

extension on LiveUiState {
  static const _unset = Object();

  LiveUiState copyWith({
    Episode? episode,
    DateTime? currentTime,
    List<ChatMessage>? messages,
    int? onlineCount,
    VoteAggregate? aggregate,
    PastEpisodeStats? lastEpisodeStats,
    bool? hasVoted,
    VoteValue? selectedVote,
    bool? votingOpen,
    Object? rateLimitHint = _unset,
    int? messageTick,
    bool? isLoading,
  }) {
    return LiveUiState(
      episode: episode ?? this.episode,
      currentTime: currentTime ?? this.currentTime,
      messages: messages ?? this.messages,
      onlineCount: onlineCount ?? this.onlineCount,
      aggregate: aggregate ?? this.aggregate,
      lastEpisodeStats: lastEpisodeStats ?? this.lastEpisodeStats,
      hasVoted: hasVoted ?? this.hasVoted,
      selectedVote: selectedVote ?? this.selectedVote,
      votingOpen: votingOpen ?? this.votingOpen,
      rateLimitHint:
          identical(rateLimitHint, _unset)
              ? this.rateLimitHint
              : rateLimitHint as String?,
      messageTick: messageTick ?? this.messageTick,
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
  String? _episodeId;

  @override
  List<FloatingReaction> build() {
    ref.onDispose(() => _sub?.cancel());
    ref.listen(liveNotifierProvider, (prev, next) {
      final id = next.episode?.id;
      if (id != null && id != _episodeId) {
        _episodeId = id;
        state = [];
        _sub?.cancel();
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

RoleAvatarPreset avatarForMessage(ChatMessage msg) {
  return avatarPresetForId(msg.avatarId);
}
