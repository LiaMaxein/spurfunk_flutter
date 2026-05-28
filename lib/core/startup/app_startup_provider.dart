import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/onboarding/application/onboarding_state.dart';

/// Brief splash while preferences hydrate Riverpod notifiers.
final appBootstrapProvider = FutureProvider<void>((ref) async {
  ref.read(onboardingCompletedProvider);
  ref.read(selectedAvatarIdProvider);
  ref.read(usernameProvider);
  ref.read(anonymousModeProvider);
  await Future<void>.delayed(const Duration(milliseconds: 520));
});
