import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spurfunk_flutter/core/persistence/shared_preferences_provider.dart';
import 'package:spurfunk_flutter/features/facts/data/facts_mock_data.dart';
import 'package:spurfunk_flutter/features/facts/presentation/widgets/facts_main_tab_bar.dart';
import 'package:spurfunk_flutter/features/live_episode/presentation/team_detail_screen.dart';

void main() {
  group('Facts mock data', () {
    test('carousel has items with assets', () {
      expect(factsFunFactCarousel, isNotEmpty);
      for (final item in factsFunFactCarousel) {
        expect(item.imageAssetPath, isNotEmpty);
        expect(item.title, isNotEmpty);
        expect(item.body, isNotEmpty);
      }
    });

    test('investigator teams use known lead ids and list members', () {
      expect(factsInvestigatorTeams.length, 8);
      const knownIds = {
        'klaus_borowski',
        'mila_sahin',
        'frank_thiel',
        'sarah_brandt',
      };
      for (final team in factsInvestigatorTeams) {
        expect(knownIds, contains(team.leadInvestigatorId));
        expect(team.members, isNotEmpty);
      }

      final muenster = teamById('team_muenster')!;
      expect(muenster.members.length, 2);
      expect(muenster.members[0].role, 'Kommissar');
      expect(muenster.members[0].name, 'Frank Thiel');
      expect(muenster.members[1].role, 'Pathologe');
      expect(muenster.members[1].name, contains('Boerne'));
    });

    test('cities include coordinates for map', () {
      expect(factsTatortCities.length, 13);
      for (final city in factsTatortCities) {
        expect(city.latitude, isNotNull);
        expect(city.longitude, isNotNull);
        expect(city.name, isNotEmpty);
      }
    });

    test('timeline and behind the scenes are defined', () {
      expect(factsTimelineMilestones, isNotEmpty);
      expect(factsBehindTheScenes.title, isNotEmpty);
      expect(factsBehindTheScenes.imageAssetPath, isNotEmpty);
    });
  });

  group('Facts UI', () {
    testWidgets('shows all main tab labels', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FactsMainTabBar(
              selectedIndex: 0,
              onChanged: (_) {},
            ),
          ),
        ),
      );

      for (final label in FactsMainTabBar.labels) {
        expect(find.text(label.toUpperCase()), findsOneWidget);
      }
    });

    testWidgets('team detail lists main figures vertically', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: TeamDetailScreen(teamId: 'team_muenster'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('HAUPTFIGUREN'), findsOneWidget);
      expect(find.text('Kommissar'), findsOneWidget);
      expect(find.text('Frank Thiel'), findsOneWidget);
      expect(find.text('Pathologe'), findsOneWidget);
      expect(find.text('Prof. Karl-Friedrich Boerne'), findsOneWidget);
    });
  });
}
