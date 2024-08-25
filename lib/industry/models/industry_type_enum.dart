import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';

/// {@template app_products}
/// AppRoutes of the application
/// {@endtemplate}
enum IndustryType {
  homeCare(HomeCareLayout()),
  industrialForm(IndustrialFormulatorsLayout());

  /// {@macro app_products}
  const IndustryType(this.layout);

  /// Layout of the product
  final Widget layout;

  /// List of all products
  static List<IndustryType> get all => values;

  /// Gets the localization of a given product
  String localeTitle(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case IndustryType.homeCare:
        return l10n.homeCare;
      case IndustryType.industrialForm:
        return l10n.industrialForm;
    }
  }

  /// Gets the image of a given product
  AssetGenImage image() {
    switch (this) {
      case IndustryType.homeCare:
        return Assets.images.homeCare;
      case IndustryType.industrialForm:
        return Assets.images.industrial;
    }
  }
}
