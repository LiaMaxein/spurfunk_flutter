enum AppEnvironment {
  local,
  staging,
  production,
}

/// Runtime configuration for mock vs. remote backends.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.useMockRepositories,
    this.supabaseUrl,
    this.supabaseAnonKey,
  });

  final AppEnvironment environment;
  final bool useMockRepositories;
  final String? supabaseUrl;
  final String? supabaseAnonKey;

  static const current = AppConfig(
    environment: AppEnvironment.local,
    useMockRepositories: true,
    supabaseUrl: null,
    supabaseAnonKey: null,
  );

  bool get isProduction => environment == AppEnvironment.production;
}
