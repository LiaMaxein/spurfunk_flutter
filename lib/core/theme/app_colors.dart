import 'package:flutter/material.dart';

abstract final class AppColors {
  static const black = Color(0xFF0A0A0A);
  static const surface = Color(0xFF1A1A1A);
  static const surfaceHigh = Color(0xFF242424);
  static const red = Color(0xFFE30613);
  static const redDark = Color(0xFFB0040F);
  static const orange = Color(0xFFFF9800);
  static const yellow = Color(0xFFFFC107);
  static const blue = Color(0xFF2196F3);
  static const green = Color(0xFF4CAF50);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFB3B3B3);
  static const textMuted = Color(0xFF7A7A7A);
  static const divider = Color(0xFF2A2A2A);

  // Compatibility aliases used across existing widgets
  static const midnight = surface;
  static const surfaceHighest = surfaceHigh;
  static const redSoft = Color(0xFFFF4050);
  static const greenSoft = Color(0xFF66E58F);

  static const voteSchlecht = Color(0xFFE30613);
  static const voteLangweilig = Color(0xFFFF9800);
  static const voteOkay = Color(0xFFFFC107);
  static const voteGut = Color(0xFF2196F3);
  static const voteMega = Color(0xFF4CAF50);
}
