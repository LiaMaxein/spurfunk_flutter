import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CinematicPage(
      child: Column(
        children: [
          ScreenTopBar(
            title: 'Mein Profil',
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings_outlined),
            ),
          ),
          const SizedBox(height: 18),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const AvatarBubble(
                color: AppColors.red,
                icon: Icons.person_rounded,
                size: 132,
              ),
              Positioned(
                right: 4,
                bottom: 6,
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceHighest,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: const Icon(Icons.edit_rounded, size: 17),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'TatortFan_22',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Seit März 2024 dabei',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _ProfileStat(value: '12', label: 'Abstimmungen'),
              _ProfileStat(value: '37', label: 'Kommentare'),
              _ProfileStat(value: '5', label: 'Abzeichen'),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Text(
                'Mein Avatar',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              Text(
                'Bearbeiten',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppColors.redSoft),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 18,
            runSpacing: 18,
            children: const [
              AvatarBubble(
                color: AppColors.red,
                icon: Icons.person_rounded,
                selected: true,
              ),
              AvatarBubble(color: AppColors.orange, icon: Icons.face_3_rounded),
              AvatarBubble(
                color: AppColors.textMuted,
                icon: Icons.face_6_rounded,
              ),
              AvatarBubble(
                color: Color(0xFF4AA0C8),
                icon: Icons.face_4_rounded,
              ),
              AvatarBubble(
                color: Color(0xFFB88856),
                icon: Icons.person_rounded,
              ),
              AvatarBubble(
                color: Color(0xFF6B4BCE),
                icon: Icons.face_2_rounded,
              ),
              AvatarBubble(color: AppColors.green, icon: Icons.face_rounded),
              AvatarBubble(
                color: Color(0xFFD67BB6),
                icon: Icons.face_3_rounded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
