import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

class DetailsTitle extends StatelessWidget {
  const DetailsTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppTheme.darkTextColor(theme),
      ),
    );
  }
}
