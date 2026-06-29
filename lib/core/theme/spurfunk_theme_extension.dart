import 'package:flutter/material.dart';

class SpurfunkThemeExtension extends ThemeExtension<SpurfunkThemeExtension> {
  const SpurfunkThemeExtension({
    required this.accent,
    required this.highContrast,
    required this.chatDensityPadding,
    required this.largeTouchTargets,
  });

  final Color accent;
  final bool highContrast;
  final double chatDensityPadding;
  final bool largeTouchTargets;

  @override
  SpurfunkThemeExtension copyWith({
    Color? accent,
    bool? highContrast,
    double? chatDensityPadding,
    bool? largeTouchTargets,
  }) {
    return SpurfunkThemeExtension(
      accent: accent ?? this.accent,
      highContrast: highContrast ?? this.highContrast,
      chatDensityPadding: chatDensityPadding ?? this.chatDensityPadding,
      largeTouchTargets: largeTouchTargets ?? this.largeTouchTargets,
    );
  }

  @override
  SpurfunkThemeExtension lerp(
    covariant SpurfunkThemeExtension? other,
    double t,
  ) {
    if (other == null) return this;
    return SpurfunkThemeExtension(
      accent: Color.lerp(accent, other.accent, t) ?? accent,
      highContrast: t < 0.5 ? highContrast : other.highContrast,
      chatDensityPadding:
          chatDensityPadding + (other.chatDensityPadding - chatDensityPadding) * t,
      largeTouchTargets: t < 0.5 ? largeTouchTargets : other.largeTouchTargets,
    );
  }
}
