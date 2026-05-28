import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifies [GoRouter] when redirect rules may have changed (e.g. onboarding done).
final routerRefreshProvider = Provider<ValueNotifier<int>>((ref) {
  final notifier = ValueNotifier(0);
  ref.onDispose(notifier.dispose);
  return notifier;
});

void refreshAppRouter(WidgetRef ref) {
  ref.read(routerRefreshProvider).value++;
}

void refreshAppRouterFromRef(Ref ref) {
  ref.read(routerRefreshProvider).value++;
}
