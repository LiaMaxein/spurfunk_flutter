import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cinematic_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CinematicPage(
      child: Column(
        children: [
          const ScreenTopBar(title: 'Einstellungen'),
          const SizedBox(height: 18),
          const _SettingsTile(
            icon: Icons.notifications_none_rounded,
            title: 'Benachrichtigungen',
          ),
          const _SettingsTile(
            icon: Icons.brightness_6_outlined,
            title: 'App-Design',
            value: 'Dunkel',
          ),
          const _SettingsTile(
            icon: Icons.lock_outline_rounded,
            title: 'Datenschutz',
          ),
          const _SettingsTile(
            icon: Icons.help_outline_rounded,
            title: 'Hilfe & FAQ',
          ),
          const _SettingsTile(
            icon: Icons.info_outline_rounded,
            title: 'Über Tatort-Liebe',
          ),
          const SizedBox(height: 22),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.logout_rounded, color: AppColors.redSoft),
            label: Text(
              'Abmelden',
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: AppColors.redSoft),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.title, this.value});

  final IconData icon;
  final String title;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
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
            if (value != null)
              Text(
                value!,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.white),
              ),
            const SizedBox(width: 8),
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
