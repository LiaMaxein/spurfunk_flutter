import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../persistence/user_preferences.dart';

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    final dark = ref.watch(userPreferencesProvider).darkModeEnabled;
    return dark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> setDarkMode(bool value) async {
    await ref.read(userPreferencesProvider).setDarkModeEnabled(value);
    state = value ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggle() async {
    final newValue = state == ThemeMode.dark;
    await setDarkMode(newValue);
  }
}
