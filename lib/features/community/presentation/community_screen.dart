import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';
import '../application/community_state.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _tryDelete(CommunityNotifier notifier, CommunityState state, CommunityComment comment) {
    if (comment.name != state.currentUserName) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Kommentar löschen?'),
        content: const Text(
          'Möchtest du diesen Kommentar wirklich entfernen?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              notifier.deleteComment(comment.id);
              Navigator.of(ctx).pop();
            },
            child: const Text('Löschen', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(communityProvider);
    final notifier = ref.read(communityProvider.notifier);

    return CinematicPage(
      child: Column(
        children: [
          const ScreenTopBar(title: 'Community'),
          const SizedBox(height: 16),
          GlassCard(
            padding: const EdgeInsets.all(4),
            radius: 16,
            child: Row(
              children: [
                for (final tab in CommunityTab.values)
                  Expanded(
                    child: _Segment(
                      label: tab.label,
                      selected: state.selectedTab == tab,
                      onTap: () => notifier.setTab(tab),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          for (final comment in state.visibleComments)
            GestureDetector(
              onLongPress: () => _tryDelete(notifier, state, comment),
              child: _CommentTile(
                comment: comment,
                onLike: () => notifier.toggleLike(comment.id),
                onReact: (emoji) =>
                    notifier.addReaction(id: comment.id, emoji: emoji),
                emojiOptions: notifier.emojiOptions,
                isOwn: comment.name == state.currentUserName,
              ),
            ),
          const SizedBox(height: 16),
          GlassCard(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            radius: 16,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    minLines: 1,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      hintText: 'Schreibe einen Kommentar ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton.filled(
                  onPressed: () {
                    notifier.addComment(_controller.text);
                    _controller.clear();
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.red,
                    minimumSize: const Size(42, 42),
                  ),
                  icon: const Icon(Icons.send_rounded, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.label, this.selected = false, this.onTap});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.red : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: selected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({
    required this.comment,
    required this.onLike,
    required this.onReact,
    required this.emojiOptions,
    this.isOwn = false,
  });

  final CommunityComment comment;
  final VoidCallback onLike;
  final ValueChanged<String> onReact;
  final List<String> emojiOptions;
  final bool isOwn;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarBubble(color: comment.color, icon: Icons.person_rounded, size: 42),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(comment.name, style: Theme.of(context).textTheme.titleMedium),
                      if (isOwn) ...[
                        const SizedBox(width: 6),
                        Text(
                          'Du',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 11,
                            color: AppColors.redSoft,
                          ),
                        ),
                      ],
                      const Spacer(),
                      Text(
                        comment.timeLabel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  if (isOwn)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Lang drücken zum Löschen',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  const SizedBox(height: 6),
                  Text(comment.text, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      GestureDetector(
                        onTap: onLike,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              comment.likedByMe
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              size: 16,
                              color: comment.likedByMe ? AppColors.redSoft : null,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${comment.likes}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      for (final reaction in comment.reactions.entries)
                        Text(
                          '${reaction.key} ${reaction.value}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      PopupMenuButton<String>(
                        onSelected: onReact,
                        itemBuilder: (context) => [
                          for (final emoji in emojiOptions)
                            PopupMenuItem(value: emoji, child: Text(emoji)),
                        ],
                        child: const Icon(Icons.add_reaction_outlined, size: 18),
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
