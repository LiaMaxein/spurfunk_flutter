import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/app_shell.dart';
import '../../../core/widgets/app_components.dart';
import '../../../shared/models/models.dart';
import '../application/community_stats_notifier.dart';
import '../../home/application/home_notifier.dart';
import 'widgets/community_hero_header.dart';
import 'widgets/community_memory_tab.dart';
import 'widgets/community_quiz_tab.dart';
import 'widgets/community_stats_filters.dart';
import 'widgets/community_sub_tab_bar.dart';
import 'widgets/episode_stats_card.dart';
import 'widgets/top_teams_section.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  int _tab = 0;
  bool _filtersExpanded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tabParam = GoRouterState.of(context).uri.queryParameters['tab'];
    final nextTab = switch (tabParam) {
      'quiz' => 1,
      'memory' => 2,
      'leaderboard' || 'rangliste' => 3,
      'stats' || null || '' => 0,
      _ => _tab,
    };
    if (nextTab != _tab) {
      setState(() => _tab = nextTab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CommunityHeroHeader(),
          const SizedBox(height: 18),
          CommunitySubTabBar(
            selectedIndex: _tab,
            onChanged: (index) => setState(() => _tab = index),
          ),
          const SizedBox(height: 16),
          if (_tab == 0)
            _StatsTab(
              filtersExpanded: _filtersExpanded,
              onFilterToggle: () {
                setState(() => _filtersExpanded = !_filtersExpanded);
              },
            )
          else if (_tab == 1)
            const CommunityQuizTab()
          else if (_tab == 2)
            const CommunityMemoryTab()
          else
            _ComingSoonTab(tab: _tab),
        ],
      ),
    );
  }
}

class _StatsTab extends ConsumerWidget {
  const _StatsTab({
    required this.filtersExpanded,
    required this.onFilterToggle,
  });

  final bool filtersExpanded;
  final VoidCallback onFilterToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(communityStatsProvider);
    final home = ref.watch(homeNotifierProvider).value;

    if (stats.isLoading) {
      return const LoadingSkeleton(height: 240);
    }

    if (stats.episodes.isEmpty) {
      return const EmptyState(
        title: 'Keine Abstimmungen',
        subtitle: 'Sobald Folgen bewertet wurden, erscheinen sie hier.',
        icon: Icons.bar_chart_outlined,
      );
    }

    final featured = stats.episodes.first;
    final others = stats.episodes.skip(1).toList();
    final showLiveBadge = _isFeaturedEpisodeLive(featured, home);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommunityLiveVotingHeader(
          filtersExpanded: filtersExpanded,
          onFilterToggle: onFilterToggle,
        ),
        const SizedBox(height: 10),
        EpisodeStatsCard(
          item: featured,
          featured: true,
          showLiveBadge: showLiveBadge,
          showThumbnail: false,
          onTap: () => openEpisodeStatsDetail(context, featured.episode.id),
        ),
        if (others.isNotEmpty) ...[
          const SizedBox(height: 20),
          const CommunitySectionHeading(title: 'FRÜHERE ABSTIMMUNGEN'),
          const SizedBox(height: 10),
          for (final item in others) ...[
            EpisodeStatsCard(
              item: item,
              onTap: () => openEpisodeStatsDetail(context, item.episode.id),
            ),
            const SizedBox(height: 12),
          ],
        ],
        const SizedBox(height: 20),
        const CommunitySectionHeading(title: 'TOP 3 BELIEBTESTE TEAMS'),
        const SizedBox(height: 10),
        const TopTeamsCard(),
      ],
    );
  }
}

bool _isFeaturedEpisodeLive(PastEpisodeStats featured, HomeUiState? home) {
  final current = home?.currentEpisode;
  if (current == null) return false;

  final now = DateTime.now();
  if (!current.isVotingOpenAt(now)) return false;

  final statsEpisodeId = communityStatsEpisodeIdFor(current.id);
  return statsEpisodeId == featured.episode.id;
}

class _ComingSoonTab extends StatelessWidget {
  const _ComingSoonTab({required this.tab});

  final int tab;

  @override
  Widget build(BuildContext context) {
    final labels = CommunitySubTabBar.labels;
    return EmptyState(
      title: '${labels[tab]} – Version 2.0',
      subtitle: 'Gamification kommt in einer späteren Ausbaustufe.',
      icon: Icons.hourglass_empty_outlined,
    );
  }
}
