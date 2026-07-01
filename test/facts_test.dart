import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spurfunk_flutter/core/persistence/shared_preferences_provider.dart';
import 'package:spurfunk_flutter/features/facts/data/facts_mock_data.dart';
import 'package:spurfunk_flutter/features/facts/presentation/widgets/facts_city_map.dart';
import 'package:spurfunk_flutter/features/facts/presentation/widgets/facts_main_tab_bar.dart';
import 'package:spurfunk_flutter/features/live_episode/data/live_case_mock_data.dart';
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
      expect(factsInvestigatorTeams.length, 19);
      for (final team in factsInvestigatorTeams) {
        expect(
          investigatorById(team.leadInvestigatorId).id,
          team.leadInvestigatorId,
        );
        expect(team.members, isNotEmpty);
      }

      final kiel = teamById('team_kiel')!;
      expect(kiel.members.length, 3);
      expect(kiel.members.map((m) => m.name), isNot(contains('Frank Thiel')));

      final muenster = teamById('team_muenster')!;
      expect(muenster.members.length, 2);
      expect(muenster.sinceYear, 2002);
      expect(muenster.members[0].role, 'Kriminalhauptkommissar');
      expect(muenster.members[0].name, 'Frank Thiel');
      expect(muenster.members[1].role, 'Pathologe');
      expect(muenster.members[1].name, contains('Boerne'));

      final hamburg = teamById('team_hamburg')!;
      expect(hamburg.members[0].name, 'Thorsten Falke');

      final wien = teamById('team_wien')!;
      expect(wien.members[0].name, 'Moritz Eisner');
      expect(wien.members[1].name, 'Bibi Fellner');
    });

    test('cities include coordinates for map', () {
      expect(factsTatortCities.length, 22);

      final saarbruecken = teamById('team_saarbruecken')!;
      expect(saarbruecken.members.length, 4);
      expect(saarbruecken.members[0].name, 'Adam Schürk');
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

    test('Boerne is a clickable team member with profile data', () {
      final team = teamById('team_muenster')!;
      final boerne = team.members.last;
      expect(boerne.investigatorId, 'karl_friedrich_boerne');
      expect(
        investigatorById(boerne.investigatorId).name,
        contains('Boerne'),
      );
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
      expect(find.text('Kriminalhauptkommissar'), findsOneWidget);
      expect(find.text('Frank Thiel'), findsOneWidget);
      expect(find.text('Pathologe'), findsOneWidget);
      expect(find.text('Prof. Karl-Friedrich Boerne'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsNWidgets(2));
    });

    testWidgets('city map shows active and former legend', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FactsCityMap(cities: factsTatortCities),
          ),
        ),
      );

      expect(find.text('Aktive Teams'), findsOneWidget);
      expect(find.text('Ehemalige Teams'), findsOneWidget);
    });
  });
}
