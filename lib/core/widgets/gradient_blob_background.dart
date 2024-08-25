import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

/// A sacked view
class GradientBlobBackground extends StatelessWidget {
  const GradientBlobBackground({
    super.key,
    required this.children,
    this.theme,
  });

  final List<Widget> children;
  final ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    final currentTheme = context.theme;

    return DecoratedBox(
      decoration:
          BoxDecoration(gradient: AppTheme.appGradient(theme ?? currentTheme)),
      child: Stack(
        children: [const BlobBackground(), ...children],
      ),
    );
  }
}
