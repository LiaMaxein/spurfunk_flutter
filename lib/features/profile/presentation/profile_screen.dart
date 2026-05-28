import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';
import '../../onboarding/application/onboarding_state.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = ref.read(usernameProvider);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _openAvatarPicker() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (context) {
        final selectedId = ref.watch(selectedAvatarIdProvider);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: avatarPresets.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.92,
              ),
              itemBuilder: (context, index) {
                final avatar = avatarPresets[index];
                return GlassCard(
                  onTap: () {
                    ref.read(selectedAvatarIdProvider.notifier).select(avatar.id);
                    context.pop();
                  },
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AvatarBubble(
                        color: avatar.colors.first,
                        icon: avatar.icon,
                        selected: selectedId == avatar.id,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        avatar.name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveName() async {
    await ref.read(usernameProvider.notifier).update(_nameController.text.trim());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil lokal gespeichert')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatar = ref.watch(selectedAvatarProvider);
    final displayName = ref.watch(displayNameProvider);
    final anonymous = ref.watch(anonymousModeProvider);

    return CinematicPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenTopBar(
            title: 'Mein Profil',
            trailing: IconButton(
              onPressed: () => context.go(AppRoutes.profileSettingsPath),
              icon: const Icon(Icons.settings_outlined),
            ),
          ),
          const SizedBox(height: 18),
          Stack(
            clipBehavior: Clip.none,
            children: [
              AvatarBubble(
                color: avatar.colors.first,
                icon: avatar.icon,
                size: 132,
              ),
              Positioned(
                right: 4,
                bottom: 6,
                child: IconButton.filled(
                  onPressed: _openAvatarPicker,
                  style: IconButton.styleFrom(
                    minimumSize: const Size(34, 34),
                    backgroundColor: AppColors.surfaceHighest,
                  ),
                  icon: const Icon(Icons.edit_rounded, size: 17),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            displayName,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            anonymous ? 'Anonym aktiv' : 'Alias aktiv',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ProfileStat(value: '12', label: 'Abstimmungen'),
              _ProfileStat(value: '37', label: 'Kommentare'),
              _ProfileStat(value: '5', label: 'Abzeichen'),
            ],
          ),
          const SizedBox(height: 28),
          Text('Benutzername', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Dein Alias',
              filled: true,
              fillColor: AppColors.surfaceHigh.withValues(alpha: 0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: _saveName,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Änderungen lokal speichern'),
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
