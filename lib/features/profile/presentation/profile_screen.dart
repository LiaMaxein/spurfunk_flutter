import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/layout/app_shell.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_components.dart';
import '../../../core/widgets/spurfunk_branding_widgets.dart';
import '../../../shared/mock_data/mock_data.dart';
import '../../onboarding/application/onboarding_state.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(selectedAvatarProvider);
    final displayName = ref.watch(displayNameProvider);
    final anonymous = ref.watch(anonymousModeProvider);

    return AppScaffold(
      header: SpurfunkHeader(
        title: 'AKTE',
        trailing: IconButton(
          onPressed: () => context.go(AppRoutes.profileSettingsPath),
          icon: const Icon(Icons.settings_outlined),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                SpurfunkAvatar(
                  assetPath: role.assetPath,
                  size: 96,
                  padding: 12,
                ),
                const SizedBox(height: 12),
                Text(displayName, style: Theme.of(context).textTheme.headlineMedium),
                Text(
                  role.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.red,
                  ),
                ),
                Text(
                  anonymous ? 'Anonyme Teilnahme' : 'Alias aktiv',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatBox(value: '12', label: 'Level'),
              _StatBox(value: '1.620', label: 'XP'),
              _StatBox(value: '87', label: 'Chats'),
            ],
          ),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mitwisser-Fortschritt', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.72,
                    minHeight: 8,
                    backgroundColor: AppColors.divider,
                    color: AppColors.red,
                  ),
                ),
                const SizedBox(height: 6),
                Text('2.450 / 3.000 XP', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Symbolischer Avatar', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Im Chat und in der Community wird dein Noir-Icon angezeigt.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final avatar in symbolicAvatars)
                SpurfunkAvatar(
                  assetPath: avatar.assetPath,
                  size: 40,
                  padding: 4,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.headlineMedium),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
