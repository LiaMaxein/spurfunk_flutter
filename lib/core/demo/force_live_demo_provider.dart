import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../persistence/user_preferences.dart';

/// Forces the app into "Tatort läuft gerade" demo mode for UI testing.
final forceLiveDemoProvider = NotifierProvider<ForceLiveDemoNotifier, bool>(
  ForceLiveDemoNotifier.new,
);

class ForceLiveDemoNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).forceLiveDemo;

  Future<void> setValue(bool value) async {
    state = value;
    await ref.read(userPreferencesProvider).setForceLiveDemo(value);
  }
}
