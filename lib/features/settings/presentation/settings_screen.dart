import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/demo/force_live_demo_provider.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/application/home_notifier.dart';
import '../../live_episode/application/live_notifier.dart';
import '../application/settings_state.dart';
import 'widgets/settings_widgets.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forceLiveDemo = ref.watch(forceLiveDemoProvider);

    return SettingsScaffold(
      title: 'EINSTELLUNGEN',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsNavRow(
            icon: Icons.notifications_none_rounded,
            title: 'Benachrichtigungen',
            onTap: () => context.push(AppRoutes.profileSettingsNotificationsPath),
          ),
          SettingsNavRow(
            icon: Icons.palette_outlined,
            title: 'App-Design',
            onTap: () => context.push(AppRoutes.profileSettingsDesignPath),
          ),
          SettingsNavRow(
            icon: Icons.person_outline,
            title: 'Profil & Identität',
            onTap: () => context.push(AppRoutes.profileSettingsProfilePath),
          ),
          SettingsNavRow(
            icon: Icons.lock_outline_rounded,
            title: 'Datenschutz',
            onTap: () => context.push(AppRoutes.profileSettingsPrivacyPath),
          ),
          SettingsNavRow(
            icon: Icons.accessibility_new_rounded,
            title: 'Barrierefreiheit',
            onTap: () =>
                context.push(AppRoutes.profileSettingsAccessibilityPath),
          ),
          SettingsNavRow(
            icon: Icons.help_outline_rounded,
            title: 'Hilfe & FAQ',
            onTap: () => context.push(AppRoutes.profileSettingsHelpPath),
          ),
          SettingsNavRow(
            icon: Icons.info_outline_rounded,
            title: 'Über Spurfunk',
            onTap: () => context.push(AppRoutes.profileSettingsAboutPath),
          ),
          const SizedBox(height: 16),
          const SettingsSectionTitle(title: 'Demo & Entwicklung'),
          SettingsSwitchRow(
            icon: Icons.sensors,
            title: 'Tatort läuft gerade (Demo)',
            subtitle:
                'Simuliert den Live-Modus auf Home und im Live-Bereich für 24 Stunden',
            value: forceLiveDemo,
            onChanged: (value) async {
              await ref.read(forceLiveDemoProvider.notifier).setValue(value);
              ref.invalidate(homeNotifierProvider);
              ref.invalidate(liveNotifierProvider);
            },
          ),
          const SizedBox(height: 16),
          const SettingsSectionTitle(title: 'Daten & Speicher'),
          SettingsNavRow(
            icon: Icons.download_outlined,
            title: 'Cache leeren',
            subtitle: '12,4 MB belegt (Prototyp)',
            onTap: () => _confirmCacheClear(context, ref),
          ),
          SettingsNavRow(
            icon: Icons.delete_outline_rounded,
            title: 'Alle lokalen Daten löschen',
            subtitle: 'Einstellungen, Profil und Verlauf',
            onTap: () => _confirmClearAll(context, ref),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed: () => _confirmLogout(context, ref),
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Abmelden'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'App-Version 1.0.0 (Build 1)',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Text(
            'Umgebung: Prototyp (lokal)',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Abmelden?'),
        content: const Text(
          'Dein Profil wird lokal zurückgesetzt und du kehrst zum Onboarding zurück.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Abmelden'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await logoutUser(ref, GoRouter.of(context));
    }
  }

  Future<void> _confirmCacheClear(BuildContext context, WidgetRef ref) async {
    await clearCache(ref);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cache geleert.')),
      );
    }
  }

  Future<void> _confirmClearAll(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alle Daten löschen?'),
        content: const Text(
          'Diese Aktion entfernt alle lokal gespeicherten Daten unwiderruflich.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Abbrechen'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Löschen'),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await clearAllLocalData(ref, GoRouter.of(context));
    }
  }
}
