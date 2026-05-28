import 'package:flutter/material.dart';

import 'responsive_breakpoints.dart';

class ResponsivePage extends StatelessWidget {
  const ResponsivePage({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth >= ResponsiveBreakpoints.expanded
            ? 1120.0
            : constraints.maxWidth >= ResponsiveBreakpoints.medium
            ? 920.0
            : double.infinity;

        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: SafeArea(
              child: SingleChildScrollView(padding: padding, child: child),
            ),
          ),
        );
      },
    );
  }
}
