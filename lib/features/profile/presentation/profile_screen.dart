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
          const SizedBox(height: 28),
          Text('Aktivität', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          _ActivityRow(
            icon: Icons.how_to_vote_rounded,
            label: 'Abgestimmt bei "Haupt der Medusa"',
            subtitle: 'vor 2 Tagen',
          ),
          const SizedBox(height: 8),
          _ActivityRow(
            icon: Icons.forum_rounded,
            label: 'Kommentiert in der Community',
            subtitle: 'vor 3 Tagen',
          ),
          const SizedBox(height: 8),
          _ActivityRow(
            icon: Icons.emoji_events_rounded,
            label: 'Abzeichen "Top-Kommentator" erhalten',
            subtitle: 'vor 5 Tagen',
          ),
          const SizedBox(height: 28),
          Text('Lieblingsfolgen', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          const _FavoriteEpisodeCard(
            title: 'Borowski und das Haupt der Medusa',
            subtitle: 'ARD · 20:15 Uhr',
          ),
          const SizedBox(height: 8),
          const _FavoriteEpisodeCard(
            title: 'Tatort: Die Nacht der Kommissare',
            subtitle: 'WDR · Wiederholung',
          ),
          const SizedBox(height: 8),
          const _FavoriteEpisodeCard(
            title: 'München: Die letzte Zeugin',
            subtitle: 'BR · 21:45 Uhr',
          ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({
    required this.icon,
    required this.label,
    required this.subtitle,
  });

  final IconData icon;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      radius: 14,
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.redSoft),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteEpisodeCard extends StatelessWidget {
  const _FavoriteEpisodeCard({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      radius: 14,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.red.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.favorite_rounded, color: AppColors.redSoft, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
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
