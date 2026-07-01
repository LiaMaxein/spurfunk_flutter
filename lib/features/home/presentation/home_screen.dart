import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../core/assets/app_assets.dart';
import '../../../core/layout/app_shell.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/episode_countdown.dart';
import '../../../core/widgets/voting_widgets.dart';
import '../../../shared/models/models.dart';
import '../../community/presentation/widgets/episode_stats_card.dart';
import '../application/home_notifier.dart';
import '../../../shared/repositories/repository_providers.dart';

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
          logoHeight: 52,
          trailing: IconButton(
            onPressed: () {},
            icon: const Badge(
              smallSize: 8,
              backgroundColor: AppColors.red,
              child: Icon(Icons.notifications_outlined),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (home.isLive)
              _LiveHeroBanner(episode: home.currentEpisode!)
            else
              _NextEpisodeCountdownCard(episode: home.nextEpisode),
            const SizedBox(height: 16),
            if (home.isLive && home.liveVoteAggregate != null)
              _ActivePollCard(
                episodeId: home.currentEpisode!.id,
                aggregate: home.liveVoteAggregate!,
                pollEndsAt: home.pollEndsAt,
              )
            else if (home.lastVoteAggregate != null)
              _PollSummaryCard(aggregate: home.lastVoteAggregate!),
            const SizedBox(height: 20),
            Text(
              'POLIZEIFUNK – NEWS',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            for (final item in home.news) ...[
              _NewsCard(item: item),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 16),
            Text(
              'ENTDECKE MEHR',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.35,
              children: [
                _QuickLink(
                  icon: Icons.location_city_outlined,
                  label: 'Städte',
                  subtitle: 'Aktive & ehemalige Standorte',
                  onTap: () => context.go('${AppRoutes.facts.path}?tab=cities'),
                ),
                _QuickLink(
                  icon: Icons.folder_outlined,
                  label: 'Fakten',
                  subtitle: 'Wissen entdecken',
                  onTap: () => context.go(AppRoutes.facts.path),
                ),
                _QuickLink(
                  icon: Icons.quiz_outlined,
                  label: 'Quiz',
                  subtitle: 'Jetzt spielen',
                  onTap: () => context.go('${AppRoutes.community.path}?tab=quiz'),
                ),
                _QuickLink(
                  icon: Icons.bar_chart_outlined,
                  label: 'Statistiken',
                  subtitle: 'Zahlen & Fakten',
                  onTap: () => context.go(AppRoutes.community.path),
                ),
              ],
            ),
            if (home.upcomingEpisodes.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text(
                'DEMNÄCHST',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              for (final episode in home.upcomingEpisodes)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _UpcomingEpisodeCard(episode: episode),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LiveHeroBanner extends StatefulWidget {
  const _LiveHeroBanner({required this.episode});

  final Episode episode;

  @override
  State<_LiveHeroBanner> createState() => _LiveHeroBannerState();
}

class _LiveHeroBannerState extends State<_LiveHeroBanner> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final remaining = widget.episode.endsAt.difference(DateTime.now());
    setState(() => _remaining = remaining.isNegative ? Duration.zero : remaining);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatCountdown(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes % 60;
    final s = d.inSeconds % 60;
    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppRoutes.liveEpisode.path),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 158,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppAssets.homeLiveHero,
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.35),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.25),
                      Colors.black.withValues(alpha: 0.55),
                      Colors.black.withValues(alpha: 0.92),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'JETZT LIVE',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.episode.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${widget.episode.sender} · seit '
                      '${DateFormat.Hm().format(widget.episode.startsAt)} Uhr',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Verbleibende Zeit',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red,
                        height: 1,
                      ),
                    ),
                    Text(
                      _formatCountdown(_remaining),
                      style: GoogleFonts.bebasNeue(
                        fontSize: 20,
                        color: Colors.white,
                        letterSpacing: 1.2,
                        height: 0.95,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NextEpisodeCountdownCard extends StatefulWidget {
  const _NextEpisodeCountdownCard({required this.episode});

  final Episode? episode;

  @override
  State<_NextEpisodeCountdownCard> createState() =>
      _NextEpisodeCountdownCardState();
}

class _NextEpisodeCountdownCardState extends State<_NextEpisodeCountdownCard> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final episode = widget.episode;
    if (episode == null) return;
    final remaining = episode.startsAt.difference(DateTime.now());
    setState(() => _remaining = remaining.isNegative ? Duration.zero : remaining);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final episode = widget.episode;
    if (episode == null) {
      return const EmptyState(
        title: 'Keine Sendung geplant',
        subtitle: 'Momentan keine Neuigkeiten zur nächsten Folge.',
      );
    }

    final heroAsset =
        episode.imageAssetPath ?? AppAssets.heroForLocation(episode.location);
    final formattedSlot = DateFormat(
      'EEEE, HH:mm',
      'de_DE',
    ).format(episode.startsAt);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 248,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(heroAsset, fit: BoxFit.cover),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.35),
                    Colors.black.withValues(alpha: 0.62),
                    Colors.black.withValues(alpha: 0.94),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KEIN LIVE – NÄCHSTER TATORT',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    episode.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${episode.sender} · $formattedSlot Uhr',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.92),
                    ),
                  ),
                  const Spacer(),
                  EpisodeCountdown(remaining: _remaining, showSeconds: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivePollCard extends ConsumerStatefulWidget {
  const _ActivePollCard({
    required this.episodeId,
    required this.aggregate,
    this.pollEndsAt,
  });

  final String episodeId;
  final VoteAggregate aggregate;
  final DateTime? pollEndsAt;

  @override
  ConsumerState<_ActivePollCard> createState() => _ActivePollCardState();
}

class _ActivePollCardState extends ConsumerState<_ActivePollCard> {
  late Timer _timer;
  Duration _pollRemaining = Duration.zero;
  VoteValue? _selectedVote;
  String? _feedback;
  String? _hint;
  bool _loadingVote = true;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadVoteState());
  }

  Future<void> _loadVoteState() async {
    final repo = ref.read(voteRepositoryProvider);
    final last = await repo.lastVote(widget.episodeId);
    if (!mounted) return;
    setState(() {
      _selectedVote = last;
      _loadingVote = false;
    });
  }

  void _tick() {
    if (widget.pollEndsAt == null) return;
    final remaining = widget.pollEndsAt!.difference(DateTime.now());
    setState(() => _pollRemaining = remaining.isNegative ? Duration.zero : remaining);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatPollRemaining(Duration d) {
    final m = d.inMinutes;
    final s = d.inSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Future<void> _onVote(VoteValue value) async {
    final repo = ref.read(voteRepositoryProvider);
    final cooldown = await repo.voteCooldownRemaining(widget.episodeId);
    if (cooldown != null) {
      final minutes = cooldown.inMinutes.clamp(1, 30);
      setState(() {
        _hint =
            'Du hast vor Kurzem abgestimmt. Nächste Stimme in ca. $minutes Min.';
        _feedback = null;
      });
      return;
    }

    final ok = await repo.submitVote(widget.episodeId, value);
    if (!ok || !mounted) return;

    setState(() {
      _selectedVote = value;
      _feedback = 'Deine Stimme wurde gezählt: ${value.label} ${value.emoji}';
      _hint = null;
    });
    ref.invalidate(homeNotifierProvider);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'AKTIVE UMFRAGE',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const Spacer(),
              Text(
                'Noch ${_formatPollRemaining(_pollRemaining)} Min.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Wie gefällt dir der aktuelle Tatort?',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tippe ein Emoji – du kannst alle 30 Minuten einmal abstimmen.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final value in VoteValue.values)
                Expanded(
                  child: _LiveVoteOption(
                    value: value,
                    percent: widget.aggregate.fractionFor(value),
                    selected: _selectedVote == value,
                    enabled: !_loadingVote,
                    onTap: () => _onVote(value),
                  ),
                ),
            ],
          ),
          if (_feedback != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.green.withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, color: AppColors.green, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _feedback!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (_hint != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceHigh,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppColors.red, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _hint!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 10),
          InkWell(
            onTap: () => openEpisodeStatsDetail(
              context,
              communityStatsEpisodeIdFor(widget.episodeId),
            ),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  const Icon(Icons.groups_outlined, color: AppColors.red, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    'LIVE-ERGEBNISSE',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.red,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.aggregate.total} haben abgestimmt',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textMuted,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          VoteSegmentBar(aggregate: widget.aggregate),
        ],
      ),
    );
  }
}

class _LiveVoteOption extends StatelessWidget {
  const _LiveVoteOption({
    required this.value,
    required this.percent,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final VoteValue value;
  final double percent;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${value.label} bewerten',
      button: true,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Opacity(
          opacity: enabled ? 1 : 0.5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 46,
                  height: 46,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected
                        ? value.color.withValues(alpha: 0.18)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: selected ? value.color : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Text(value.emoji, style: const TextStyle(fontSize: 30)),
                ),
                const SizedBox(height: 3),
                Text(
                  value.label,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 10,
                    color: AppColors.textPrimary,
                    height: 1.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${(percent * 100).round()}%',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 10,
                    color: AppColors.textMuted,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
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
      onTap: () => context.go(AppRoutes.community.path),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'LETZTE ABSTIMMUNG',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${aggregate.total} Stimmen · Tippe für Statistiken',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          VoteSegmentBar(aggregate: aggregate),
          const SizedBox(height: 8),
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
      onTap: () {},
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.campaign_outlined, color: AppColors.red),
          ),
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
          const Icon(Icons.chevron_right, color: AppColors.textMuted),
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.red, size: 26),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 12,
              height: 1.25,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _UpcomingEpisodeCard extends StatelessWidget {
  const _UpcomingEpisodeCard({required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    final imageAsset =
        episode.imageAssetPath ?? AppAssets.heroForLocation(episode.location);

    final broadcastDate = DateFormat(
      'EEEE, d. MMMM yyyy',
      'de_DE',
    ).format(episode.startsAt);
    final broadcastTime =
        '${DateFormat.Hm().format(episode.startsAt)} Uhr · ${episode.sender}';

    return AppCard(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageAsset,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  episode.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  broadcastDate,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  broadcastTime,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
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
