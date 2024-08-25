import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

class SearchEmptyPage extends StatelessWidget {
  const SearchEmptyPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return GradientBlobBackground(
      children: [
        Center(
          child: Text(
            'There are no relevant items in the portfolio.\n'
            'Please rephrase your search.',
            style: theme.textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
