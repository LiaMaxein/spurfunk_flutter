import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/layout/app_shell.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/voting_widgets.dart';
import '../../../shared/models/models.dart';
import '../application/community_stats_notifier.dart';
import 'widgets/community_stats_filters.dart';

class EpisodeStatsDetailScreen extends ConsumerStatefulWidget {
  const EpisodeStatsDetailScreen({required this.episodeId, super.key});

  final String episodeId;

  @override
  ConsumerState<EpisodeStatsDetailScreen> createState() =>
      _EpisodeStatsDetailScreenState();
}

class _EpisodeStatsDetailScreenState
    extends ConsumerState<EpisodeStatsDetailScreen> {
  bool _filtersExpanded = false;

  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(communityStatsProvider);
    PastEpisodeStats? item;
    for (final episodeStats in stats.episodes) {
      if (episodeStats.episode.id == widget.episodeId) {
        item = episodeStats;
        break;
      }
    }

    if (stats.isLoading) {
      return const AppScaffold(child: LoadingSkeleton(height: 240));
    }

    if (item == null) {
      return AppScaffold(
        header: Row(
          children: [
            IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            Expanded(
              child: Text(
                'ABSTIMMUNG',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
        child: const EmptyState(
          title: 'Folge nicht gefunden',
          subtitle: 'Für diese Episode liegen keine Statistiken vor.',
          icon: Icons.bar_chart_outlined,
        ),
      );
    }

    final episode = item.episode;
    final date = DateFormat('EEEE, dd.MM.yyyy', 'de_DE').format(episode.startsAt);
    final time = DateFormat.Hm().format(episode.startsAt);

    return AppScaffold(
      header: Row(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          Expanded(
            child: Text(
              'ABSTIMMUNG',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (episode.imageAssetPath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                episode.imageAssetPath!,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 16),
          Text(episode.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '$date · $time Uhr · ${episode.location}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Durchschnitt: ${item.averageLabel}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 16),
          CommunityLiveVotingHeader(
            filtersExpanded: _filtersExpanded,
            onFilterToggle: () {
              setState(() => _filtersExpanded = !_filtersExpanded);
            },
          ),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VoteSegmentBar(aggregate: item.aggregate),
                const SizedBox(height: 8),
                for (final value in VoteValue.values.reversed)
                  StatBar(
                    label: value.label,
                    emoji: value.emoji,
                    fraction: item.aggregate.fractionFor(value),
                    color: value.color,
                    count: item.aggregate.countFor(value),
                  ),
                const SizedBox(height: 4),
                Text(
                  'Gesamt: ${NumberFormat.decimalPattern('de_DE').format(item.aggregate.total)} Stimmen',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
