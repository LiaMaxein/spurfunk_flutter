import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/community/presentation/community_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/live_episode/presentation/live_episode_screen.dart';
import '../../features/onboarding/application/onboarding_state.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/statistics/presentation/statistics_screen.dart';
import '../../features/voting/presentation/voting_screen.dart';
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
            path: AppRoutes.liveEpisode.path,
            builder: (context, state) => const LiveEpisodeScreen(),
          ),
          GoRoute(
            path: AppRoutes.voting.path,
            builder: (context, state) => const VotingScreen(),
          ),
          GoRoute(
            path: AppRoutes.community.path,
            builder: (context, state) => const CommunityScreen(),
          ),
          GoRoute(
            path: AppRoutes.statistics.path,
            builder: (context, state) => const StatisticsScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile.path,
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings.path,
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});
