import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

enum NewsCategory {
  categoryOne(Color(AppTheme.primaryColor)),
  categoryTwo(Colors.white),
  categoryThree(Colors.white),
  categoryFour(Colors.red),
  categoryFive(Colors.white);

  const NewsCategory(this.color);

  final Color color;

  /// List of all categories
  static List<NewsCategory> get all => values;

  /// Gets the localization of a given route
  String localeTitle(BuildContext context) {
    // final l10n = context.l10n;

    // TODO(carlos): Get the categories and update this, and l10n
    switch (this) {
      case categoryOne:
        return 'Category';
      case categoryTwo:
        return 'Lorem';
      case categoryThree:
        return 'Dolor Sit';
      case categoryFour:
        return 'Amet';
      case categoryFive:
        return 'Blaeb';
    }
  }
}
