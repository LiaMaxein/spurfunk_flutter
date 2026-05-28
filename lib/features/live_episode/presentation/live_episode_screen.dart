import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';
import '../../voting/application/voting_state.dart';
import '../data/live_episode_demo_data.dart';

class LiveEpisodeScreen extends ConsumerStatefulWidget {
  const LiveEpisodeScreen({super.key});

  @override
  ConsumerState<LiveEpisodeScreen> createState() => _LiveEpisodeScreenState();
}

class _LiveEpisodeScreenState extends ConsumerState<LiveEpisodeScreen> {
  late int _secondsRemaining;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = liveEpisodeDemo.remainingMinutes * 60;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_secondsRemaining <= 0) return;
      setState(() => _secondsRemaining--);
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  String get _countdownLabel {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final voting = ref.watch(votingProvider);
    final votingNotifier = ref.read(votingProvider.notifier);
    final ratings = VoteRating.values.reversed.toList();

    return CinematicPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTopBar(title: 'Live'),
          const SizedBox(height: 14),
          _LiveHeroCard(
            episode: liveEpisodeDemo,
            countdown: _countdownLabel,
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _QuickStatCard(
                  label: 'Zuschauer live',
                  value: '18.420',
                  icon: Icons.groups_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickStatCard(
                  label: 'Reaktionen',
                  value: '${voting.totalVotes}',
                  icon: Icons.emoji_emotions_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SectionTitle(
            title: 'Aktive Umfrage',
            subtitle: 'Direkt im Live-Bereich abstimmen',
          ),
          const SizedBox(height: 10),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final rating in VoteRating.values) ...[
                        EmojiVoteButton(
                          emoji: rating.emoji,
                          label: rating.label,
                          color: rating.color,
                          selected: voting.selected == rating,
                          onTap: () => votingNotifier.selectVote(rating),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _FilterRow<VotingRegion>(
                  title: 'Region',
                  values: VotingRegion.values,
                  selected: voting.region,
                  labelBuilder: (value) => value.label,
                  onSelected: votingNotifier.setRegion,
                ),
                const SizedBox(height: 10),
                _FilterRow<VotingAgeGroup>(
                  title: 'Alter',
                  values: VotingAgeGroup.values,
                  selected: voting.ageGroup,
                  labelBuilder: (value) => value.label,
                  onSelected: votingNotifier.setAgeGroup,
                ),
                const SizedBox(height: 10),
                _FilterRow<VotingGender>(
                  title: 'Geschlecht',
                  values: VotingGender.values,
                  selected: voting.gender,
                  labelBuilder: (value) => value.label,
                  onSelected: votingNotifier.setGender,
                ),
                const SizedBox(height: 14),
                for (final rating in ratings)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ResultBar(
                      label: rating.label,
                      value: (voting.counts[rating] ?? 0) / voting.totalVotes,
                      color: rating.color,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Trending Reaktionen',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < liveReactionTrends.length; i++) ...[
                  if (i > 0) const SizedBox(width: 12),
                  _TrendingReactionCard(trend: liveReactionTrends[i]),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SectionTitle(
            title: 'Episode-Timeline',
            subtitle: 'Wichtige Momente im Verlauf',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: liveTimelineItems.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = liveTimelineItems[index];
                return SizedBox(
                  width: 188,
                  child: GlassCard(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.minute, style: Theme.of(context).textTheme.labelLarge),
                        Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: item.highlighted ? AppColors.redSoft : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 18),
          _SectionTitle(
            title: 'Trendende Theorie',
            subtitle: trendingTheory,
          ),
          const SizedBox(height: 10),
          GlassCard(
            child: Text(
              suspiciousCharacter,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.redSoft,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Live-Feed',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < liveActivityFeed.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == liveActivityFeed.length - 1 ? 0 : 10),
              child: _ActivityCard(
                item: liveActivityFeed[i],
                index: i,
              ),
            ),
          const SizedBox(height: 18),
          GlassCard(
            onTap: () {},
            child: Row(
              children: [
                const Icon(Icons.how_to_vote_rounded, color: AppColors.redSoft),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reaktionsstatus',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        voting.userHasVoted
                            ? 'Deine Stimme: ${voting.selected?.label ?? '–'}'
                            : 'Noch keine Stimme – was ist dein Eindruck?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveHeroCard extends StatefulWidget {
  const _LiveHeroCard({required this.episode, required this.countdown});

  final LiveEpisodeInfo episode;
  final String countdown;

  @override
  State<_LiveHeroCard> createState() => _LiveHeroCardState();
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class _FilterRow<T> extends StatelessWidget {
  const _FilterRow({
    required this.title,
    required this.values,
    required this.selected,
    required this.labelBuilder,
    required this.onSelected,
  });

  final String title;
  final List<T> values;
  final T selected;
  final String Function(T value) labelBuilder;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 6),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (final value in values) ...[
                GestureDetector(
                  onTap: () => onSelected(value),
                  child: RedPill(
                    label: labelBuilder(value),
                    selected: value == selected,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _LiveHeroCardState extends State<_LiveHeroCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(widget.episode.heroAsset, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.2),
                    AppColors.black.withValues(alpha: 0.55),
                    AppColors.black.withValues(alpha: 0.94),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeTransition(
                    opacity: Tween<double>(begin: 0.65, end: 1).animate(
                      CurvedAnimation(
                        parent: _pulseController,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: const RedPill(
                      label: 'LIVE',
                      icon: Icons.circle,
                      selected: true,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.episode.title,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.episode.subtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(
                        Icons.tv_rounded,
                        size: 18,
                        color: AppColors.textSecondary.withValues(alpha: 0.9),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.episode.station,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Spacer(),
                      GlassCard(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        radius: 14,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              size: 18,
                              color: AppColors.redSoft,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              widget.countdown,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontFeatures: const [
                                      FontFeature.tabularFigures(),
                                    ],
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  const _QuickStatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.redSoft, size: 22),
          const SizedBox(height: 10),
          Text(value, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _TrendingReactionCard extends StatelessWidget {
  const _TrendingReactionCard({required this.trend});

  final LiveReactionTrend trend;

  @override
  Widget build(BuildContext context) {
    final positive = trend.deltaPercent >= 0;

    return SizedBox(
      width: 148,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(trend.rating.emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 6),
            Text(
              trend.rating.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 6),
            Text(
              '${trend.count}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 2),
            Text(
              '${positive ? '+' : ''}${trend.deltaPercent.toStringAsFixed(1)}%',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: positive ? AppColors.greenSoft : AppColors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.item, required this.index});

  final LiveActivityItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 360 + (index * 70)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 12 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: item.color.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: item.color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        item.user,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const Spacer(),
                      Text(
                        item.timeAgo,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.message,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
