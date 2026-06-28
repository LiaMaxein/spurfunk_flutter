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
    final reducedMotion = ref.watch(reducedMotionProvider);
    final highContrast = ref.watch(highContrastProvider);
    final largeText = ref.watch(largeTextProvider);

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
            title: 'Dunkles Design',
            value: darkMode,
            onChanged: (value) =>
                ref.read(darkModeEnabledProvider.notifier).setValue(value),
          ),
          _SwitchTile(
            icon: Icons.animation_outlined,
            title: 'Animationen reduzieren',
            value: reducedMotion,
            onChanged: (value) =>
                ref.read(reducedMotionProvider.notifier).setValue(value),
          ),
          _SwitchTile(
            icon: Icons.contrast_outlined,
            title: 'Erhöhter Kontrast',
            value: highContrast,
            onChanged: (value) =>
                ref.read(highContrastProvider.notifier).setValue(value),
          ),
          _SwitchTile(
            icon: Icons.text_fields_outlined,
            title: 'Größere Schrift',
            value: largeText,
            onChanged: (value) =>
                ref.read(largeTextProvider.notifier).setValue(value),
          ),
          _SettingsTile(
            icon: Icons.lock_outline_rounded,
            title: 'Datenschutz',
            onTap: () => context.go(AppRoutes.profileSettingsPrivacyPath),
          ),
          _SettingsTile(
            icon: Icons.info_outline_rounded,
            title: 'Über Spurfunk',
            onTap: () => context.go(AppRoutes.profileSettingsAboutPath),
          ),
          _SwitchTile(
            icon: Icons.subtitles_outlined,
            title: 'Untertitel standardmäßig aktiv',
            value: true,
            onChanged: (_) {},
          ),
          _SwitchTile(
            icon: Icons.volume_up_outlined,
            title: 'Sound-Effekte',
            value: true,
            onChanged: (_) {},
          ),
          const SizedBox(height: 14),
          Text('Daten & Speicher', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          _ActionTile(
            icon: Icons.download_outlined,
            title: 'Cache leeren',
            subtitle: '12.4 MB belegt',
            onTap: () {},
          ),
          _ActionTile(
            icon: Icons.delete_outline_rounded,
            title: 'Alle lokalen Daten löschen',
            subtitle: 'Einstellungen, Profil und Verlauf',
            onTap: () {},
          ),
          const SizedBox(height: 14),
          Text('Info', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          _InfoRow(label: 'App-Version', value: '1.0.0 (Build 42)'),
          const SizedBox(height: 6),
          _InfoRow(label: 'Umgebung', value: 'Prototyp (lokal)'),
          const SizedBox(height: 6),
          _InfoRow(label: 'Datenhaltung', value: 'Nur lokal · SharedPreferences'),
          const SizedBox(height: 18),
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
            'Alle Einstellungen werden nur lokal gespeichert. '
            'Es werden keine Daten an Server übermittelt.',
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

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        radius: 14,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 23),
            const SizedBox(width: 14),
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
            const Icon(Icons.chevron_right_rounded, color: Colors.white, size: 24),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(value, style: Theme.of(context).textTheme.labelLarge),
        ],
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
