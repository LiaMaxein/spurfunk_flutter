import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';

enum VoteRating {
  schlecht,
  nichtGut,
  okay,
  gut,
  mega,
}

enum VotingRegion { gesamt, nord, sued, ost, west }

enum VotingAgeGroup { alle, u25, a25bis39, a40bis59, a60plus }

enum VotingGender { alle, weiblich, maennlich, divers }

extension VoteRatingX on VoteRating {
  String get emoji => switch (this) {
    VoteRating.schlecht => '😡',
    VoteRating.nichtGut => '🙁',
    VoteRating.okay => '🙂',
    VoteRating.gut => '😊',
    VoteRating.mega => '😍',
  };

  String get label => switch (this) {
    VoteRating.schlecht => 'Schlecht',
    VoteRating.nichtGut => 'Nicht gut',
    VoteRating.okay => 'Okay',
    VoteRating.gut => 'Gut',
    VoteRating.mega => 'Mega',
  };

  Color get color => switch (this) {
    VoteRating.schlecht => AppColors.red,
    VoteRating.nichtGut => AppColors.orange,
    VoteRating.okay => AppColors.yellow,
    VoteRating.gut => AppColors.green,
    VoteRating.mega => AppColors.greenSoft,
  };
}

extension VotingRegionX on VotingRegion {
  String get label => switch (this) {
    VotingRegion.gesamt => 'Gesamt',
    VotingRegion.nord => 'Nord',
    VotingRegion.sued => 'Süd',
    VotingRegion.ost => 'Ost',
    VotingRegion.west => 'West',
  };
}

extension VotingAgeGroupX on VotingAgeGroup {
  String get label => switch (this) {
    VotingAgeGroup.alle => 'Alle',
    VotingAgeGroup.u25 => 'U25',
    VotingAgeGroup.a25bis39 => '25–39',
    VotingAgeGroup.a40bis59 => '40–59',
    VotingAgeGroup.a60plus => '60+',
  };
}

extension VotingGenderX on VotingGender {
  String get label => switch (this) {
    VotingGender.alle => 'Alle',
    VotingGender.weiblich => 'Weiblich',
    VotingGender.maennlich => 'Männlich',
    VotingGender.divers => 'Divers',
  };
}

/// Demo vote totals (session-local; your vote shifts counts once).
class VotingState {
  const VotingState({
    required this.counts,
    required this.selected,
    required this.userHasVoted,
    required this.region,
    required this.ageGroup,
    required this.gender,
  });

  final Map<VoteRating, int> counts;
  final VoteRating? selected;
  final bool userHasVoted;
  final VotingRegion region;
  final VotingAgeGroup ageGroup;
  final VotingGender gender;

  static const _baseCounts = {
    VoteRating.mega: 5232,
    VoteRating.gut: 3488,
    VoteRating.okay: 2118,
    VoteRating.nichtGut: 996,
    VoteRating.schlecht: 624,
  };

  factory VotingState.initial() => VotingState(
    counts: Map<VoteRating, int>.from(_baseCounts),
    selected: null,
    userHasVoted: false,
    region: VotingRegion.gesamt,
    ageGroup: VotingAgeGroup.alle,
    gender: VotingGender.alle,
  );

  int get totalVotes => counts.values.fold(0, (sum, count) => sum + count);

  List<double> get shareValues {
    final total = totalVotes;
    if (total == 0) return List.filled(VoteRating.values.length, 0);
    return VoteRating.values
        .map((rating) => (counts[rating] ?? 0) / total)
        .toList();
  }

  List<Color> get shareColors =>
      VoteRating.values.map((rating) => rating.color).toList();

  String percentLabel(VoteRating rating) {
    final total = totalVotes;
    if (total == 0) return '0%';
    final share = (counts[rating] ?? 0) / total;
    return '${(share * 100).round()}%';
  }

  VotingState copyWith({
    Map<VoteRating, int>? counts,
    VoteRating? selected,
    bool clearSelected = false,
    bool? userHasVoted,
    VotingRegion? region,
    VotingAgeGroup? ageGroup,
    VotingGender? gender,
  }) {
    return VotingState(
      counts: counts ?? this.counts,
      selected: clearSelected ? null : (selected ?? this.selected),
      userHasVoted: userHasVoted ?? this.userHasVoted,
      region: region ?? this.region,
      ageGroup: ageGroup ?? this.ageGroup,
      gender: gender ?? this.gender,
    );
  }
}

final votingProvider = NotifierProvider<VotingNotifier, VotingState>(
  VotingNotifier.new,
);

class VotingNotifier extends Notifier<VotingState> {
  static const _regionMultiplier = {
    VotingRegion.gesamt: 1.0,
    VotingRegion.nord: 1.06,
    VotingRegion.sued: 0.94,
    VotingRegion.ost: 0.9,
    VotingRegion.west: 1.03,
  };

  static const _ageMultiplier = {
    VotingAgeGroup.alle: 1.0,
    VotingAgeGroup.u25: 1.08,
    VotingAgeGroup.a25bis39: 1.04,
    VotingAgeGroup.a40bis59: 0.98,
    VotingAgeGroup.a60plus: 0.92,
  };

  static const _genderMultiplier = {
    VotingGender.alle: 1.0,
    VotingGender.weiblich: 1.04,
    VotingGender.maennlich: 0.97,
    VotingGender.divers: 0.95,
  };

  static const _ratingBias = {
    VoteRating.mega: 1.02,
    VoteRating.gut: 1.0,
    VoteRating.okay: 0.98,
    VoteRating.nichtGut: 1.01,
    VoteRating.schlecht: 1.04,
  };

  @override
  VotingState build() => VotingState.initial();

  void selectVote(VoteRating rating) {
    final current = state;
    final counts = Map<VoteRating, int>.from(current.counts);

    if (current.userHasVoted && current.selected != null) {
      counts[current.selected!] = (counts[current.selected!] ?? 1) - 1;
    }

    counts[rating] = (counts[rating] ?? 0) + 1;

    state = current.copyWith(
      counts: counts,
      selected: rating,
      userHasVoted: true,
    );
  }

  void setRegion(VotingRegion region) {
    state = _recalculate(state.copyWith(region: region));
  }

  void setAgeGroup(VotingAgeGroup ageGroup) {
    state = _recalculate(state.copyWith(ageGroup: ageGroup));
  }

  void setGender(VotingGender gender) {
    state = _recalculate(state.copyWith(gender: gender));
  }

  VotingState _recalculate(VotingState current) {
    final regionFactor = _regionMultiplier[current.region]!;
    final ageFactor = _ageMultiplier[current.ageGroup]!;
    final genderFactor = _genderMultiplier[current.gender]!;

    final recalculated = <VoteRating, int>{};
    for (final rating in VoteRating.values) {
      final base = VotingState._baseCounts[rating]!;
      final biased = base * _ratingBias[rating]!;
      final value = (biased * regionFactor * ageFactor * genderFactor).round();
      recalculated[rating] = value.clamp(50, 50000);
    }

    if (current.userHasVoted && current.selected != null) {
      recalculated[current.selected!] = (recalculated[current.selected!] ?? 0) + 1;
    }

    return current.copyWith(counts: recalculated);
  }
}
