import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/layout/app_shell.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/voting_widgets.dart';
import '../../../shared/models/models.dart';
import '../application/home_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeNotifierProvider);

    return homeAsync.when(
      loading: () => const AppScaffold(child: LoadingSkeleton(height: 200)),
      error: (e, _) => AppScaffold(
        child: ErrorState(
          message: e.toString(),
          onRetry: () => ref.invalidate(homeNotifierProvider),
        ),
      ),
      data: (home) => AppScaffold(
        header: SpurfunkHeader(
          trailing: IconButton(
            onPressed: () {},
            icon: const Badge(
              smallSize: 8,
              child: Icon(Icons.notifications_outlined),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (home.isLive)
              _LiveBanner(episode: home.currentEpisode!)
            else
              _CountdownCard(episode: home.nextEpisode),
            const SizedBox(height: 16),
            if (home.lastVoteAggregate != null)
              _PollSummaryCard(aggregate: home.lastVoteAggregate!),
            const SizedBox(height: 16),
            Text(
              'POLIZEIFUNK – NEWS',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.red,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 10),
            for (final item in home.news) ...[
              _NewsCard(item: item),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 16),
            Text('ENTDECKE MEHR', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.4,
              children: [
                _QuickLink(
                  icon: Icons.forum_outlined,
                  label: 'Community',
                  subtitle: 'Jetzt diskutieren',
                  onTap: () => context.go(AppRoutes.community.path),
                ),
                _QuickLink(
                  icon: Icons.folder_outlined,
                  label: 'Fakten',
                  subtitle: 'Wissen entdecken',
                  onTap: () => context.go(AppRoutes.facts.path),
                ),
                _QuickLink(
                  icon: Icons.bar_chart_outlined,
                  label: 'Statistiken',
                  subtitle: 'Zahlen & Fakten',
                  onTap: () => context.go(AppRoutes.community.path),
                ),
                _QuickLink(
                  icon: Icons.live_tv_outlined,
                  label: 'Live',
                  subtitle: 'Mitwisser-Chat',
                  onTap: () => context.go(AppRoutes.liveEpisode.path),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LiveBanner extends StatelessWidget {
  const _LiveBanner({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => context.go(AppRoutes.liveEpisode.path),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              LiveBadge(),
              SizedBox(width: 8),
              Text('LIVE JETZT'),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AppAssets.heroEpisode,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(episode.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            '${episode.sender} · seit ${DateFormat.Hm().format(episode.startsAt)}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _CountdownCard extends StatelessWidget {
  const _CountdownCard({required this.episode});

  final Episode? episode;

  @override
  Widget build(BuildContext context) {
    if (episode == null) {
      return const EmptyState(
        title: 'Keine Sendung geplant',
        subtitle: 'Momentan keine Neuigkeiten zur nächsten Folge.',
      );
    }

    final diff = episode!.startsAt.difference(DateTime.now());
    final days = diff.inDays;
    final hours = diff.inHours % 24;
    final minutes = diff.inMinutes % 60;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'KEIN LIVE – NÄCHSTER TATORT',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.red,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AppAssets.homeNoLive,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(episode!.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Row(
            children: [
              _CountdownBox(value: days, label: 'Tage'),
              const SizedBox(width: 8),
              _CountdownBox(value: hours, label: 'Std'),
              const SizedBox(width: 8),
              _CountdownBox(value: minutes, label: 'Min'),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountdownBox extends StatelessWidget {
  const _CountdownBox({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.red.withValues(alpha: 0.4)),
        ),
        child: Column(
          children: [
            Text(
              value.toString().padLeft(2, '0'),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.red,
              ),
            ),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _PollSummaryCard extends StatelessWidget {
  const _PollSummaryCard({required this.aggregate});

  final VoteAggregate aggregate;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Letzte Abstimmung',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            '${aggregate.total} Stimmen',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          for (final value in VoteValue.values.reversed)
            StatBar(
              label: value.label,
              emoji: value.emoji,
              fraction: aggregate.fractionFor(value),
              color: value.color,
              count: aggregate.countFor(value),
            ),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.item});

  final NewsItem item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          const Icon(Icons.campaign_outlined, color: AppColors.red),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                Text(item.teaser, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.red),
          const SizedBox(height: 8),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
