import 'package:flutter/material.dart';
import 'package:pocket_guide/core/theme/theme.dart';

enum ProductCategory {
  categoryDarkBlue(Color(AppTheme.darkBlueColor)),
  categoryLightBlue(Color(AppTheme.lightBlueColor)),
  categoryGreen(Color(AppTheme.greenColor)),
  categoryRed(Color(AppTheme.redColor)),
  categoryOrange(Color(AppTheme.orangeColor)),
  categoryLightGreen(Color(AppTheme.lightGreenColor));

  const ProductCategory(this.color);

  final Color color;

  /// List of all categories
  static List<ProductCategory> get all => values;
}
