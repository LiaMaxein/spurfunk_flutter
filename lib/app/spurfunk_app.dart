import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/router/app_router.dart';
import '../core/startup/app_startup_provider.dart';
import '../core/theme/app_theme.dart';
import '../features/settings/application/settings_state.dart';
import '../features/startup/presentation/splash_screen.dart';

class SpurfunkApp extends ConsumerWidget {
  const SpurfunkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bootstrap = ref.watch(appBootstrapProvider);
    final darkModeEnabled = ref.watch(darkModeEnabledProvider);

    return bootstrap.when(
      loading: () => MaterialApp(
        title: 'Spurfunk',
        debugShowCheckedModeBanner: false,
        themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: const SplashScreen(),
      ),
      error: (error, _) => MaterialApp(
        title: 'Spurfunk',
        debugShowCheckedModeBanner: false,
        themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: Scaffold(
          body: Center(child: Text('Start fehlgeschlagen: $error')),
        ),
      ),
      data: (_) {
        final router = ref.watch(appRouterProvider);
        return MaterialApp.router(
          title: 'Spurfunk',
          debugShowCheckedModeBanner: false,
          themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          routerConfig: router,
        );
      },
    );
  }
}
