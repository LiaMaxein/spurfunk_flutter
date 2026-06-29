import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/settings_models.dart';
import '../application/settings_state.dart';
import 'widgets/settings_widgets.dart';

class NotificationsSettingsScreen extends ConsumerWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final master = ref.watch(notificationsEnabledProvider);

    return SettingsScaffold(
      title: 'BENACHRICHTIGUNGEN',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsSwitchRow(
            icon: Icons.notifications_active_outlined,
            title: 'Benachrichtigungen aktiv',
            subtitle: 'Master-Schalter für alle Push- und E-Mail-Hinweise',
            value: master,
            onChanged: (value) =>
                ref.read(notificationsEnabledProvider.notifier).setValue(value),
          ),
          const SizedBox(height: 8),
          for (final pref in NotificationPreference.values)
            _NotificationToggle(preference: pref),
        ],
      ),
    );
  }
}

class _NotificationToggle extends ConsumerWidget {
  const _NotificationToggle({required this.preference});

  final NotificationPreference preference;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(notificationPreferencesProvider);

    return SettingsSwitchRow(
      icon: Icons.circle_outlined,
      title: preference.label,
      value: prefs[preference.key] ?? true,
      onChanged: (next) => ref
          .read(notificationPreferencesProvider.notifier)
          .setValue(preference.key, next),
    );
  }
}
