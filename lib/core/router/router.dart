import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/claim/claim.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/error/error.dart';
import 'package:pocket_guide/home/view/nav_bar_layout.dart';
import 'package:pocket_guide/industry/cubit/industry_type_hydrated_cubit.dart';
import 'package:pocket_guide/news/news.dart';
import 'package:pocket_guide/product_details/product_details.dart';
import 'package:pocket_guide/product_portfolio/product_portfolio.dart';
import 'package:pocket_guide/sustainability/sustainability.dart';

/// {@template app_router}
/// Router for the app
/// {@endtemplate}

/// {@macro app_router}
/// use this key to identify the route without bottom nav bar
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

/// use this key to identify the route within bottom nav bar
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  debugLogDiagnostics: true,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      redirect: (BuildContext context, GoRouterState state) =>
          context.read<InitialLayoutHydratedCubit>().state.buttonClickState
              ? AppRoutes.home.path
              : AppRoutes.welcome.path,
    ),
    AppRoutes.welcome.route(
      parentNavigatorKey: _rootNavigatorKey,
    ),
    AppRoutes.contact.route(
      parentNavigatorKey: _rootNavigatorKey,
    ),
    AppRoutes.dataPrivacy.route(
      parentNavigatorKey: _rootNavigatorKey,
    ),
    AppRoutes.termsOfUse.route(
      parentNavigatorKey: _rootNavigatorKey,
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return NavBarLayout(
          key: state.pageKey,
          child: child,
        );
      },
      routes: [
        AppRoutes.home.route(
          routes: [
            GoRoute(
              path: 'product-portfolio-home-care',
              builder: (context, state) {
                return const HomeCareProductPortfolioPage();
              },
              routes: [
                GoRoute(
                  path: 'product/:category/:id',
                  builder: (context, state) {
                    final p = state.params['id']!;
                    final c = state.params['category']!;
                    return HomeCareProductPortfolioChildPage(
                      key: state.pageKey,
                      id: p,
                      productPortfolioInfo:
                          state.extra! as Map<String, dynamic>,
                      category: int.parse(c),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: ':pid',
                      builder: (context, state) {
                        final p = state.params['pid']!;
                        final c = state.params['category']!;
                        return HomeCareProductPortfolioSubChildProductPage(
                          key: state.pageKey,
                          id: p,
                          portfolioChildInfo:
                              state.extra! as Map<String, dynamic>,
                          category: int.parse(c),
                        );
                      },
                      routes: [
                        GoRoute(
                          path: ':fid',
                          builder: (context, state) {
                            final f = state.params['fid']!;
                            final c = state.params['category']!;
                            return ProductDetailsPage(
                              key: state.pageKey,
                              id: f,
                              prd: state.extra! as String,
                              category: int.parse(c),
                            );
                          },
                          routes: [
                            GoRoute(
                              name: 'goToClaim',
                              path: ':cid/:prodName',
                              builder: (context, state) {
                                final cl = state.params['cid']!;
                                final prodName = state.params['prodName']!;
                                return ClaimGroupPage(
                                  key: state.pageKey,
                                  id: cl,
                                  claimsList: state.extra! as List,
                                  category: int.parse('4'),
                                  prodName: prodName,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: 'product-portfolio-industrial',
              builder: (context, state) {
                return const IndustrialProductPortfolioPage();
              },
              routes: [
                GoRoute(
                  path: 'product/:category/:id',
                  builder: (context, state) {
                    final p = state.params['id']!;
                    final c = state.params['category']!;
                    return IndustrialProductPortfolioChildPage(
                      key: state.pageKey,
                      id: p,
                      productPortfolioInfo:
                          state.extra! as Map<String, dynamic>,
                      category: int.parse(c),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: ':pid',
                      builder: (context, state) {
                        final p = state.params['pid']!;
                        final c = state.params['category']!;
                        return IndustrialProductPortfolioSubChild(
                          key: state.pageKey,
                          id: p,
                          portfolioChildInfo:
                              state.extra! as Map<String, dynamic>,
                          category: int.parse(c),
                        );
                      },
                      routes: [
                        GoRoute(
                          path: ':fid',
                          builder: (context, state) {
                            final f = state.params['fid']!;
                            final c = state.params['category']!;
                            return ProductDetailsPage(
                              key: state.pageKey,
                              id: f,
                              prd: state.extra! as String,
                              category: int.parse(c),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: 'sustainability-home-care',
              builder: (context, state) {
                return const SustainabilityHCPage();
              },
              routes: [
                GoRoute(
                  name: 'sustainabilityHomeCare',
                  path: ':id',
                  builder: (context, state) {
                    final p = state.params['id']!;
                    // TODO(someone): should we have dedicated page?
                    return HomeCareProductPortfolioSubChildProductPage(
                      key: state.pageKey,
                      id: p,
                      portfolioChildInfo: state.extra! as Map<String, dynamic>,
                      category: 5,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: ':fid',
                      builder: (context, state) {
                        final f = state.params['fid']!;
                        return ProductDetailsPage(
                          key: state.pageKey,
                          id: f,
                          prd: state.extra! as String,
                          category: 5,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: 'sustainability-industrial',
              builder: (context, state) {
                return const SustainabilityIndustrialPage();
              },
              routes: [
                GoRoute(
                  name: 'sustainabilityIndustrial',
                  path: ':id',
                  builder: (context, state) {
                    final p = state.params['id']!;
                    return IndustrialProductPortfolioSubChild(
                      key: state.pageKey,
                      id: p,
                      portfolioChildInfo: state.extra! as Map<String, dynamic>,
                      category: 5,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: ':fid',
                      builder: (context, state) {
                        final f = state.params['fid']!;
                        return ProductDetailsPage(
                          key: state.pageKey,
                          id: f,
                          prd: state.extra! as String,
                          category: 5,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            GoRoute(
              path: 'claims',
              builder: (context, state) {
                return const ClaimPage();
              },
              routes: [
                GoRoute(
                  path: 'subclaim/:id',
                  builder: (context, state) {
                    final p = state.params['id']!;
                    return SubClaimPage(
                      id: p,
                      key: state.pageKey,
                      applicationInfo: state.extra! as Map<String, dynamic>,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: ':fid',
                      builder: (context, state) {
                        final f = state.params['fid']!;
                        return ClaimsClaimPage(
                          key: state.pageKey,
                          id: f,
                          functionClaimInfo:
                              state.extra! as Map<String, dynamic>,
                        );
                      },
                      routes: [
                        GoRoute(
                          path: ':pid',
                          builder: (context, state) {
                            // TODO(someone): should have a dedicated page?
                            final f = state.params['pid']!;
                            return HomeCareProductPortfolioSubChildProductPage(
                              key: state.pageKey,
                              id: f,
                              portfolioChildInfo:
                                  state.extra! as Map<String, dynamic>,
                              category: 4,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        AppRoutes.askRediso.route(),
        AppRoutes.news.route(
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final p = state.params['id']!;
                return NewsDetailsPage(
                  key: state.pageKey,
                  id: p,
                  news: state.extra! as News,
                );
              },
            ),
          ],
        ),
        AppRoutes.favorites.route(
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final p = state.params['id']!;
                final c = state.params['category']!;
                return ProductDetailsPage(
                  key: state.pageKey,
                  id: p,
                  prd: state.extra! as String,
                  category: int.parse(c),
                );
              },
            ),
          ],
        ),
        AppRoutes.settings.route(),
      ],
    ),
  ],
  errorPageBuilder: (context, state) => MaterialPage(
    key: state.pageKey,
    child: ErrorPage(error: state.error),
  ), // All the logic is centralized here
);
