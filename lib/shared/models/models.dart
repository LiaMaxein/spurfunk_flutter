enum VoteValue { schlecht, langweilig, okay, gut, mega }

class UserProfile {
  const UserProfile({
    required this.id,
    this.alias,
    required this.avatarId,
    required this.isAnonymous,
    required this.region,
    required this.ageCohort,
    this.gender,
    this.xp = 0,
    this.level = 1,
    required this.createdAt,
  });

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

  String get displayName =>
      isAnonymous || alias == null || alias!.isEmpty ? 'Mitwisser' : alias!;
}

class Episode {
  const Episode({
    required this.id,
    required this.title,
    required this.sender,
    required this.startsAt,
    required this.endsAt,
    required this.description,
    required this.location,
    this.investigatorIds = const [],
    this.imageAssetPath,
  });

  final String id;
  final String title;
  final String sender;
  final DateTime startsAt;
  final DateTime endsAt;
  final String description;
  final String location;
  final List<String> investigatorIds;
  final String? imageAssetPath;

  bool isLiveAt(DateTime now) => !now.isBefore(startsAt) && now.isBefore(endsAt);

  Duration get votingWindowEndAfterBroadcast => const Duration(minutes: 30);

  bool isVotingOpenAt(DateTime now) {
    if (isLiveAt(now)) return true;
    final end = endsAt.add(votingWindowEndAfterBroadcast);
    return now.isBefore(end) && !now.isBefore(endsAt);
  }
}

class VoteAggregate {
  const VoteAggregate({
    required this.episodeId,
    this.schlecht = 0,
    this.langweilig = 0,
    this.okay = 0,
    this.gut = 0,
    this.mega = 0,
  });

  final String episodeId;
  final int schlecht;
  final int langweilig;
  final int okay;
  final int gut;
  final int mega;

  int get total => schlecht + langweilig + okay + gut + mega;

  int countFor(VoteValue value) => switch (value) {
    VoteValue.schlecht => schlecht,
    VoteValue.langweilig => langweilig,
    VoteValue.okay => okay,
    VoteValue.gut => gut,
    VoteValue.mega => mega,
  };

  double fractionFor(VoteValue value) =>
      total == 0 ? 0 : countFor(value) / total;
}

class VoteFilter {
  const VoteFilter({this.region, this.ageCohort, this.gender});

  final String? region;
  final String? ageCohort;
  final String? gender;
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.episodeId,
    required this.userId,
    required this.alias,
    required this.avatarId,
    required this.content,
    required this.createdAt,
  });

  final String id;
  final String episodeId;
  final String userId;
  final String alias;
  final String avatarId;
  final String content;
  final DateTime createdAt;
}

class EmojiReaction {
  const EmojiReaction({
    required this.id,
    required this.episodeId,
    required this.userId,
    required this.emoji,
    required this.createdAt,
  });

  final String id;
  final String episodeId;
  final String userId;
  final String emoji;
  final DateTime createdAt;
}

class NewsItem {
  const NewsItem({
    required this.id,
    required this.title,
    required this.teaser,
    required this.body,
    required this.category,
    required this.publishedAt,
  });

  final String id;
  final String title;
  final String teaser;
  final String body;
  final String category;
  final DateTime publishedAt;
}

class PastEpisodeStats {
  const PastEpisodeStats({
    required this.episode,
    required this.aggregate,
    required this.averageLabel,
  });

  final Episode episode;
  final VoteAggregate aggregate;
  final String averageLabel;
}

class PopularTeam {
  const PopularTeam({
    required this.rank,
    required this.name,
    required this.imageAssetPath,
    required this.favoriteCount,
    required this.teamId,
  });

  final int rank;
  final String name;
  final String imageAssetPath;
  final int favoriteCount;
  final String teamId;
}

class PopularEpisode {
  const PopularEpisode({
    required this.id,
    required this.title,
    required this.airedAt,
    required this.rating,
    this.thumbnailAssetPath,
  });

  final String id;
  final String title;
  final DateTime airedAt;
  final double rating;
  final String? thumbnailAssetPath;
}

class Investigator {
  const Investigator({
    required this.id,
    required this.name,
    required this.role,
    required this.bio,
    required this.portraitAssetPath,
    required this.teamMemberCount,
    required this.episodeCount,
    required this.averageRating,
    this.teamName,
    this.isFavorite = false,
    this.popularEpisodes = const [],
  });

  final String id;
  final String name;
  final String role;
  final String bio;
  final String portraitAssetPath;
  final int teamMemberCount;
  final int episodeCount;
  final double averageRating;
  final String? teamName;
  final bool isFavorite;
  final List<PopularEpisode> popularEpisodes;

  Investigator copyWith({bool? isFavorite}) {
    return Investigator(
      id: id,
      name: name,
      role: role,
      bio: bio,
      portraitAssetPath: portraitAssetPath,
      teamMemberCount: teamMemberCount,
      episodeCount: episodeCount,
      averageRating: averageRating,
      teamName: teamName,
      isFavorite: isFavorite ?? this.isFavorite,
      popularEpisodes: popularEpisodes,
    );
  }
}
