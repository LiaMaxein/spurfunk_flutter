import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spurfunk_flutter/core/persistence/shared_preferences_provider.dart';
import 'package:spurfunk_flutter/core/router/app_routes.dart';
import 'package:spurfunk_flutter/features/onboarding/presentation/onboarding_screen.dart';
import 'package:spurfunk_flutter/features/profile/presentation/profile_screen.dart';
import 'package:spurfunk_flutter/features/settings/application/settings_models.dart';
import 'package:spurfunk_flutter/features/settings/application/settings_state.dart';
import 'package:spurfunk_flutter/features/settings/presentation/accessibility_settings_screen.dart';
import 'package:spurfunk_flutter/features/settings/presentation/design_settings_screen.dart';
import 'package:spurfunk_flutter/features/settings/presentation/notifications_settings_screen.dart';
import 'package:spurfunk_flutter/features/settings/presentation/settings_screen.dart';

void main() {
  group('Settings state', () {
    test('notification preferences default to master enabled', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(container.dispose);

      final map = container.read(notificationPreferencesProvider);
      expect(map[NotificationPreference.liveStart.key], isTrue);
      expect(container.read(notificationsEnabledProvider), isTrue);
    });

    test('theme mode persists', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
      );
      addTearDown(container.dispose);

      await container
          .read(themeModeSettingProvider.notifier)
          .setValue(AppThemeMode.system);
      expect(prefs.getString('theme_mode'), 'system');
      expect(container.read(themeModeSettingProvider), AppThemeMode.system);
    });
  });

  group('Settings UI', () {
    Future<void> pumpSettings(
      WidgetTester tester, {
      required Widget home,
      List<GoRoute> extraRoutes = const [],
    }) async {
      SharedPreferences.setMockInitialValues({'onboarding_completed': true});
      final prefs = await SharedPreferences.getInstance();
      await tester.binding.setSurfaceSize(const Size(430, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final router = GoRouter(
        routes: [
          GoRoute(path: '/', builder: (context, state) => home),
          ...extraRoutes,
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
    }

    testWidgets('hub shows navigation rows and logout', (tester) async {
      await pumpSettings(tester, home: const SettingsScreen());

      expect(find.text('EINSTELLUNGEN'), findsOneWidget);
      expect(find.text('Benachrichtigungen'), findsOneWidget);
      expect(find.text('App-Design'), findsOneWidget);
      expect(find.text('Profil & Identität'), findsOneWidget);
      expect(find.text('Abmelden'), findsOneWidget);
    });

    testWidgets('navigates to notifications screen', (tester) async {
      await pumpSettings(
        tester,
        home: const SettingsScreen(),
        extraRoutes: [
          GoRoute(
            path: AppRoutes.profileSettingsNotificationsPath,
            builder: (context, state) => const NotificationsSettingsScreen(),
          ),
        ],
      );

      await tester.tap(find.text('Benachrichtigungen'));
      await tester.pumpAndSettle();

      expect(find.text('BENACHRICHTIGUNGEN'), findsOneWidget);
      expect(find.text('Live-Beginn'), findsOneWidget);
    });

    testWidgets('navigates to design screen', (tester) async {
      await pumpSettings(
        tester,
        home: const SettingsScreen(),
        extraRoutes: [
          GoRoute(
            path: AppRoutes.profileSettingsDesignPath,
            builder: (context, state) => const DesignSettingsScreen(),
          ),
        ],
      );

      await tester.tap(find.text('App-Design'));
      await tester.pumpAndSettle();

      expect(find.text('APP-DESIGN'), findsOneWidget);
      expect(find.text('Hell'), findsOneWidget);
      expect(find.text('Dunkel'), findsOneWidget);
    });

    testWidgets('navigates to accessibility screen', (tester) async {
      await pumpSettings(
        tester,
        home: const SettingsScreen(),
        extraRoutes: [
          GoRoute(
            path: AppRoutes.profileSettingsAccessibilityPath,
            builder: (context, state) =>
                const AccessibilitySettingsScreen(),
          ),
        ],
      );

      await tester.tap(find.text('Barrierefreiheit'));
      await tester.pumpAndSettle();

      expect(find.text('BARRIEREFREIHEIT'), findsOneWidget);
      expect(find.text('Größere Schrift'), findsOneWidget);
    });

    testWidgets('profile settings opens from hub route', (tester) async {
      await pumpSettings(
        tester,
        home: const ProfileScreen(),
        extraRoutes: [
          GoRoute(
            path: AppRoutes.profileSettingsPath,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      );

      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();

      expect(find.text('EINSTELLUNGEN'), findsOneWidget);
    });
  });

  group('Onboarding gender step', () {
    testWidgets('requires gender before continuing', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await tester.binding.setSurfaceSize(const Size(430, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(home: OnboardingScreen()),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.text('Los geht’s'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      await tester.tap(find.text('Weiter'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Wie möchtest du angegeben werden?'), findsOneWidget);

      await tester.tap(find.text('Divers'));
      await tester.pump();

      await tester.tap(find.text('Weiter'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Wie sollen wir dich nennen?'), findsOneWidget);
      expect(prefs.getString('gender'), 'diverse');
    });
  });
}
