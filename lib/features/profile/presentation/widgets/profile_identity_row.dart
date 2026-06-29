import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/spurfunk_branding_widgets.dart';
import '../../data/profile_models.dart';

const _heroTextStroke = <Shadow>[
  Shadow(color: Colors.black, offset: Offset(-1, -1)),
  Shadow(color: Colors.black, offset: Offset(1, -1)),
  Shadow(color: Colors.black, offset: Offset(-1, 1)),
  Shadow(color: Colors.black, offset: Offset(1, 1)),
  Shadow(color: Colors.black, blurRadius: 8),
];

class ProfileIdentityRow extends StatelessWidget {
  const ProfileIdentityRow({
    required this.avatarAssetPath,
    required this.displayName,
    required this.progress,
    this.onAvatarTap,
    super.key,
  });

  final String avatarAssetPath;
  final String displayName;
  final ProfileXpProgress progress;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onAvatarTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.red, width: 2),
                ),
                child: SpurfunkAvatar(
                  assetPath: avatarAssetPath,
                  size: 88,
                  padding: 10,
                ),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceHigh,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.red, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.35),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName.toUpperCase(),
                style: GoogleFonts.bebasNeue(
                  fontSize: 28,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.8,
                  shadows: _heroTextStroke,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                progress.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.red,
                  fontWeight: FontWeight.w600,
                  shadows: _heroTextStroke,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceHigh,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'LEVEL ${progress.level}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileXpBar extends StatelessWidget {
  const ProfileXpBar({required this.progress, super.key});

  final ProfileXpProgress progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '${_format(progress.currentXp)} / ${_format(progress.nextLevelXp)} XP',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress.progress,
            minHeight: 8,
            backgroundColor: AppColors.divider,
            color: AppColors.red,
          ),
        ),
      ],
    );
  }

  String _format(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
  }
}

class ProfileQuickStatsRow extends StatelessWidget {
  const ProfileQuickStatsRow({required this.stats, super.key});

  final ProfileQuickStats stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickStat(
            icon: Icons.article_outlined,
            value: stats.posts,
            label: 'Beiträge',
          ),
        ),
        Expanded(
          child: _QuickStat(
            icon: Icons.forum_outlined,
            value: stats.liveChats,
            label: 'Live-Chats',
          ),
        ),
        Expanded(
          child: _QuickStat(
            icon: Icons.quiz_outlined,
            value: stats.quizzes,
            label: 'Quizze',
          ),
        ),
        Expanded(
          child: _QuickStat(
            icon: Icons.calendar_today_outlined,
            value: stats.activeDays,
            label: 'Tage aktiv',
          ),
        ),
      ],
    );
  }
}

class _QuickStat extends StatelessWidget {
  const _QuickStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.textMuted, size: 22),
        const SizedBox(height: 6),
        Text(
          _format(value),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 10,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  String _format(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
  }
}
