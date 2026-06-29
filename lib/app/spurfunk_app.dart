import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/router/app_router.dart';
import '../core/startup/app_startup_provider.dart';
import '../core/theme/app_theme.dart';
import '../features/settings/application/settings_models.dart';
import '../features/settings/application/settings_state.dart';
import '../features/startup/presentation/splash_screen.dart';

class SpurfunkApp extends ConsumerWidget {
  const SpurfunkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(appBootstrapProvider);
    final themeMode = ref.watch(themeModeSettingProvider).themeMode;
    final accent = ref.watch(accentColorProvider);
    final highContrast = ref.watch(highContrastProvider);
    final chatDensity = ref.watch(chatDensityProvider);
    final largeTouchTargets = ref.watch(largeTouchTargetsProvider);
    final textScale = ref.watch(effectiveTextScaleProvider);
    final reducedMotion = ref.watch(reducedMotionProvider);

    final chatPadding =
        chatDensity == AppChatDensity.compact ? 8.0 : 14.0;

    final darkTheme = AppTheme.dark(
      accent: accent.color,
      highContrast: highContrast,
      chatDensityPadding: chatPadding,
      largeTouchTargets: largeTouchTargets,
    );
    final lightTheme = AppTheme.light(
      accent: accent.color,
      highContrast: highContrast,
      chatDensityPadding: chatPadding,
      largeTouchTargets: largeTouchTargets,
    );

    Widget wrapAccessibility(BuildContext context, Widget? child) {
      if (child == null) return const SizedBox.shrink();
      var data = MediaQuery.of(context);
      data = data.copyWith(
        textScaler: TextScaler.linear(textScale),
        disableAnimations: reducedMotion,
        boldText: highContrast,
      );
      return MediaQuery(data: data, child: child);
    }

    return bootstrap.when(
      loading: () => MaterialApp(
        title: 'Spurfunk',
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        builder: wrapAccessibility,
        home: const SplashScreen(),
      ),
      error: (error, _) => MaterialApp(
        title: 'Spurfunk',
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        builder: wrapAccessibility,
        home: Scaffold(
          body: Center(child: Text('Start fehlgeschlagen: $error')),
        ),
      ),
      data: (_) {
        final router = ref.watch(appRouterProvider);
        return MaterialApp.router(
          title: 'Spurfunk',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          builder: wrapAccessibility,
          routerConfig: router,
        );
      },
    );
  }
}
