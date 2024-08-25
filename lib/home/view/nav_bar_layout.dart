import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/view/widgets/home_app_bar.dart';
import 'package:pocket_guide/home/view/widgets/home_bottom_navigation_bar.dart';
import 'package:pocket_guide/home/view/widgets/home_drawer.dart';
import 'package:pocket_guide/home/view/widgets/home_navigation_rail.dart';

class HomeTile {
  const HomeTile({
    required this.icon,
    required this.route,
  });

  final SvgGenImage icon;
  final AppRoutes route;
}

class NavBarLayout extends HookWidget {
  const NavBarLayout({super.key, required this.child});

  final Widget child;

  /// List of the home pages available
  static final tiles = [
    HomeTile(
      icon: Assets.icons.home,
      route: AppRoutes.home,
    ),
    HomeTile(
      icon: Assets.icons.news,
      route: AppRoutes.news,
    ),
    HomeTile(
      icon: Assets.icons.star,
      route: AppRoutes.favorites,
    ),
    HomeTile(
      icon: Assets.icons.gear,
      route: AppRoutes.settings,
    ),
  ];

  /*
  Current implementation
  ╭─────────────────┬────────────┬──────────┬──────────────╮
  │       \  SIZES  │            │          │              │
  │        \        │   > 1024   │   1024   │   600        │
  │ DEVICE  \       │            │          │              │
  ├─────────────────┼╸╸╸╸╸╸╸╸╸╸╸╸┼╸╸╸╸╸╸╸╸╸╸┼╸╸╸╸╸╸╸╸╸╸╸╸╸╸┤
  │      kIsWeb     ╎    AppBar  ╎  AppBar  ╎ EndDrawer    |
  ├─────────────────┼╸╸╸╸╸╸╸╸╸╸╸╸┼╸╸╸╸╸╸╸╸╸╸┼╸╸╸╸╸╸╸╸╸╸╸╸╸╸┤
  │      device     ╎   NavRail  ╎  NavRail ╎ BottomNavBar |
  ╰─────────────────┴────────────┴──────────┴──────────────╯
  */
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 250),
      initialValue: 1,
    );

    return Scaffold(
      // AppBar on Web | AppBar will have two behaivours depending on width
      // Links for sizes greater than 600 or Drawer for the rest
      appBar: kIsWeb
          ? HomeAppBar(routeIndex: routeIndex(context), controller: controller)
          : null,

      // EndDrawer on Web if size is <= 600
      endDrawer: kIsWeb && isMobile(context)
          ? HomeDrawer(routeIndex: routeIndex(context))
          : null,

      onEndDrawerChanged: (onDrawerChanged) {
        // onDrawerChanged is called on changes in drawer direction
        // true - gesture that the Drawer is being opened
        // false - gesture that the Drawer is being closed
        onDrawerChanged ? controller.reverse() : controller.forward();
      },
      body: Row(
        children: [
          if (!kIsWeb && !isMobile(context))
            HomeNavigationRail(
              routeIndex: routeIndex(context),
            ),
          Expanded(child: child),
        ],
      ),
      // BottomNavBar on devices if size is <= 600
      bottomNavigationBar: kIsWeb || isTablet(context)
          ? null
          : HomeBottomNavigationBar(
              routeIndex: routeIndex(context),
              onItemTapped: (index) {
                onItemTapped(index, context);
              },
            ),
    );
  }

  static int routeIndex(BuildContext context) {
    final route = GoRouter.of(context);
    final location = route.location;
    if (location.startsWith(AppRoutes.home.path)) {
      return 0;
    }
    if (location.startsWith(AppRoutes.news.path)) {
      return 1;
    }
    if (location.startsWith(AppRoutes.favorites.path)) {
      return 2;
    }
    if (location.startsWith(AppRoutes.settings.path)) {
      return 3;
    }
    return 0;
  }

  void onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(AppRoutes.home.path);
        break;
      case 1:
        GoRouter.of(context).go(AppRoutes.news.path);
        break;
      case 2:
        GoRouter.of(context).go(AppRoutes.favorites.path);
        break;
      case 3:
        GoRouter.of(context).go(AppRoutes.settings.path);
        break;
    }
  }
}
