import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/persistence/user_preferences.dart';
import '../../../core/router/router_refresh.dart';
import '../../../shared/mock_data/mock_data.dart';

class RoleAvatarPreset {
  const RoleAvatarPreset({
    required this.id,
    required this.name,
    required this.icon,
    required this.colors,
  });

  final String id;
  final String name;
  final IconData icon;
  final List<Color> colors;
}

List<RoleAvatarPreset> get avatarPresets => roleAvatarPresets
    .map(
      (r) => RoleAvatarPreset(
        id: r.id,
        name: r.name,
        icon: r.icon,
        colors: r.colors,
      ),
    )
    .toList();

final onboardingCompletedProvider =
    NotifierProvider<OnboardingCompletedNotifier, bool>(
      OnboardingCompletedNotifier.new,
    );

final selectedAvatarIdProvider =
    NotifierProvider<SelectedAvatarIdNotifier, String>(
      SelectedAvatarIdNotifier.new,
    );
final usernameProvider = NotifierProvider<UsernameNotifier, String>(
  UsernameNotifier.new,
);
final anonymousModeProvider = NotifierProvider<AnonymousModeNotifier, bool>(
  AnonymousModeNotifier.new,
);

class OnboardingCompletedNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).onboardingCompleted;

  Future<void> complete() async {
    await ref.read(userPreferencesProvider).setOnboardingCompleted(true);
    state = true;
    refreshAppRouterFromRef(ref);
  }

  Future<void> reset() async {
    await ref.read(userPreferencesProvider).setOnboardingCompleted(false);
    state = false;
    refreshAppRouterFromRef(ref);
  }
}

class SelectedAvatarIdNotifier extends Notifier<String> {
  @override
  String build() {
    final stored = ref.watch(userPreferencesProvider).avatarId;
    if (stored != null && avatarPresets.any((a) => a.id == stored)) {
      return stored;
    }
    return avatarPresets.first.id;
  }

  Future<void> select(String id) async {
    state = id;
    await ref.read(userPreferencesProvider).setAvatarId(id);
  }
}

class UsernameNotifier extends Notifier<String> {
  @override
  String build() => ref.watch(userPreferencesProvider).username;

  Future<void> update(String value) async {
    state = value;
    await ref.read(userPreferencesProvider).setUsername(value);
  }
}

class AnonymousModeNotifier extends Notifier<bool> {
  @override
  bool build() => ref.watch(userPreferencesProvider).anonymousMode;

  Future<void> setEnabled({required bool value}) async {
    state = value;
    await ref.read(userPreferencesProvider).setAnonymousMode(value);
  }
}

final selectedAvatarProvider = Provider<RoleAvatarPreset>((ref) {
  final selectedId = ref.watch(selectedAvatarIdProvider);
  return avatarPresets.firstWhere(
    (avatar) => avatar.id == selectedId,
    orElse: () => avatarPresets.first,
  );
});

final displayNameProvider = Provider<String>((ref) {
  final anonymous = ref.watch(anonymousModeProvider);
  final username = ref.watch(usernameProvider).trim();

  if (anonymous || username.isEmpty) {
    return 'Mitwisser';
  }

  return username;
});

final symbolicAvatarProvider = Provider((ref) {
  final roleId = ref.watch(selectedAvatarIdProvider);
  return symbolicAvatarForRole(roleId);
});
