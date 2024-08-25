import 'package:flutter/material.dart';
import 'package:pocket_guide/core/extensions/extensions.dart';
import 'package:pocket_guide/core/theme/theme.dart';

class SeparatorLine extends StatelessWidget {
  const SeparatorLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final isDark = context.theme.isDark;
        return Divider(
          color: isDark
              ? AppTheme.darkBlueSwatch.shade200
              : AppTheme.darkBlueSwatch.shade500,
        );
      },
    );
  }
}
