import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({
    super.key,
    required this.routeIndex,
    required this.onItemTapped,
  });

  final int routeIndex;
  final void Function(int) onItemTapped;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final backgroundColor = theme.bottomNavigationBarTheme.backgroundColor;
    final tiles = NavBarLayout.tiles;

    // When a bottomNavigation bar has more than or equal to 4 items
    // the used background color defaults to the one used in the items
    // that's why we have to set that up manually
    return BottomNavigationBar(
      elevation: 8,
      // landscapeLayout: ?,
      backgroundColor: backgroundColor,
      currentIndex: routeIndex,
      items: List.generate(
        tiles.length,
        (i) => BottomNavigationBarItem(
          backgroundColor: backgroundColor,
          icon: NotificationBadge(
            showNotificationBadge: tiles[i].route == AppRoutes.news,
            child: tiles[i].icon.svg(
                  colorFilter: ColorFilter.mode(
                    i == routeIndex
                        ? const Color(AppTheme.lightGreenColor)
                        : Colors.grey.shade400,
                    BlendMode.srcIn,
                  ),
                ),
          ),
          label: tiles[i].route.localeTitle(context),
        ),
      ),
      onTap: onItemTapped,
    );
  }
}
