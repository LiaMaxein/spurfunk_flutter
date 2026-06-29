import 'package:flutter_test/flutter_test.dart';
import 'package:spurfunk_flutter/features/community/application/community_stats_notifier.dart';
import 'package:spurfunk_flutter/shared/mock_data/mock_data.dart';

void main() {
  test('averageLabelForAggregate returns dominant vote label', () {
    final aggregate = mockAggregateFor('ep-past-1');
    expect(averageLabelForAggregate(aggregate), isNotEmpty);
  });

  test('mock past episodes include image assets', () {
    expect(mockPastEpisodes.length, greaterThanOrEqualTo(3));
    for (final episode in mockPastEpisodes) {
      expect(episode.imageAssetPath, isNotNull);
    }
  });

  test('community filter options are defined', () {
    expect(CommunityStatsState.regions, isNotEmpty);
    expect(CommunityStatsState.ageCohorts, isNotEmpty);
    expect(CommunityStatsState.genders, isNotEmpty);
  });
}
