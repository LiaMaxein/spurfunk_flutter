import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/assets/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';
import '../application/home_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeStateProvider);

    return CinematicPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenTopBar(
            title: 'Tatort Liebe',
            showBack: false,
            trailing: IconButton(
              onPressed: () => ref.read(homeStateProvider.notifier).toggleLiveActive(),
              icon: Icon(
                homeState.liveActive ? Icons.live_tv_rounded : Icons.pause_circle_outline,
              ),
            ),
          ),
          const SizedBox(height: 18),
          _TickerSection(items: homeTickerItems, isLive: homeState.liveActive),
          const SizedBox(height: 16),
          if (homeState.liveActive) const _ContinueWatchingCard(),
          const SizedBox(height: 16),
          if (!homeState.liveActive)
            _SectionTitle(
              title: 'Heute ohne Live-Fall',
              subtitle: 'News und kommende Episoden für deinen Abend.',
            ),
          if (!homeState.liveActive) const SizedBox(height: 10),
          _SectionTitle(
            title: 'News',
            subtitle: 'Aktuelle Updates rund um Tatort und Community',
          ),
          const SizedBox(height: 10),
          for (final item in homeNewsItems) ...[
            _NewsCard(item: item),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 14),
          _SectionTitle(
            title: 'Kommende Episoden',
            subtitle: 'Vormerken und Erinnerungen planen',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: homeUpcomingEpisodes.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) =>
                  _EpisodeCard(item: homeUpcomingEpisodes[index]),
            ),
          ),
          const SizedBox(height: 16),
          _SectionTitle(
            title: 'Tatort-Teams',
            subtitle: 'Wähle dein Ermittlerteam',
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 96,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: homeTeams.length,
              separatorBuilder: (_, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) => _TeamChip(
                team: homeTeams[index],
                selected: homeState.selectedTeam == index,
                onTap: () => ref.read(homeStateProvider.notifier).selectTeam(index),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SectionTitle(
            title: 'Trendende Diskussionen',
            subtitle: 'Direkt in die Community springen',
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < homeDiscussions.length; i++) ...[
            _DiscussionCard(
              item: homeDiscussions[i],
              selected: homeState.selectedDiscussion == i,
              onTap: () => ref.read(homeStateProvider.notifier).selectDiscussion(i),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
          const _HeroEpisodeCard(),
          const SizedBox(height: 18),
          FilledButton.icon(
            onPressed: () => context.go(AppRoutes.liveEpisode.path),
            icon: const Icon(Icons.live_tv_rounded),
            label: const Text('Zum Live-Bereich'),
          ),
        ],
      ),
    );
  }
}

class _HeroEpisodeCard extends StatelessWidget {
  const _HeroEpisodeCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        height: 280,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppAssets.mockupIntro,
              fit: BoxFit.cover,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.12),
                    AppColors.black.withValues(alpha: 0.38),
                    AppColors.black.withValues(alpha: 0.92),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const RedPill(
                    label: 'LIVE',
                    icon: Icons.circle,
                    selected: true,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Borowski und das Haupt der Medusa',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'ARD',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.public_rounded, size: 17),
                      const SizedBox(width: 14),
                      Text(
                        'Noch 32 Min.',
                        style: Theme.of(context).textTheme.bodyMedium,
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

class _TickerSection extends StatelessWidget {
  const _TickerSection({required this.items, required this.isLive});

  final List<HomeTickerItem> items;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              RedPill(
                label: isLive ? 'Live-Ticker aktiv' : 'Live-Ticker pausiert',
                icon: Icons.circle,
                selected: isLive,
              ),
              const Spacer(),
              Text('Heute', style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          const SizedBox(height: 12),
          for (final ticker in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text('• ${ticker.text}', style: Theme.of(context).textTheme.bodyLarge),
            ),
        ],
      ),
    );
  }
}

class _ContinueWatchingCard extends StatelessWidget {
  const _ContinueWatchingCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              AppAssets.mockupIntro,
              width: 86,
              height: 66,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Weitersehen', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  'Borowski und das Haupt der Medusa · 58%',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Icon(Icons.play_circle_fill_rounded, size: 34, color: AppColors.redSoft),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.item});
  final HomeNewsItem item;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(item.icon, color: item.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(item.subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EpisodeCard extends StatelessWidget {
  const _EpisodeCard({required this.item});
  final HomeEpisodePreview item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.day, style: Theme.of(context).textTheme.labelLarge),
            Text(item.title, style: Theme.of(context).textTheme.titleMedium),
            Text(item.time, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

class _TeamChip extends StatelessWidget {
  const _TeamChip({
    required this.team,
    required this.selected,
    required this.onTap,
  });

  final HomeTeam team;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AvatarBubble(color: team.color, icon: Icons.shield_rounded, selected: selected),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(team.name, style: Theme.of(context).textTheme.titleMedium),
              Text(team.city, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class _DiscussionCard extends StatelessWidget {
  const _DiscussionCard({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final HomeDiscussion item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: selected ? AppColors.redSoft : null,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${item.replies} Antworten · ${item.lastActivity}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
