import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/claim/claim.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/favorites/favorites.dart';
import 'package:pocket_guide/home/home.dart';
import 'package:pocket_guide/industry/view/initial_layout_page.dart';
import 'package:pocket_guide/legal/legal.dart';
import 'package:pocket_guide/news/news.dart';
import 'package:pocket_guide/product_portfolio/product_portfolio.dart';
import 'package:pocket_guide/rediso/rediso.dart';
import 'package:pocket_guide/settings/settings.dart';
import 'package:pocket_guide/sustainability/sustainability.dart';

/// {@template app_routes}
/// AppRoutes of the application
/// {@endtemplate}
enum AppRoutes {
  welcome('/welcome', InitialLayout()),
  home('/home', HomePage()),
  askRediso('/home/ask-rediso', AskRedisoPage()),
  news('/news', NewsPage()),
  favorites('/favorites', FavoritesPage()),
  settings('/settings', SettingsPage()),
  claims('/home/claims', ClaimPage()),
  sustainabilityHomeCare(
    '/home/sustainability-home-care',
    SustainabilityHCPage(),
  ),
  sustainabilityIndustrial(
    '/home/sustainability-industrial',
    SustainabilityIndustrialPage(),
  ),

  // ProductPortfolio
  productPortfolioHomeCare(
    '/home/product-portfolio-home-care',
    HomeCareProductPortfolioPage(),
  ),
  productPortfolioIndustrial(
    '/home/product-portfolio-industrial',
    IndustrialProductPortfolioPage(),
  ),

  // Legal pages
  contact('/contact', ContactPage()),
  dataPrivacy('/data-privacy', DataPrivacyPage()),
  termsOfUse('/terms-of-use', TermsOfUsePage());

  /// {@macro app_routes}
  const AppRoutes(this.path, this.view);

  /// List of all legal pages
  static List<AppRoutes> get legalPages => [contact, dataPrivacy, termsOfUse];

  /// Path of the route
  /// Used to navigate as
  /// ```dart
  /// context.go(AppRoutes.home.path)
  /// context.push(AppRoutes.home.path)
  /// ```
  final String path;

  /// Layout of the route
  final Widget view;

  /// List of all routes
  static List<AppRoutes> get all => values;

  /// Generates a GoRoute with a MaterialPage
  /// This can be used for easy routes
  GoRoute route({
    List<GoRoute>? routes,
    String? Function(BuildContext context, GoRouterState)? redirect,
    GlobalKey<NavigatorState>? parentNavigatorKey,

  }) =>
      GoRoute(
        path: path,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: view,
        ),
        routes: routes ?? [],
        redirect: redirect ?? (_, __) => null,
        parentNavigatorKey: parentNavigatorKey,
      );

  /// Gets the localization of a given route
  String localeTitle(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case AppRoutes.welcome:
        return l10n.generalWelcome;
      case AppRoutes.home:
        return l10n.generalHome;
      case AppRoutes.askRediso:
        return l10n.askRediso;
      case AppRoutes.news:
        return l10n.generalNews;
      case AppRoutes.favorites:
        return l10n.generalFavorites;
      case AppRoutes.settings:
        return l10n.generalSettings;
      case AppRoutes.contact:
        return l10n.contact;
      case AppRoutes.dataPrivacy:
        return l10n.dataPrivacy;
      case AppRoutes.termsOfUse:
        return l10n.termsOfUse;
      case AppRoutes.sustainabilityHomeCare:
        return l10n.sustainability;
      case AppRoutes.sustainabilityIndustrial:
        return l10n.sustainability;
      case AppRoutes.productPortfolioHomeCare:
        return l10n.productPortfolio;
      case AppRoutes.productPortfolioIndustrial:
        return l10n.productPortfolio;
      case AppRoutes.claims:
        return l10n.claims;
    }
  }
}
