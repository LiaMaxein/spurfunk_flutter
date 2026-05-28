import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/community/presentation/community_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/live_episode/presentation/live_episode_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/statistics/presentation/statistics_screen.dart';
import '../../features/voting/presentation/voting_screen.dart';
import '../layout/app_shell.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home.path,
    routes: [
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
