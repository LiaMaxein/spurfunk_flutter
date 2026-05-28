import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/persistence/user_preferences.dart';
import '../../../core/router/router_refresh.dart';
import '../../../core/theme/app_colors.dart';

class TatortAvatarPreset {
  const TatortAvatarPreset({
    required this.id,
    required this.name,
    required this.role,
    required this.icon,
    required this.colors,
  });

  final String id;
  final String name;
  final String role;
  final IconData icon;
  final List<Color> colors;
}

const avatarPresets = [
  TatortAvatarPreset(
    id: 'kommissarin',
    name: 'Die Kommissarin',
    role: 'Analytisch · ruhig · messerscharf',
    icon: Icons.manage_search_rounded,
    colors: [AppColors.red, AppColors.redDark],
  ),
  TatortAvatarPreset(
    id: 'profiler',
    name: 'Der Profiler',
    role: 'True-Crime-Instinkt mit Herz',
    icon: Icons.psychology_alt_rounded,
    colors: [Color(0xFF6B4BCE), Color(0xFF241B55)],
  ),
  TatortAvatarPreset(
    id: 'spurensicherung',
    name: 'Spurensicherung',
    role: 'Sieht Details, die andere verpassen',
    icon: Icons.fingerprint_rounded,
    colors: [Color(0xFF1F8AAE), Color(0xFF082E47)],
  ),
  TatortAvatarPreset(
    id: 'nachtfalke',
    name: 'Nachtfalke',
    role: 'Noir-Vibes, leise Beobachtung',
    icon: Icons.visibility_rounded,
    colors: [Color(0xFF293241), Color(0xFF070B12)],
  ),
  TatortAvatarPreset(
    id: 'herzzeuge',
    name: 'Herzzeuge',
    role: 'Emotional, loyal, immer live dabei',
    icon: Icons.favorite_rounded,
    colors: [AppColors.redSoft, Color(0xFF5D0B22)],
  ),
  TatortAvatarPreset(
    id: 'aktenkind',
    name: 'Aktenkind',
    role: 'Verspielt, neugierig, spoilerfrei',
    icon: Icons.folder_special_rounded,
    colors: [AppColors.orange, Color(0xFF4B2108)],
  ),
];

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

final selectedAvatarProvider = Provider<TatortAvatarPreset>((ref) {
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
    return 'TatortFan_22';
  }

  return username;
});
