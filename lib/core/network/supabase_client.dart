import '../config/app_config.dart';

/// Placeholder for a future Supabase client. Not active in the local prototype.
class SupabaseClientHolder {
  const SupabaseClientHolder._();

  static bool get isConfigured {
    final config = AppConfig.current;
    return config.supabaseUrl != null &&
        config.supabaseAnonKey != null &&
        config.supabaseUrl!.isNotEmpty &&
        config.supabaseAnonKey!.isNotEmpty;
  }

  static Future<void> initialize() async {
    if (!isConfigured) return;
    // Future: Supabase.initialize(url: ..., anonKey: ...)
  }
}
