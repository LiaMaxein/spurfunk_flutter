import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/persistence/user_preferences.dart';

final notificationsEnabledProvider =
    NotifierProvider<NotificationsEnabledNotifier, bool>(
      NotificationsEnabledNotifier.new,
    );

final darkModeEnabledProvider = NotifierProvider<DarkModeEnabledNotifier, bool>(
  DarkModeEnabledNotifier.new,
);

class NotificationsEnabledNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).notificationsEnabled;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setNotificationsEnabled(value);
  }
}

class DarkModeEnabledNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).darkModeEnabled;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setDarkModeEnabled(value);
  }
}
