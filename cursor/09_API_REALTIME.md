# 09 – API & Realtime

## Grundsatz

Im Prototyp werden alle Endpunkte durch lokale Repositories und Mock-Daten simuliert. Die Schnittstellen sollen aber so gestaltet sein, dass später Supabase angebunden werden kann.

## Repository Interfaces

### AuthRepository

```dart
abstract class AuthRepository {
  Future<UserProfile> createLocalProfile(CreateProfileInput input);
  Future<UserProfile?> getCurrentProfile();
  Future<void> updateProfile(UserProfile profile);
  Future<void> logout();
}
```

### EpisodeRepository

```dart
abstract class EpisodeRepository {
  Future<Episode?> getCurrentEpisode();
  Future<Episode?> getNextEpisode();
  Future<List<Episode>> getPastEpisodes();
}
```

### VoteRepository

```dart
abstract class VoteRepository {
  Future<void> submitVote(String episodeId, VoteValue value);
  Stream<VoteAggregate> watchVoteAggregate(String episodeId);
  Future<VoteAggregate> getVoteAggregate(String episodeId, VoteFilter filter);
}
```

### ChatRepository

```dart
abstract class ChatRepository {
  Stream<List<ChatMessage>> watchMessages(String episodeId);
  Future<void> sendMessage(String episodeId, String content);
  Future<void> sendEmojiReaction(String episodeId, String emoji);
  Stream<EmojiReaction> watchEmojiReactions(String episodeId);
}
```

### NewsRepository

```dart
abstract class NewsRepository {
  Future<List<NewsItem>> getLatestNews();
  Future<NewsItem> getNewsById(String id);
}
```

### FactsRepository

```dart
abstract class FactsRepository {
  Future<List<InvestigatorTeam>> getTeams();
  Future<InvestigatorTeam> getTeamById(String id);
  Future<void> toggleFavoriteTeam(String teamId);
}
```

### GamificationRepository

```dart
abstract class GamificationRepository {
  Future<List<QuizQuestion>> getQuizQuestions({String? category, int limit = 15});
  Future<QuizResult> submitQuizResult(QuizResult result);
  Future<MemoryGameResult> submitMemoryResult(MemoryGameResult result);
  Future<List<Badge>> getBadges();
  Future<List<UserBadge>> getUserBadges();
  Future<List<LeaderboardEntry>> getLeaderboard(LeaderboardPeriod period);
}
```

## Realtime Channels

| Channel | Zweck |
|---|---|
| `episode:{episodeId}:votes` | Live-Aggregate für Voting |
| `episode:{episodeId}:chat` | neue Chatnachrichten |
| `episode:{episodeId}:reactions` | flüchtige Emoji-Reaktionen |
| `global:online` | aktive Nutzer:innen / Mitwisser |

## Rate Limiting

- Maximal 1 Abstimmung pro Episode und Nutzer:in.
- Maximal 3 Chat-Nachrichten pro 5 Sekunden je Client-ID.
- Ungültige Tokens werden blockiert.
- Bei Überschreitung: HTTP 429 / UI-Toast „Bitte kurz warten“.

## Fehlerfälle

| Fall | UI-Reaktion |
|---|---|
| Kein Internet | Error State „Verbindung verloren“ mit Retry |
| Live-Fenster geschlossen | Voting deaktivieren, Hinweis anzeigen |
| Rate Limit erreicht | Toast + Eingabe kurz sperren |
| Backend nicht erreichbar | Mock-/Offline-Hinweis oder Retry |
| Keine Daten | Empty State anzeigen |

## Supabase-Hinweise

- RLS für alle nutzerbezogenen Tabellen aktivieren.
- Schreibzugriffe nur mit gültigem JWT.
- Aggregationen möglichst serverseitig oder materialisiert lösen.
- Realtime-Streams sparsam abonnieren und bei Screen-Wechsel sauber schließen.
