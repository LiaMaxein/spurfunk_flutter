import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CinematicPage(
      child: Column(
        children: [
          const ScreenTopBar(title: 'Live-Kommentare'),
          const SizedBox(height: 16),
          GlassCard(
            padding: const EdgeInsets.all(4),
            radius: 16,
            child: Row(
              children: const [
                Expanded(child: _Segment(label: 'Top')),
                Expanded(child: _Segment(label: 'Neueste', selected: true)),
                Expanded(child: _Segment(label: 'Meine')),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const _CommentTile(
            name: 'KrimiFan83',
            text: 'Spannung pur! Diese Wendung habe ich nicht kommen sehen. 😮',
            likes: 24,
            color: AppColors.orange,
          ),
          const _CommentTile(
            name: 'TatortQueen',
            text: 'Borowski einfach der Beste! 💙',
            likes: 18,
            color: AppColors.redSoft,
          ),
          const _CommentTile(
            name: 'Nordlicht',
            text: 'Starkes Spiel von den Ermittlern!',
            likes: 12,
            color: AppColors.green,
          ),
          const _CommentTile(
            name: 'TATORTliebhaber',
            text: 'Was haltet ihr von der Tatwaffe?',
            likes: 7,
            color: AppColors.yellow,
          ),
          const _CommentTile(
            name: 'Krimi_89',
            text: 'Mega Folge bisher! 🔥',
            likes: 6,
            color: AppColors.orange,
          ),
          const SizedBox(height: 16),
          GlassCard(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
            radius: 16,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Schreibe einen Kommentar...',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 20,
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

class _Segment extends StatelessWidget {
  const _Segment({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
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
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({
    required this.name,
    required this.text,
    required this.likes,
    required this.color,
  });

  final String name;
  final String text;
  final int likes;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AvatarBubble(color: color, icon: Icons.person_rounded, size: 42),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    Text(
                      'vor 1 Min.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              const Icon(Icons.favorite_border_rounded, size: 18),
              const SizedBox(height: 4),
              Text(
                '$likes',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
