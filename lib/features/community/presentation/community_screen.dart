import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/layout/app_shell.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/voting_widgets.dart';
import '../../../shared/models/models.dart';
import '../application/community_stats_notifier.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final stats = ref.watch(communityStatsProvider);

    return AppScaffold(
      header: const SpurfunkHeader(title: 'COMMUNITY'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _TabChip(
                  label: 'Statistiken',
                  selected: _tab == 0,
                  onTap: () => setState(() => _tab = 0),
                ),
                const SizedBox(width: 8),
                _TabChip(
                  label: 'Quiz',
                  selected: _tab == 1,
                  onTap: () => setState(() => _tab = 1),
                ),
                const SizedBox(width: 8),
                _TabChip(
                  label: 'Memory',
                  selected: _tab == 2,
                  onTap: () => setState(() => _tab = 2),
                ),
                const SizedBox(width: 8),
                _TabChip(
                  label: 'Rangliste',
                  selected: _tab == 3,
                  onTap: () => setState(() => _tab = 3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (_tab == 0) _StatsTab(stats: stats) else _ComingSoonTab(tab: _tab),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: AppColors.red,
      labelStyle: TextStyle(
        color: selected ? Colors.white : AppColors.textSecondary,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: AppColors.surface,
      side: BorderSide(color: selected ? AppColors.red : AppColors.divider),
    );
  }
}

class _StatsTab extends ConsumerWidget {
  const _StatsTab({required this.stats});

  final CommunityStatsState stats;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (stats.isLoading) {
      return const LoadingSkeleton(height: 200);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FilterSection(
          title: 'Region',
          options: CommunityStatsState.regions,
          selected: stats.filter.region,
          onSelected: (v) =>
              ref.read(communityStatsProvider.notifier).setRegion(v),
        ),
        const SizedBox(height: 10),
        _FilterSection(
          title: 'Alterskohorte',
          options: CommunityStatsState.ageCohorts,
          selected: stats.filter.ageCohort,
          onSelected: (v) =>
              ref.read(communityStatsProvider.notifier).setAgeCohort(v),
        ),
        const SizedBox(height: 10),
        _FilterSection(
          title: 'Geschlecht',
          options: CommunityStatsState.genders,
          selected: stats.filter.gender,
          onSelected: (v) =>
              ref.read(communityStatsProvider.notifier).setGender(v),
        ),
        const SizedBox(height: 16),
        for (final item in stats.episodes) ...[
          _EpisodeStatsCard(item: item),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final String title;
  final List<String> options;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          children: [
            for (final option in options)
              FilterChip(
                label: Text(option),
                selected: selected == option,
                onSelected: (v) => onSelected(v ? option : null),
                selectedColor: AppColors.red.withValues(alpha: 0.3),
              ),
          ],
        ),
      ],
    );
  }
}

class _EpisodeStatsCard extends StatelessWidget {
  const _EpisodeStatsCard({required this.item});

  final PastEpisodeStats item;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd.MM.yyyy').format(item.episode.startsAt);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.episode.title, style: Theme.of(context).textTheme.titleMedium),
          Text(date, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          for (final value in VoteValue.values.reversed)
            StatBar(
              label: value.label,
              emoji: value.emoji,
              fraction: item.aggregate.fractionFor(value),
              color: value.color,
              count: item.aggregate.countFor(value),
            ),
        ],
      ),
    );
  }
}

class _ComingSoonTab extends StatelessWidget {
  const _ComingSoonTab({required this.tab});

  final int tab;

  @override
  Widget build(BuildContext context) {
    final labels = ['Statistiken', 'Quiz', 'Memory', 'Rangliste'];
    return EmptyState(
      title: '${labels[tab]} – Version 2.0',
      subtitle: 'Gamification kommt in einer späteren Ausbaustufe.',
      icon: Icons.hourglass_empty_outlined,
    );
  }
}
