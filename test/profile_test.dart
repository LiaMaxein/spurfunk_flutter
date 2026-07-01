import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spurfunk_flutter/core/persistence/shared_preferences_provider.dart';
import 'package:spurfunk_flutter/core/router/app_routes.dart';
import 'package:spurfunk_flutter/features/profile/data/profile_mock_data.dart';
import 'package:spurfunk_flutter/features/profile/data/profile_models.dart';
import 'package:spurfunk_flutter/features/profile/presentation/profile_screen.dart';
import 'package:spurfunk_flutter/features/profile/presentation/profile_subscreens.dart';

void main() {
  group('Profile mock data', () {
    test('uses mockup quick stats values', () {
      expect(profileQuickStats.posts, 1248);
      expect(profileQuickStats.liveChats, 87);
      expect(profileQuickStats.quizzes, 156);
      expect(profileQuickStats.activeDays, 32);
      expect(profileTotalXp, 12450);
    });

    test('badges include unlocked and locked', () {
      expect(profileUnlockedBadges.length, 8);
      expect(profileLockedBadges.length, 5);
      expect(badgesForFilter(ProfileBadgeFilter.all).length, 13);
    });

    test('today activities sum to expected xp', () {
      final total = profileTodayActivities.fold<int>(
        0,
        (sum, event) => sum + event.xpDelta,
      );
      expect(total, profileTodayXpTotal);
    });
  });

  group('Profile UI', () {
    testWidgets('hub shows profil sections from mockup', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await tester.binding.setSurfaceSize(const Size(430, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: MaterialApp(
            home: const ProfileScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('MEINE AKTE'), findsOneWidget);
      expect(find.text('LIEBLINGS-ERMITTLER'), findsOneWidget);
      expect(find.text('STATISTIKEN'), findsOneWidget);
      expect(find.text('BADGE-SAMMLUNG'), findsOneWidget);
      expect(find.textContaining('Gesammelte Punkte'), findsOneWidget);
      expect(find.text('Mitwisser der Extraklasse'), findsOneWidget);
      expect(find.text('Serientäter'), findsOneWidget);
      expect(find.text('Tatort-Experte'), findsOneWidget);
      expect(find.text('26 / 40 Badges'), findsOneWidget);
    });

    testWidgets('statistics teaser navigates to stats screen', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await tester.binding.setSurfaceSize(const Size(430, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: AppRoutes.profileStatsPath,
            builder: (context, state) => const ProfileStatsScreen(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('Gesammelte Punkte'));
      await tester.pumpAndSettle();

      expect(find.text('STATISTIKEN'), findsWidgets);
      expect(find.text('PUNKTEVERLAUF'), findsOneWidget);
      expect(find.text('DEINE AKTIVITÄT'), findsOneWidget);
    });

    testWidgets('inline badges show filter tabs on profile', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await tester.binding.setSurfaceSize(const Size(430, 1600));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: ProfileScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('ALLE'), findsOneWidget);
      expect(find.text('FREIGESCHALTET'), findsOneWidget);
      expect(find.text('GESPERRT'), findsOneWidget);
      expect(find.text('Spurensicherer'), findsOneWidget);
      expect(find.text('Marathon-Live'), findsOneWidget);
    });
  });
}
