import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.routeIndex,
    required this.controller,
  });

  final int routeIndex;
  final AnimationController controller;

  @override
  // ignore: avoid_field_initializers_in_const_classes
  final Size preferredSize = const Size.fromHeight(150 /* kToolbarHeight */);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    const appBarHeight = 80.0;
    final tiles = NavBarLayout.tiles;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.only(left: Dimens.paddingXLarge),
            margin: EdgeInsets.only(
              right: isMobile(context) ? 0 : Dimens.paddingMedium,
              top: Dimens.paddingMedium,
            ),
            height: appBarHeight,
            color: Colors.grey.shade600,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go('/${tiles[0].route.path}'),
                  child: Text(
                    l10n.appName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const Spacer(),
                if (!isMobile(context))
                  Row(
                    children: List.generate(
                      tiles.length,
                      (i) => _CustomTextButton(
                        index: i,
                        selectedIndex: routeIndex,
                      ),
                    ),
                  ),
                if (isMobile(context))
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      // controller.forward();
                    },
                  ),
                // IconButton(
                //   icon: NotificationBadge(
                //     showNotificationBadge: true,
                //     child: AnimatedIcon(
                //       icon: AnimatedIcons.close_menu,
                //       color: Colors.white,
                //       progress: 1,
                //     ),
                //   ),
                //   onPressed: () => Scaffold.of(context).openEndDrawer(),
                // ),
              ],
            ),
          ),
        ),
        if (!isMobile(context))
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              height: appBarHeight,
              margin: const EdgeInsets.only(top: Dimens.paddingMedium),
              padding: const EdgeInsets.all(Dimens.paddingMedium),
              color: theme.primaryColor,
              child: Assets.svgs.basfLogo.svg(
                height: 50,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _CustomTextButton extends StatelessWidget {
  const _CustomTextButton({
    required this.index,
    required this.selectedIndex,
  });

  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    final tiles = NavBarLayout.tiles;

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.grey.shade400,
      ),
      child: NotificationBadge(
        showNotificationBadge: tiles[index].route == AppRoutes.news,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tiles[index].route.localeTitle(context),
              style: isSelected
                  ? null
                  : const TextStyle(fontWeight: FontWeight.normal),
            ),
            AnimatedOpacity(
              opacity: isSelected ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: AppTheme.defaultBorderRadius,
                  color: Colors.white,
                ),
                height: 2,
                width: 30,
              ),
            ),
          ],
        ),
      ),
      onPressed: () => context.go(tiles[index].route.path),
    );
  }
}
