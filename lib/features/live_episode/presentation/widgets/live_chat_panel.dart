import 'package:flutter/material.dart';

import '../../../../core/assets/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_components.dart';
import '../../../../core/widgets/spurfunk_branding_widgets.dart';
import '../../application/live_notifier.dart';

class LiveChatPanel extends StatelessWidget {
  const LiveChatPanel({
    required this.state,
    required this.messageController,
    required this.scrollController,
    required this.onSend,
    required this.onReaction,
    required this.onClearHint,
    super.key,
  });

  final LiveUiState state;
  final TextEditingController messageController;
  final ScrollController scrollController;
  final ValueChanged<String> onSend;
  final ValueChanged<String> onReaction;
  final VoidCallback onClearHint;

  static const quickEmojis = ['❤️', '😂', '😮', '😢', '😡', '🔥'];
  static const heartReaction = '❤️';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppAssets.homeLiveHero,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.black.withValues(alpha: 0.45),
                      AppColors.black.withValues(alpha: 0.82),
                      AppColors.black,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: LiveBadge(pulsing: true),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Mitwisser-Chat',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${state.onlineCount} online',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child:
                  state.messages.isEmpty
                      ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'Noch keine Nachrichten. Starte die Diskussion.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                      : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          final msg = state.messages[index];
                          final avatar = avatarForMessage(msg);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SpurfunkAvatar(
                                  assetPath: avatar.assetPath,
                                  size: 32,
                                  padding: 3,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.surface.withValues(
                                        alpha: 0.92,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                msg.alias,
                                                style:
                                                    Theme.of(
                                                      context,
                                                    ).textTheme.titleMedium?.copyWith(
                                                      fontSize: 12,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              _formatTime(msg.createdAt),
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium?.copyWith(
                                                    fontSize: 11,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          msg.content,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyMedium?.copyWith(
                                                fontSize: 13,
                                                color: AppColors.textPrimary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
            if (state.rateLimitHint != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Material(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  child: ListTile(
                    dense: true,
                    leading: const Icon(
                      Icons.info_outline,
                      color: AppColors.red,
                    ),
                    title: Text(
                      state.rateLimitHint!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    trailing: IconButton(
                      onPressed: onClearHint,
                      icon: const Icon(Icons.close, size: 18),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: InkWell(
                        onTap: () => onReaction(heartReaction),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 48,
                          height: 42,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: AppColors.red,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                    for (final emoji in quickEmojis.skip(1))
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () => onReaction(emoji),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 48,
                            height: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.divider),
                            ),
                            child: Text(
                              emoji,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      enabled: state.chatOpen,
                      decoration: const InputDecoration(
                        hintText: 'Schreib etwas...',
                        fillColor: AppColors.surface,
                      ),
                      onSubmitted: onSend,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed:
                          state.chatOpen
                              ? () => onSend(messageController.text)
                              : null,
                      icon: const Icon(Icons.send_rounded),
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
