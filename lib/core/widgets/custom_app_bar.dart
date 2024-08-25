import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/favorites/favorites.dart';
import 'package:pocket_guide/search/custom_search_delegate.dart';

/// {@template custom_app_bar}
/// Custom App bar widget for product's widgets
/// {@endtemplate}
class CustomAppBar extends StatefulWidget {
  /// {@macro custom_app_bar}
  const CustomAppBar({
    super.key,
    required this.title,
    required this.leading,
    this.onPressed,
    this.isFirstList = true,
    this.hasFavourite = false,
    this.color,
    this.subtitle,
    this.prd,
    this.isNewsList = false,
  });

  ///  Retrieving page title/ product title
  final String title;

  ///   When true it return back button based dn design
  final bool leading;

  ///   When true it center the title without product number
  ///   and return thick back button, false will return app bar with shadow
  ///   and border, small title with product number, thin back button
  final bool? isFirstList;

  ///   When true it replace search icon to star
  final bool? hasFavourite;

  ///  Retrieving color indication of the product
  final Color? color;

  ///  return function of the icon button
  final void Function()? onPressed;

  ///  Retrieving product number
  final String? subtitle;

  /// Retrieving product id
  final String? prd;

  /// temp solution to hide search button
  final bool? isNewsList;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    if (widget.prd != null) {
      FaveSharedPreferences.checkFavByProductId(widget.prd!).then(
        (value) => {
          setState(() {
            isFav = value;
          }),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.theme.isDark;

    return SliverAppBar(
      collapsedHeight: 65,
      forceElevated: widget.isFirstList == false,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.2),
      shape: widget.isFirstList == false
          ? Border(
              bottom: BorderSide(color: widget.color!.withOpacity(0.2)),
            )
          : null,
      automaticallyImplyLeading: widget.leading,
      leading: widget.leading && widget.isFirstList == true
          ? backButton(
              Assets.icons.arrowBack.svg(
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white : const Color(AppTheme.blackColor),
                  BlendMode.srcIn,
                ),
              ),
            )
          : !widget.leading
              ? null
              : roundedRectangleBackButton(),
      title: widget.isFirstList == true
          ? Text(
              widget.title,
              style: theme.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.w700),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: theme.textTheme.titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Visibility(
                  visible: !widget.hasFavourite! && widget.subtitle != null,
                  child: Text(
                    '${widget.subtitle} products',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: widget.color),
                  ),
                ),
              ],
            ),
      centerTitle: widget.isFirstList,
      actions: [
        if (widget.isNewsList == true)
          const SizedBox()
        else if (widget.hasFavourite == false)
          searchButton()
        else
          favButton(),
      ],
    );
  }

  Widget backButton(Widget icon) {
    return Builder(
      builder: (context) {
        return IconButton(
          padding: const EdgeInsets.only(left: Dimens.paddingMediumLarge),
          icon: icon,
          onPressed: () => context.pop(),
        );
      },
    );
  }

  Widget favButton() {
    return Builder(
      builder: (context) {
        return IconButton(
          padding: const EdgeInsets.only(right: Dimens.paddingXLarge),
          icon: Assets.icons.star.svg(
            colorFilter: ColorFilter.mode(
              isFav == false ? Colors.grey : Colors.amber,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () {
            setState(
              () {
                if (isFav == false) {
                  isFav = true;
                  FaveSharedPreferences.setFave(
                    id: widget.prd!,
                    productName: widget.title,
                  );
                } else {
                  isFav = false;
                  FaveSharedPreferences.removeFav(
                    id: widget.prd!,
                    productName: widget.title,
                  );
                }
              },
            );
          },
        );
      },
    );
  }

  Widget searchButton() {
    return Builder(
      builder: (context) {
        final isDark = context.theme.isDark;
        return IconButton(
          padding: const EdgeInsets.only(right: Dimens.paddingXLarge),
          icon: widget.hasFavourite == false
              ? Assets.icons.search.svg(
                  colorFilter: ColorFilter.mode(
                    isDark ? Colors.white : const Color(AppTheme.blackColor),
                    BlendMode.srcIn,
                  ),
                )
              : Assets.icons.star.svg(
                  colorFilter: ColorFilter.mode(
                    isFav == false ? Colors.grey : Colors.amber,
                    BlendMode.srcIn,
                  ),
                ),
          onPressed: () {
            showSearch(
              context: context,
              // delegate to customize the search bar
              delegate: CustomSearchDelegate(),
            );
          },
        );
      },
    );
  }

  Widget roundedRectangleBackButton() {
    return Builder(
      builder: (context) {
        final isDark = context.theme.isDark;
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 40,
              width: 2,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            backButton(
              Assets.icons.arrowBackThin.svg(
                colorFilter: ColorFilter.mode(
                  isDark ? Colors.white : const Color(AppTheme.blackColor),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
