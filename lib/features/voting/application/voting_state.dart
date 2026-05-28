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

/// Demo vote totals (session-local; your vote shifts counts once).
class VotingState {
  const VotingState({
    required this.counts,
    required this.selected,
    required this.userHasVoted,
  });

  final Map<VoteRating, int> counts;
  final VoteRating? selected;
  final bool userHasVoted;

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
  }) {
    return VotingState(
      counts: counts ?? this.counts,
      selected: clearSelected ? null : (selected ?? this.selected),
      userHasVoted: userHasVoted ?? this.userHasVoted,
    );
  }
}

final votingProvider = NotifierProvider<VotingNotifier, VotingState>(
  VotingNotifier.new,
);

class VotingNotifier extends Notifier<VotingState> {
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
}
