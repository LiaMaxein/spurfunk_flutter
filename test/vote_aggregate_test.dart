import 'package:flutter_test/flutter_test.dart';
import 'package:spurfunk_flutter/shared/mock_data/mock_data.dart';
import 'package:spurfunk_flutter/shared/models/models.dart';

void main() {
  test('mock aggregate respects filter scaling', () {
    final all = mockAggregateFor('ep-1');
    final filtered = mockAggregateFor(
      'ep-1',
      filter: const VoteFilter(region: 'Österreich'),
    );

    expect(all.total, greaterThan(0));
    expect(filtered.total, greaterThan(0));
    expect(filtered.total, isNot(equals(all.total)));
  });
}
