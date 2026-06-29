import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/onboarding/application/onboarding_state.dart';
import '../../features/settings/application/settings_state.dart';

/// Brief splash while preferences hydrate Riverpod notifiers.
final appBootstrapProvider = FutureProvider<void>((ref) async {
  ref.read(onboardingCompletedProvider);
  ref.read(selectedAvatarIdProvider);
  ref.read(usernameProvider);
  ref.read(anonymousModeProvider);
  ref.read(profileGenderProvider);
  ref.read(notificationsEnabledProvider);
  ref.read(themeModeSettingProvider);
  ref.read(accentColorProvider);
  ref.read(fontSizeLevelProvider);
  ref.read(chatDensityProvider);
  ref.read(reducedMotionProvider);
  ref.read(highContrastProvider);
  ref.read(largeTextProvider);
  await Future<void>.delayed(const Duration(seconds: 5));
});
