import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';

class HomeNavigationRail extends StatelessWidget {
  const HomeNavigationRail({
    super.key,
    required this.routeIndex,
  });

  final int routeIndex;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final tiles = NavBarLayout.tiles;
    return NavigationRail(
      leading: Assets.svgs.pocketGuideLogo
          .svg(
            colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
            height: 20,
          )
          .padded(const EdgeInsets.only(top: Dimens.paddingXLarge)),
      backgroundColor: AppTheme.darkBackground(theme),
      selectedIndex: routeIndex,
      destinations: List.generate(
        tiles.length,
        (i) => NavigationRailDestination(
          icon: NotificationBadge(
            showNotificationBadge: tiles[i].route == AppRoutes.news,
            child: tiles[i].icon.svg(
                  colorFilter: ColorFilter.mode(
                    routeIndex == i ? theme.primaryColor : Colors.grey.shade400,
                    BlendMode.srcIn,
                  ),
                ),
          ),
          label: Text(
            tiles[routeIndex].route.localeTitle(context),
            style: TextStyle(color: AppTheme.darkTextColor(theme)),
          ),
        ),
      ),
      onDestinationSelected: (index) => context.go(tiles[index].route.path),
    );
  }
}
