import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spurfunk_flutter/core/persistence/shared_preferences_provider.dart';
import 'package:spurfunk_flutter/features/live_episode/application/live_notifier.dart';
import 'package:spurfunk_flutter/features/live_episode/presentation/investigator_detail_screen.dart';
import 'package:spurfunk_flutter/features/live_episode/presentation/live_episode_screen.dart';
import 'package:spurfunk_flutter/shared/models/models.dart';
import 'package:spurfunk_flutter/shared/repositories/repository_providers.dart';
import 'package:spurfunk_flutter/shared/repositories/repositories.dart';

void main() {
  group('LiveNotifier', () {
    test('applies message rate limiting in live mode', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final chatRepo = _FakeChatRepository();
      final episode = _liveEpisode();

      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          episodeRepositoryProvider.overrideWithValue(
            _FakeEpisodeRepository(current: episode),
          ),
          voteRepositoryProvider.overrideWithValue(_FakeVoteRepository()),
          chatRepositoryProvider.overrideWithValue(chatRepo),
        ],
      );
      addTearDown(container.dispose);

      container.read(liveNotifierProvider);
      await Future<void>.delayed(const Duration(milliseconds: 20));

      await container.read(liveNotifierProvider.notifier).sendMessage('Hallo');
      await container.read(liveNotifierProvider.notifier).sendMessage('Nochmal');

      expect(chatRepo.sentMessages.length, 1);
      expect(
        container.read(liveNotifierProvider).rateLimitHint,
        contains('warte kurz'),
      );
    });
  });

  group('Live UI', () {
    testWidgets('shows non-live countdown and current-case tab', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final nextEpisode = _nextEpisode();

      await tester.pumpWidget(
        _TestApp(
          prefs: prefs,
          overrides: [
            episodeRepositoryProvider.overrideWithValue(
              _FakeEpisodeRepository(next: nextEpisode),
            ),
            voteRepositoryProvider.overrideWithValue(_FakeVoteRepository()),
            chatRepositoryProvider.overrideWithValue(_FakeChatRepository()),
          ],
          child: const LiveEpisodeScreen(),
        ),
      );

      await tester.pump(const Duration(milliseconds: 50));

      expect(find.text('HEUTE IST KEIN TATORT LIVE'), findsOneWidget);
      expect(find.text('Mitwisser-Chat'), findsOneWidget);
      expect(find.text('Aktueller Fall'), findsOneWidget);

      await tester.tap(find.text('Aktueller Fall'));
      await tester.pumpAndSettle();

      expect(find.text('ERMITTLER:INNEN'), findsOneWidget);
      expect(find.text('FOLGE AUF EINEN BLICK'), findsOneWidget);
    });

    testWidgets('renders investigator detail screen', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        _TestApp(
          prefs: prefs,
          child: const InvestigatorDetailScreen(
            investigatorId: 'klaus_borowski',
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('TEAM-DETAIL'), findsOneWidget);
      expect(find.text('BELIEBTESTE FOLGEN'), findsOneWidget);
      expect(find.text('Mehr über das Team'), findsOneWidget);
    });
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({
    required this.prefs,
    required this.child,
    this.overrides = const [],
  });

  final SharedPreferences prefs;
  final Widget child;
  final List<dynamic> overrides;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        ...overrides,
      ],
      child: MaterialApp(home: child),
    );
  }
}

class _FakeEpisodeRepository implements EpisodeRepository {
  _FakeEpisodeRepository({this.current, this.next, this.past = const []});

  final Episode? current;
  final Episode? next;
  final List<Episode> past;

  @override
  Future<Episode?> getCurrentEpisode() async => current;

  @override
  Future<Episode?> getNextEpisode() async => next;

  @override
  Future<List<Episode>> getPastEpisodes() async =>
      past.isEmpty ? [_pastEpisode()] : past;
}

class _FakeVoteRepository implements VoteRepository {
  @override
  Future<VoteAggregate> getVoteAggregate(String episodeId, VoteFilter filter) async {
    return VoteAggregate(
      episodeId: episodeId,
      schlecht: 10,
      langweilig: 20,
      okay: 30,
      gut: 25,
      mega: 15,
    );
  }

  @override
  Future<bool> hasVoted(String episodeId) async => false;

  @override
  Future<bool> submitVote(String episodeId, VoteValue value) async => true;

  @override
  Future<Duration?> voteCooldownRemaining(String episodeId) async => null;

  @override
  Future<VoteValue?> lastVote(String episodeId) async => null;

  @override
  Stream<VoteAggregate> watchVoteAggregate(String episodeId) async* {
    yield await getVoteAggregate(episodeId, const VoteFilter());
  }
}

class _FakeChatRepository implements ChatRepository {
  final sentMessages = <String>[];
  final _messagesController =
      StreamController<List<ChatMessage>>.broadcast(sync: true);
  final _reactionController =
      StreamController<EmojiReaction>.broadcast(sync: true);
  final _onlineController = StreamController<int>.broadcast(sync: true);

  _FakeChatRepository() {
    _onlineController.add(1248);
    _messagesController.add([
      ChatMessage(
        id: 'seed-1',
        episodeId: 'live-1',
        userId: 'user-1',
        alias: 'Anna',
        avatarId: 'laterne',
        content: 'Das war doch Absicht!',
        createdAt: DateTime(2026, 6, 29, 20, 16),
      ),
    ]);
  }

  @override
  Future<void> sendEmojiReaction(String episodeId, String emoji) async {
    _reactionController.add(
      EmojiReaction(
        id: 'rx-1',
        episodeId: episodeId,
        userId: 'local-user',
        emoji: emoji,
        createdAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> sendMessage(String episodeId, String content) async {
    sentMessages.add(content);
  }

  @override
  Stream<int> watchOnlineCount(String episodeId) => _onlineController.stream;

  @override
  Stream<EmojiReaction> watchEmojiReactions(String episodeId) =>
      _reactionController.stream;

  @override
  Stream<List<ChatMessage>> watchMessages(String episodeId) => _messagesController.stream;
}

Episode _liveEpisode() {
  final now = DateTime.now();
  return Episode(
    id: 'live-1',
    title: 'Borowski und das Haupt der Medusa',
    sender: 'Das Erste',
    startsAt: now.subtract(const Duration(minutes: 10)),
    endsAt: now.add(const Duration(minutes: 20)),
    description: 'Live-Fall',
    location: 'Kiel',
    investigatorIds: const [
      'klaus_borowski',
      'mila_sahin',
      'frank_thiel',
      'sarah_brandt',
    ],
  );
}

Episode _nextEpisode() {
  final now = DateTime.now();
  return Episode(
    id: 'next-1',
    title: 'Borowski und das Haupt der Medusa',
    sender: 'Das Erste',
    startsAt: now.add(const Duration(days: 2, hours: 14, minutes: 37, seconds: 28)),
    endsAt: now.add(const Duration(days: 2, hours: 16, minutes: 7, seconds: 28)),
    description: 'Naechster Fall',
    location: 'Kiel',
    investigatorIds: const [
      'klaus_borowski',
      'mila_sahin',
      'frank_thiel',
      'sarah_brandt',
    ],
  );
}

Episode _pastEpisode() {
  return Episode(
    id: 'past-1',
    title: 'Tatort: Schatten ueber Kiel',
    sender: 'Das Erste',
    startsAt: DateTime(2025, 5, 11, 20, 15),
    endsAt: DateTime(2025, 5, 11, 21, 45),
    description: 'Vergangener Fall',
    location: 'Kiel',
  );
}
