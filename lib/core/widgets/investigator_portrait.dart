import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class InvestigatorPortrait extends StatelessWidget {
  const InvestigatorPortrait({
    required this.assetPath,
    this.size = 72,
    super.key,
  });

  final String assetPath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => ColoredBox(
            color: AppColors.surfaceHigh,
            child: Icon(Icons.person, size: size * 0.5, color: AppColors.textMuted),
          ),
        ),
      ),
    );
  }
}
