import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.routeIndex,
  });

  final int routeIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final tiles = NavBarLayout.tiles;

    return Drawer(
      backgroundColor: AppTheme.darkPopup(theme),
      child: SafeArea(
        child: ListView(
          children: [
            VerticalSpacer.xSmall(),
            Row(
              children: [
                Assets.svgs.pocketGuideLogo.svg(
                  colorFilter:
                      ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                  height: 20,
                ),
                Expanded(
                  child: Text(
                    l10n.appName,
                    style: theme.textTheme.headlineMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ].joinWith(HorizontalSpacer.medium()),
            ),
            const Divider(),
            ...List.generate(
              tiles.length,
              (i) => _CustomTextButton(
                index: i,
                selectedIndex: routeIndex,
              ),
            ),
          ].joinWith(VerticalSpacer.large()),
        ).padded(AppTheme.defaultScreenPadding),
      ),
    );
  }
}

class _CustomTextButton extends StatelessWidget {
  const _CustomTextButton({required this.index, required this.selectedIndex});

  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;
    final theme = context.theme;
    final tiles = NavBarLayout.tiles;

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? null : Colors.grey.shade400,
      ),
      child: Container(
        padding: const EdgeInsets.only(left: Dimens.paddingMedium20),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            NotificationBadge(
              showNotificationBadge: tiles[index].route == AppRoutes.news,
              child: tiles[index].icon.svg(
                    colorFilter: ColorFilter.mode(
                      isSelected ? theme.primaryColor : Colors.grey.shade400,
                      BlendMode.srcIn,
                    ),
                  ),
            ),
            Text(
              tiles[index].route.localeTitle(context),
              style: TextStyle(
                color: isSelected ? null : AppTheme.darkTextColor(theme),
              ),
            ),
          ].joinWith(HorizontalSpacer.semi()),
        ),
      ),
      onPressed: () {
        context.go(tiles[index].route.path);
        Scaffold.of(context).closeEndDrawer();
      },
    );
  }
}
