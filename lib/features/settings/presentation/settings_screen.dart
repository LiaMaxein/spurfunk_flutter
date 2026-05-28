import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/widgets/cinematic_widgets.dart';
import '../../onboarding/application/onboarding_state.dart';
import '../application/settings_state.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsEnabledProvider);
    final darkMode = ref.watch(darkModeEnabledProvider);

    return CinematicPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScreenTopBar(title: 'Einstellungen'),
          const SizedBox(height: 18),
          _SwitchTile(
            icon: Icons.notifications_none_rounded,
            title: 'Benachrichtigungen',
            value: notifications,
            onChanged: (value) =>
                ref.read(notificationsEnabledProvider.notifier).setValue(value),
          ),
          _SwitchTile(
            icon: Icons.brightness_6_outlined,
            title: 'App-Design',
            value: darkMode,
            onChanged: (value) =>
                ref.read(darkModeEnabledProvider.notifier).setValue(value),
          ),
          _SettingsTile(
            icon: Icons.lock_outline_rounded,
            title: 'Datenschutz',
            onTap: () => context.go(AppRoutes.profileSettingsPrivacyPath),
          ),
          _SettingsTile(
            icon: Icons.info_outline_rounded,
            title: 'Über Tatort-Liebe',
            onTap: () => context.go(AppRoutes.profileSettingsAboutPath),
          ),
          const SizedBox(height: 14),
          FilledButton.icon(
            onPressed: () async {
              await ref.read(onboardingCompletedProvider.notifier).reset();
              if (context.mounted) context.go(AppRoutes.onboardingPath);
            },
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('Onboarding zurücksetzen'),
          ),
          const SizedBox(height: 22),
          Text(
            'Alle Einstellungen werden nur lokal gespeichert.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.title, this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        radius: 14,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 23),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        radius: 14,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 23),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Switch.adaptive(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
