class FunFactCarouselItem {
  const FunFactCarouselItem({
    required this.imageAssetPath,
    required this.title,
    required this.body,
  });

  final String imageAssetPath;
  final String title;
  final String body;
}

class TatortStatistic {
  const TatortStatistic({required this.label});

  final String label;
}

class TeamMemberSummary {
  const TeamMemberSummary({
    required this.name,
    required this.role,
    required this.portraitAssetPath,
    this.investigatorId,
  });

  final String name;
  final String role;
  final String portraitAssetPath;
  final String? investigatorId;
}

class InvestigatorTeamSummary {
  const InvestigatorTeamSummary({
    required this.id,
    required this.city,
    required this.teamLabel,
    required this.investigatorNames,
    required this.sinceYear,
    required this.thumbnailAssetPath,
    required this.leadInvestigatorId,
    required this.members,
    this.teamBio,
  });

  final String id;
  final String city;
  final String teamLabel;
  final String investigatorNames;
  final int sinceYear;
  final String thumbnailAssetPath;
  final String leadInvestigatorId;
  final List<TeamMemberSummary> members;
  final String? teamBio;
}

class TimelineMilestone {
  const TimelineMilestone({
    required this.period,
    required this.title,
    required this.description,
  });

  final String period;
  final String title;
  final String description;
}

class BehindTheScenesTeaser {
  const BehindTheScenesTeaser({
    required this.title,
    required this.body,
    required this.imageAssetPath,
  });

  final String title;
  final String body;
  final String imageAssetPath;
}

class TatortCity {
  const TatortCity({
    required this.id,
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.sinceYear,
    required this.episodeCount,
    required this.isActive,
    required this.imageAssetPath,
    this.teamName,
    this.teamId,
    this.leadInvestigatorId,
  });

  final String id;
  final String name;
  final String country;
  final double latitude;
  final double longitude;
  final int sinceYear;
  final int episodeCount;
  final bool isActive;
  final String imageAssetPath;
  final String? teamName;
  final String? teamId;
  final String? leadInvestigatorId;
}
