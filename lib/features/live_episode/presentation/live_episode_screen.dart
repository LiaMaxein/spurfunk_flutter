import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/layout/app_shell.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../application/live_notifier.dart';
import 'widgets/live_chat_panel.dart';
import 'widgets/live_current_case_tab.dart';
import 'widgets/live_floating_emoji.dart';
import 'widgets/live_non_live_panel.dart';
import 'widgets/live_sub_tab_bar.dart';

class LiveEpisodeScreen extends ConsumerStatefulWidget {
  const LiveEpisodeScreen({super.key});

  @override
  ConsumerState<LiveEpisodeScreen> createState() => _LiveEpisodeScreenState();
}

class _LiveEpisodeScreenState extends ConsumerState<LiveEpisodeScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  LiveTab _selectedTab = LiveTab.chat;
  int _lastMessageTick = 0;

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

    if (live.messageTick != _lastMessageTick) {
      _lastMessageTick = live.messageTick;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_scrollController.hasClients) return;
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
        );
      });
    }

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

    return ColoredBox(
      color: AppColors.black,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                Text(
                  'LIVE',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.bebasNeue(
                    fontSize: 30,
                    color: AppColors.textPrimary,
                    letterSpacing: 1.1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
                  child: LiveSubTabBar(
                    selected: _selectedTab,
                    onChanged: (tab) => setState(() => _selectedTab = tab),
                  ),
                ),
                Expanded(
                  child:
                      _selectedTab == LiveTab.chat
                          ? (live.isLive
                              ? LiveChatPanel(
                                state: live,
                                messageController: _messageController,
                                scrollController: _scrollController,
                                onSend: _send,
                                onReaction:
                                    (emoji) => ref
                                        .read(liveNotifierProvider.notifier)
                                        .sendReaction(emoji),
                                onClearHint:
                                    ref
                                        .read(liveNotifierProvider.notifier)
                                        .clearRateLimitHint,
                              )
                              : LiveNonLivePanel(
                                nextEpisode: episode,
                                lastEpisodeStats: live.lastEpisodeStats,
                                now: live.now,
                              ))
                          : LiveCurrentCaseTab(episode: episode),
                ),
              ],
            ),
            for (var i = 0; i < reactions.length; i++)
              LiveFloatingEmoji(
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
}
