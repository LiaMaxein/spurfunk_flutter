import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spurfunk_flutter/core/persistence/shared_preferences_provider.dart';
import 'package:spurfunk_flutter/features/onboarding/presentation/widgets/onboarding_widgets.dart';
import 'package:spurfunk_flutter/features/settings/presentation/profile_settings_screen.dart';
import 'package:spurfunk_flutter/shared/mock_data/mock_data.dart';

void main() {
  group('AvatarCaseCard', () {
    final laborfund = roleAvatarPresets.firstWhere((a) => a.id == 'beweisbeutel');

    Future<void> pumpCard(
      WidgetTester tester, {
      required VoidCallback onTap,
    }) async {
      await tester.binding.setSurfaceSize(const Size(430, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 130,
                child: AvatarCaseCard(
                  avatar: laborfund,
                  selected: false,
                  onTap: onTap,
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('info tap opens detail sheet with full description', (
      tester,
    ) async {
      var cardTapped = false;
      await pumpCard(tester, onTap: () => cardTapped = true);

      expect(
        find.textContaining('Spurensicherung und kriminaltechnische'),
        findsNothing,
      );

      await tester.tap(find.byTooltip('Mehr erfahren'));
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Spurensicherung und kriminaltechnische Untersuchungen.',
        ),
        findsOneWidget,
      );
      expect(find.text('Schließen'), findsOneWidget);
      expect(cardTapped, isFalse);
    });

    testWidgets('card tap selects avatar without opening detail sheet', (
      tester,
    ) async {
      var cardTapped = false;
      await pumpCard(tester, onTap: () => cardTapped = true);

      await tester.tap(find.text('Der Laborfund'));
      await tester.pump();

      expect(cardTapped, isTrue);
      expect(find.text('Schließen'), findsNothing);
    });

    testWidgets('selected state keeps stable card size without overflow', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(430, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      Widget card({required bool selected}) {
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 130,
                height: 160,
                child: AvatarCaseCard(
                  avatar: laborfund,
                  selected: selected,
                  onTap: () {},
                ),
              ),
            ),
          ),
        );
      }

      await tester.pumpWidget(card(selected: false));
      await tester.pumpAndSettle();
      final unselectedSize = tester.getSize(find.byType(AvatarCaseCard));

      await tester.pumpWidget(card(selected: true));
      await tester.pumpAndSettle();
      final selectedSize = tester.getSize(find.byType(AvatarCaseCard));

      expect(tester.takeException(), isNull);
      expect(selectedSize.width, unselectedSize.width);
      expect(selectedSize.height, unselectedSize.height);
    });
  });

  group('ProfileSettingsScreen', () {
    testWidgets('shows selected avatar description', (tester) async {
      SharedPreferences.setMockInitialValues({
        'onboarding_completed': true,
        'avatar_id': 'beweisbeutel',
      });
      final prefs = await SharedPreferences.getInstance();
      await tester.binding.setSurfaceSize(const Size(430, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: ProfileSettingsScreen(),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      expect(find.text('Der Laborfund'), findsOneWidget);
      expect(
        find.text(
          'Spurensicherung und kriminaltechnische Untersuchungen.',
        ),
        findsOneWidget,
      );
    });
  });
}
