import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tatort_liebe_flutter/app/tatort_liebe_app.dart';
import 'package:tatort_liebe_flutter/core/persistence/shared_preferences_provider.dart';

void main() {
  testWidgets('Tatort Liebe app renders onboarding foundation', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance(),
          ),
        ],
        child: const TatortLiebeApp(),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 900));

    expect(find.text('Fall wird vorbereitet …'), findsNothing);
    expect(find.text('Los geht’s'), findsOneWidget);
  });
}
