# 08 – Data Model

Dieses Datenmodell ist backend-ready, kann aber im Prototyp mit lokalen Mock-Daten abgebildet werden.

## Entity: UserProfile

```dart
class UserProfile {
  final String id;
  final String? alias;
  final String avatarId;
  final bool isAnonymous;
  final String region;
  final String ageCohort;
  final String? gender;
  final int xp;
  final int level;
  final DateTime createdAt;
}
```

## Entity: Avatar

```dart
class Avatar {
  final String id;
  final String name;
  final String description;
  final String assetPath;
}
```

## Avatar-Liste

Entspricht `assets/branding/avatar_*.svg` und `roleAvatarPresets` in `lib/shared/mock_data/mock_data.dart`:

| ID | Anzeigename |
|---|---|
| `laterne` | Der einsame Ermittler |
| `frau_profil` | Die Analytikerin |
| `fingerabdruck` | Der Fingerabdruck |
| `detektiv_hut` | Der verdeckte Ermittler |
| `lupe` | Die Spurensicherung |
| `mann_profil` | Der Beobachter |
| `aktenordner` | Die Ermittlungsakte |
| `fussabdruecke` | Die Fußspuren |
| `frau_ruecken` | Die Zeugin |
| `pistole` | Die Dienstwaffe |
| `beweisbeutel` | Der Laborfund |
| `lampe` | Der Tatort |

## Entity: Episode

```dart
class Episode {
  final String id;
  final String title;
  final String sender;
  final DateTime startsAt;
  final DateTime endsAt;
  final String description;
  final String location;
  final List<String> investigatorTeamIds;
  final String? imageAssetPath;
}
```

## Entity: Vote

```dart
enum VoteValue { schlecht, langweilig, okay, gut, mega }

class Vote {
  final String id;
  final String episodeId;
  final String userId;
  final VoteValue value;
  final String region;
  final String ageCohort;
  final String? gender;
  final DateTime createdAt;
}
```

## Entity: VoteAggregate

```dart
class VoteAggregate {
  final String episodeId;
  final int schlecht;
  final int langweilig;
  final int okay;
  final int gut;
  final int mega;
  final int total;
}
```

## Entity: ChatMessage

```dart
class ChatMessage {
  final String id;
  final String episodeId;
  final String userId;
  final String alias;
  final String avatarId;
  final String content;
  final DateTime createdAt;
  final bool isModerated;
}
```

## Entity: EmojiReaction

```dart
class EmojiReaction {
  final String id;
  final String episodeId;
  final String userId;
  final String emoji;
  final DateTime createdAt;
}
```

## Entity: NewsItem

```dart
class NewsItem {
  final String id;
  final String title;
  final String teaser;
  final String body;
  final String category;
  final DateTime publishedAt;
  final String? imageAssetPath;
}
```

## Entity: InvestigatorTeam

```dart
class InvestigatorTeam {
  final String id;
  final String name;
  final String city;
  final List<String> investigatorNames;
  final int firstYear;
  final bool isActive;
  final String description;
  final double averageCommunityRating;
}
```

## Entity: FavoriteTeam

```dart
class FavoriteTeam {
  final String userId;
  final String teamId;
  final DateTime createdAt;
}
```

## Entity: QuizQuestion

```dart
class QuizQuestion {
  final String id;
  final String category;
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
  final String? explanation;
}
```

## Entity: QuizResult

```dart
class QuizResult {
  final String id;
  final String userId;
  final int correctAnswers;
  final int totalQuestions;
  final int xpEarned;
  final DateTime createdAt;
}
```

## Entity: MemoryGameResult

```dart
class MemoryGameResult {
  final String id;
  final String userId;
  final String difficulty;
  final int moves;
  final Duration duration;
  final int points;
  final DateTime createdAt;
}
```

## Entity: Badge

```dart
class Badge {
  final String id;
  final String name;
  final String description;
  final String iconAssetPath;
  final int requiredXp;
}
```

## Entity: UserBadge

```dart
class UserBadge {
  final String userId;
  final String badgeId;
  final DateTime unlockedAt;
}
```

## Supabase-Tabellenvorschlag

| Tabelle | Zweck |
|---|---|
| profiles | Alias, Avatar, Region, Alterskohorte, XP |
| avatars | verfügbare Avatar-Motive |
| episodes | Folgen und Sendezeiten |
| votes | Einzelstimmen |
| vote_aggregates | materialisierte Aggregation optional |
| chat_messages | Live-Chat |
| emoji_reactions | flüchtige Reaktionen |
| news_items | Polizeifunk |
| investigator_teams | Ermittlerdatenbank |
| favorite_teams | persönliche Favoriten |
| quiz_questions | Fragenpool |
| quiz_results | Quiz-Abschlüsse |
| memory_results | Memory-Abschlüsse |
| badges | Badge-Definitionen |
| user_badges | freigeschaltete Badges |

## Datenschutzregeln

- Keine Klarnamen erzwingen.
- Keine Echtfotos speichern.
- Keine exakten GPS-Daten speichern.
- Region nur grob speichern.
- IP-Adressen nicht dauerhaft unmaskiert speichern.
- Kleine Filtergruppen nicht deanonymisierend anzeigen.
