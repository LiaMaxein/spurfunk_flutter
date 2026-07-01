import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/community/presentation/community_screen.dart';
import '../../features/community/presentation/episode_stats_detail_screen.dart';
import '../../features/community/presentation/memory_play_screen.dart';
import '../../features/community/presentation/quiz_play_screen.dart';
import '../../features/community/data/memory_mock_data.dart';
import '../../shared/models/gamification_models.dart';
import '../../features/facts/presentation/facts_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/live_episode/presentation/investigator_detail_screen.dart';
import '../../features/live_episode/presentation/team_detail_screen.dart';
import '../../features/live_episode/presentation/live_episode_screen.dart';
import '../../features/onboarding/application/onboarding_state.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/profile/presentation/profile_subscreens.dart';
import '../../features/settings/presentation/about_app_screen.dart';
import '../../features/settings/presentation/accessibility_settings_screen.dart';
import '../../features/settings/presentation/design_settings_screen.dart';
import '../../features/settings/presentation/help_settings_screen.dart';
import '../../features/settings/presentation/notifications_settings_screen.dart';
import '../../features/settings/presentation/privacy_screen.dart';
import '../../features/settings/presentation/profile_settings_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../layout/app_shell.dart';
import 'app_routes.dart';
import 'router_refresh.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refresh = ref.watch(routerRefreshProvider);

  return GoRouter(
    initialLocation: AppRoutes.home.path,
    refreshListenable: refresh,
    redirect: (context, state) {
      final onboardingDone = ref.read(onboardingCompletedProvider);
      final location = state.matchedLocation;

      if (!onboardingDone && location != AppRoutes.onboardingPath) {
        return AppRoutes.onboardingPath;
      }

      if (onboardingDone && location == AppRoutes.onboardingPath) {
        return AppRoutes.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboardingPath,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const OnboardingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
              child: child,
            );
          },
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home.path,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.community.path,
            builder: (context, state) => const CommunityScreen(),
            routes: [
              GoRoute(
                path: 'stats/:episodeId',
                builder: (context, state) => EpisodeStatsDetailScreen(
                  episodeId: state.pathParameters['episodeId']!,
                ),
              ),
              GoRoute(
                path: 'quiz/play',
                builder: (context, state) {
                  final category = _quizCategoryFromName(
                    state.uri.queryParameters['category'],
                  );
                  final session = state.uri.queryParameters['session'] ?? '0';
                  return QuizPlayScreen(
                    key: ValueKey('quiz-$session-${category?.name ?? 'all'}'),
                    category: category,
                  );
                },
              ),
              GoRoute(
                path: 'memory/play',
                builder: (context, state) {
                  final id = state.uri.queryParameters['id'] ?? 'easy';
                  final session = state.uri.queryParameters['session'] ?? '0';
                  final difficulty = memoryDifficulties.firstWhere(
                    (item) => item.id == id,
                    orElse: () => memoryDifficulties.first,
                  );
                  return MemoryPlayScreen(
                    key: ValueKey('memory-$session-${difficulty.id}'),
                    difficulty: difficulty,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.liveEpisode.path,
            builder: (context, state) => const LiveEpisodeScreen(),
            routes: [
              GoRoute(
                path: 'team/:investigatorId',
                builder:
                    (context, state) => InvestigatorDetailScreen(
                      investigatorId: state.pathParameters['investigatorId']!,
                    ),
              ),
              GoRoute(
                path: 'team-detail/:teamId',
                builder: (context, state) => TeamDetailScreen(
                  teamId: state.pathParameters['teamId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.facts.path,
            builder: (context, state) => FactsScreen(
              initialTab: state.uri.queryParameters['tab'],
            ),
          ),
          GoRoute(
            path: AppRoutes.profile.path,
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'stats',
                builder: (context, state) => const ProfileStatsScreen(),
              ),
              GoRoute(
                path: 'activity',
                builder: (context, state) => const ProfileActivityScreen(),
              ),
              GoRoute(
                path: 'badges',
                builder: (context, state) => const ProfileBadgesScreen(),
              ),
              GoRoute(
                path: 'settings',
                builder: (context, state) => const SettingsScreen(),
                routes: [
                  GoRoute(
                    path: 'notifications',
                    builder: (context, state) =>
                        const NotificationsSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'design',
                    builder: (context, state) => const DesignSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'accessibility',
                    builder: (context, state) =>
                        const AccessibilitySettingsScreen(),
                  ),
                  GoRoute(
                    path: 'help',
                    builder: (context, state) => const HelpSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'profile',
                    builder: (context, state) => const ProfileSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'about',
                    builder: (context, state) => const AboutAppScreen(),
                  ),
                  GoRoute(
                    path: 'privacy',
                    builder: (context, state) => const PrivacyScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

QuizCategory? _quizCategoryFromName(String? name) {
  if (name == null || name.isEmpty) return null;
  for (final category in QuizCategory.values) {
    if (category.name == name) return category;
  }
  return null;
}
