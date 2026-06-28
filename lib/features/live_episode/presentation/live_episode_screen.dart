import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/layout/app_shell.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/voting_widgets.dart';
import '../../../shared/models/models.dart';
import '../application/live_notifier.dart';

class LiveEpisodeScreen extends ConsumerStatefulWidget {
  const LiveEpisodeScreen({super.key});

  @override
  ConsumerState<LiveEpisodeScreen> createState() => _LiveEpisodeScreenState();
}

class _LiveEpisodeScreenState extends ConsumerState<LiveEpisodeScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  static const _quickEmojis = ['❤️', '😂', '😮', '😢', '😡', '🔥'];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final live = ref.watch(liveNotifierProvider);
    final reactions = ref.watch(floatingReactionsProvider);

    if (live.isLoading) {
      return const AppScaffold(child: LoadingSkeleton(height: 240));
    }

    final episode = live.episode;
    if (episode == null) {
      return AppScaffold(
        header: const SpurfunkHeader(title: 'LIVE'),
        child: const EmptyState(
          title: 'Heute ist kein Tatort live',
          subtitle: 'Schau auf Home für den Countdown zur nächsten Folge.',
          icon: Icons.live_tv_outlined,
        ),
      );
    }

    if (!live.isLive) {
      return AppScaffold(
        header: const SpurfunkHeader(title: 'LIVE'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HEUTE IST KEIN TATORT LIVE',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Nächste Folge: ${episode.title}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            if (live.aggregate != null) _VoteResults(aggregate: live.aggregate!),
            const SizedBox(height: 16),
            SecondaryButton(
              label: 'Alle Statistiken ansehen',
              onPressed: () {},
            ),
          ],
        ),
      );
    }

    return ColoredBox(
      color: AppColors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    children: [
                      const LiveBadge(),
                      const SizedBox(width: 8),
                      Text(
                        '${live.onlineCount} online',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: live.messages.length,
                    itemBuilder: (context, index) {
                      final msg = live.messages[index];
                      final avatar = avatarForMessage(msg);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: avatar.color,
                              child: Icon(avatar.icon, color: Colors.white, size: 18),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        msg.alias,
                                        style: Theme.of(context).textTheme.labelLarge,
                                      ),
                                      const Spacer(),
                                      Text(
                                        _formatTime(msg.createdAt),
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    msg.content,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (live.aggregate != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _VotePanel(
                      aggregate: live.aggregate!,
                      hasVoted: live.hasVoted,
                      selected: live.selectedVote,
                      votingOpen: live.votingOpen,
                      onVote: (v) =>
                          ref.read(liveNotifierProvider.notifier).submitVote(v),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final emoji in _quickEmojis)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: IconButton(
                              onPressed: () => ref
                                  .read(liveNotifierProvider.notifier)
                                  .sendReaction(emoji),
                              icon: Text(emoji, style: const TextStyle(fontSize: 22)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Schreib etwas …',
                          ),
                          onSubmitted: _send,
                        ),
                      ),
                      IconButton(
                        onPressed: () => _send(_messageController.text),
                        icon: const Icon(Icons.send, color: AppColors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            for (var i = 0; i < reactions.length; i++)
              _FloatingEmoji(
                key: ValueKey(reactions[i].id),
                emoji: reactions[i].emoji,
                index: i,
              ),
          ],
        ),
      ),
    );
  }

  void _send(String text) {
    ref.read(liveNotifierProvider.notifier).sendMessage(text);
    _messageController.clear();
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

class _VotePanel extends StatelessWidget {
  const _VotePanel({
    required this.aggregate,
    required this.hasVoted,
    required this.selected,
    required this.votingOpen,
    required this.onVote,
  });

  final VoteAggregate aggregate;
  final bool hasVoted;
  final VoteValue? selected;
  final bool votingOpen;
  final ValueChanged<VoteValue> onVote;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wie findest du den heutigen Fall?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final value in VoteValue.values)
                VoteOptionButton(
                  value: value,
                  selected: selected == value,
                  enabled: votingOpen && !hasVoted,
                  onTap: () => onVote(value),
                ),
            ],
          ),
          const SizedBox(height: 12),
          for (final value in VoteValue.values.reversed)
            StatBar(
              label: value.label,
              emoji: value.emoji,
              fraction: aggregate.fractionFor(value),
              color: value.color,
            ),
        ],
      ),
    );
  }
}

class _VoteResults extends StatelessWidget {
  const _VoteResults({required this.aggregate});

  final VoteAggregate aggregate;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Letzte Abstimmung', style: Theme.of(context).textTheme.titleMedium),
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

class _FloatingEmoji extends StatefulWidget {
  const _FloatingEmoji({required this.emoji, required this.index, super.key});

  final String emoji;
  final int index;

  @override
  State<_FloatingEmoji> createState() => _FloatingEmojiState();
}

class _FloatingEmojiState extends State<_FloatingEmoji>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
  return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        return Positioned(
          right: 16 + (widget.index % 3) * 12.0,
          bottom: 120 + t * (media.height * 0.35),
          child: Opacity(
            opacity: 1 - t,
            child: Text(widget.emoji, style: const TextStyle(fontSize: 28)),
          ),
        );
      },
    );
  }
}
