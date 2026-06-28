import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spurfunk_flutter/app/spurfunk_app.dart';
import 'package:spurfunk_flutter/core/persistence/shared_preferences_provider.dart';
import 'package:spurfunk_flutter/shared/models/models.dart';

void main() {
  test('VoteAggregate calculates fractions correctly', () {
    const aggregate = VoteAggregate(
      episodeId: 'test',
      schlecht: 10,
      langweilig: 10,
      okay: 20,
      gut: 40,
      mega: 20,
    );

    expect(aggregate.total, 100);
    expect(aggregate.fractionFor(VoteValue.gut), 0.4);
    expect(aggregate.countFor(VoteValue.mega), 20);
  });

  testWidgets('Spurfunk app renders onboarding', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ],
        child: const SpurfunkApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Los geht’s'), findsOneWidget);
  });
}
