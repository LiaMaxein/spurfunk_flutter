import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';
import '../mock_data/mock_data.dart';
import '../repositories/repositories.dart';

class MockAuthRepository implements AuthRepository {
  MockAuthRepository(this._prefs);

  final SharedPreferences _prefs;
  static const _profileKey = 'mock_profile_json';

  @override
  Future<UserProfile> createLocalProfile(CreateProfileInput input) async {
    final profile = UserProfile(
      id: 'local-user',
      alias: input.alias,
      avatarId: input.avatarId,
      isAnonymous: input.isAnonymous,
      region: input.region,
      ageCohort: input.ageCohort,
      gender: input.gender,
      xp: 1620,
      level: 12,
      createdAt: DateTime.now(),
    );
    await _save(profile);
    return profile;
  }

  @override
  Future<UserProfile?> getCurrentProfile() async {
    final alias = _prefs.getString('username');
    final avatarId = _prefs.getString('avatar_id') ?? 'laterne';
    final anonymous = _prefs.getBool('anonymous_mode') ?? true;
    if (!(_prefs.getBool('onboarding_completed') ?? false)) return null;
    return UserProfile(
      id: 'local-user',
      alias: alias,
      avatarId: avatarId,
      isAnonymous: anonymous,
      region: 'Deutschland',
      ageCohort: '30-39',
      xp: 1620,
      level: 12,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    await _save(profile);
  }

  @override
  Future<void> logout() async {
    await _prefs.remove(_profileKey);
    await _prefs.setBool('onboarding_completed', false);
  }

  Future<void> _save(UserProfile profile) async {
    await _prefs.setString('avatar_id', profile.avatarId);
    if (profile.alias != null) {
      await _prefs.setString('username', profile.alias!);
    }
    await _prefs.setBool('anonymous_mode', profile.isAnonymous);
  }
}

class MockEpisodeRepository implements EpisodeRepository {
  MockEpisodeRepository({this.forceLiveDemo = false});

  final bool forceLiveDemo;

  @override
  Future<Episode?> getCurrentEpisode() async {
    if (forceLiveDemo) return buildDemoLiveEpisode();
    final ep = mockCurrentEpisode;
    return ep.isLiveAt(DateTime.now()) ? ep : null;
  }

  @override
  Future<Episode?> getNextEpisode() async {
    if (forceLiveDemo) return null;
    final ep = mockCurrentEpisode;
    if (ep.isLiveAt(DateTime.now())) return null;
    return ep;
  }

  @override
  Future<List<Episode>> getPastEpisodes() async => mockPastEpisodes;
}

class MockVoteRepository implements VoteRepository {
  MockVoteRepository(this._prefs);

  final SharedPreferences _prefs;
  final _controllers = <String, StreamController<VoteAggregate>>{};

  @override
  Future<void> submitVote(String episodeId, VoteValue value) async {
    final key = 'vote_$episodeId';
    if (_prefs.containsKey(key)) return;
    await _prefs.setString(key, value.name);
    _emit(episodeId);
  }

  @override
  Stream<VoteAggregate> watchVoteAggregate(String episodeId) {
    _controllers.putIfAbsent(
      episodeId,
      () => StreamController<VoteAggregate>.broadcast(),
    );
    Future.microtask(() => _emit(episodeId));
    return _controllers[episodeId]!.stream;
  }

  @override
  Future<VoteAggregate> getVoteAggregate(
    String episodeId,
    VoteFilter filter,
  ) async =>
      mockAggregateFor(episodeId, filter: filter);

  @override
  Future<bool> hasVoted(String episodeId) async =>
      _prefs.containsKey('vote_$episodeId');

  void _emit(String episodeId) {
    final aggregate = mockAggregateFor(episodeId);
    _controllers[episodeId]?.add(aggregate);
  }

  void dispose() {
    for (final c in _controllers.values) {
      c.close();
    }
  }
}

class MockChatRepository implements ChatRepository {
  MockChatRepository() {
    _startSimulation();
  }

  final _messageControllers = <String, StreamController<List<ChatMessage>>>{};
  final _reactionControllers = <String, StreamController<EmojiReaction>>{};
  final _onlineControllers = <String, StreamController<int>>{};
  final _messages = <String, List<ChatMessage>>{};
  Timer? _timer;
  var _tick = 0;

  void _startSimulation() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      _tick++;
      for (final episodeId in _messageControllers.keys) {
        _addSimulatedMessage(episodeId);
      }
    });
  }

  void _addSimulatedMessage(String episodeId) {
    final seed = mockChatSeed[_tick % mockChatSeed.length];
    final msg = ChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      episodeId: episodeId,
      userId: 'user-${_tick % 5}',
      alias: seed.$1,
      avatarId: symbolicAvatars[_tick % symbolicAvatars.length].id,
      content: seed.$2,
      createdAt: DateTime.now(),
    );
    _messages.putIfAbsent(episodeId, () => []);
    final list = [..._messages[episodeId]!, msg];
    if (list.length > 50) list.removeRange(0, list.length - 50);
    _messages[episodeId] = list;
    _messageControllers[episodeId]?.add(list);
    _onlineControllers[episodeId]?.add(1248 + (_tick % 20));
  }

  @override
  Stream<List<ChatMessage>> watchMessages(String episodeId) {
    _messages.putIfAbsent(episodeId, () {
      final initial = <ChatMessage>[];
      for (var i = 0; i < 5; i++) {
        final seed = mockChatSeed[i];
        initial.add(
          ChatMessage(
            id: 'seed-$i',
            episodeId: episodeId,
            userId: 'user-$i',
            alias: seed.$1,
            avatarId: symbolicAvatars[i % symbolicAvatars.length].id,
            content: seed.$2,
            createdAt: DateTime.now().subtract(Duration(minutes: 5 - i)),
          ),
        );
      }
      return initial;
    });
    _messageControllers.putIfAbsent(
      episodeId,
      () => StreamController<List<ChatMessage>>.broadcast(),
    );
    Future.microtask(
      () => _messageControllers[episodeId]?.add(_messages[episodeId]!),
    );
    return _messageControllers[episodeId]!.stream;
  }

  @override
  Future<void> sendMessage(String episodeId, String content) async {
    final msg = ChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      episodeId: episodeId,
      userId: 'local-user',
      alias: 'Du',
      avatarId: 'fingerabdruck',
      content: content,
      createdAt: DateTime.now(),
    );
    _messages.putIfAbsent(episodeId, () => []);
    _messages[episodeId] = [..._messages[episodeId]!, msg];
    _messageControllers[episodeId]?.add(_messages[episodeId]!);
  }

  @override
  Future<void> sendEmojiReaction(String episodeId, String emoji) async {
    final reaction = EmojiReaction(
      id: 'rx-${DateTime.now().millisecondsSinceEpoch}',
      episodeId: episodeId,
      userId: 'local-user',
      emoji: emoji,
      createdAt: DateTime.now(),
    );
    _reactionControllers.putIfAbsent(
      episodeId,
      () => StreamController<EmojiReaction>.broadcast(),
    );
    _reactionControllers[episodeId]?.add(reaction);
  }

  @override
  Stream<EmojiReaction> watchEmojiReactions(String episodeId) {
    _reactionControllers.putIfAbsent(
      episodeId,
      () => StreamController<EmojiReaction>.broadcast(),
    );
    return _reactionControllers[episodeId]!.stream;
  }

  @override
  Stream<int> watchOnlineCount(String episodeId) {
    _onlineControllers.putIfAbsent(
      episodeId,
      () => StreamController<int>.broadcast(),
    );
    Future.microtask(() => _onlineControllers[episodeId]?.add(1248));
    return _onlineControllers[episodeId]!.stream;
  }

  void dispose() {
    _timer?.cancel();
    for (final c in _messageControllers.values) {
      c.close();
    }
    for (final c in _reactionControllers.values) {
      c.close();
    }
    for (final c in _onlineControllers.values) {
      c.close();
    }
  }
}

class MockNewsRepository implements NewsRepository {
  @override
  Future<List<NewsItem>> getLatestNews() async => mockNewsItems;

  @override
  Future<NewsItem> getNewsById(String id) async =>
      mockNewsItems.firstWhere((n) => n.id == id);
}

class MockCommunityStatsRepository implements CommunityStatsRepository {
  @override
  Future<List<PastEpisodeStats>> getPastEpisodeStats(VoteFilter filter) async {
    return mockPastEpisodes.map((ep) {
      final agg = mockAggregateFor(ep.id, filter: filter);
      return PastEpisodeStats(
        episode: ep,
        aggregate: agg,
        averageLabel: averageLabelForAggregate(agg),
      );
    }).toList();
  }
}

// Repository providers moved to repository_providers.dart.
