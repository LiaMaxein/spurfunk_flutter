import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'spurfunk_theme_extension.dart';

abstract final class AppTheme {
  static TextTheme _buildTextTheme(
    TextTheme base, {
    required bool highContrast,
  }) {
    final primary = highContrast ? Colors.white : AppColors.textPrimary;
    final secondary = highContrast ? Colors.white70 : AppColors.textSecondary;

    return base.copyWith(
      headlineLarge: GoogleFonts.bebasNeue(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        color: primary,
        letterSpacing: 1.2,
      ),
      headlineMedium: GoogleFonts.bebasNeue(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: primary,
        letterSpacing: 1,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primary,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: secondary,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondary,
      ),
      labelLarge: GoogleFonts.bebasNeue(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.red,
        letterSpacing: 1.4,
      ),
    );
  }

  static ThemeData build({
    required Brightness brightness,
    required Color accent,
    required bool highContrast,
    required double chatDensityPadding,
    required bool largeTouchTargets,
  }) {
    final isDark = brightness == Brightness.dark;
    final scaffold = highContrast
        ? Colors.black
        : (isDark ? AppColors.black : const Color(0xFFF4F4F4));
    final surface = highContrast
        ? const Color(0xFF111111)
        : (isDark ? AppColors.surface : Colors.white);
    final divider = highContrast ? Colors.white24 : AppColors.divider;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: brightness,
      surface: surface,
      primary: accent,
    );

    final textTheme = _buildTextTheme(
      isDark ? ThemeData.dark().textTheme : ThemeData.light().textTheme,
      highContrast: highContrast,
    );

    final chatPadding = chatDensityPadding;
    final minButtonHeight = largeTouchTargets ? 56.0 : 48.0;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: scaffold,
      colorScheme: colorScheme,
      textTheme: textTheme,
      extensions: [
        SpurfunkThemeExtension(
          accent: accent,
          highContrast: highContrast,
          chatDensityPadding: chatPadding,
          largeTouchTargets: largeTouchTargets,
        ),
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: isDark || highContrast
            ? AppColors.textPrimary
            : Colors.black87,
        centerTitle: false,
        elevation: 0,
        titleTextStyle: GoogleFonts.bebasNeue(
          fontSize: 22,
          color: isDark || highContrast ? AppColors.textPrimary : Colors.black87,
          letterSpacing: 1,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          minimumSize: Size.fromHeight(minButtonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(color: divider),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? AppColors.surface : Colors.white,
        hintStyle: GoogleFonts.inter(color: AppColors.textMuted),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: accent, width: 1.5),
        ),
      ),
    );
  }

  static ThemeData dark({
    Color accent = AppColors.red,
    bool highContrast = false,
    double chatDensityPadding = 14,
    bool largeTouchTargets = false,
  }) =>
      build(
        brightness: Brightness.dark,
        accent: accent,
        highContrast: highContrast,
        chatDensityPadding: chatDensityPadding,
        largeTouchTargets: largeTouchTargets,
      );

  static ThemeData light({
    Color accent = AppColors.red,
    bool highContrast = false,
    double chatDensityPadding = 14,
    bool largeTouchTargets = false,
  }) =>
      build(
        brightness: Brightness.light,
        accent: accent,
        highContrast: highContrast,
        chatDensityPadding: chatDensityPadding,
        largeTouchTargets: largeTouchTargets,
      );
}
