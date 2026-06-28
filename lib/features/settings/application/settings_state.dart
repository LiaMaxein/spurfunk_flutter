import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/persistence/user_preferences.dart';

final notificationsEnabledProvider =
    NotifierProvider<NotificationsEnabledNotifier, bool>(
      NotificationsEnabledNotifier.new,
    );

final darkModeEnabledProvider = NotifierProvider<DarkModeEnabledNotifier, bool>(
  DarkModeEnabledNotifier.new,
);

final reducedMotionProvider = NotifierProvider<ReducedMotionNotifier, bool>(
  ReducedMotionNotifier.new,
);

final highContrastProvider = NotifierProvider<HighContrastNotifier, bool>(
  HighContrastNotifier.new,
);

final largeTextProvider = NotifierProvider<LargeTextNotifier, bool>(
  LargeTextNotifier.new,
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

class ReducedMotionNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).reducedMotion;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setReducedMotion(value);
  }
}

class HighContrastNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).highContrast;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setHighContrast(value);
  }
}

class LargeTextNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).largeText;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setLargeText(value);
  }
}
