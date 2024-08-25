import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/favorites/favorites.dart';
import 'package:pocket_guide/product_details/product_details.dart';

/// {@template custom_list}
/// Custom list widget for product portfolio, sustainability & claims
/// {@endtemplate}
class CustomListTile extends StatefulWidget {
  /// {@macro custom_list}
  const CustomListTile({
    super.key,
    required this.category,
    required this.id,
    required this.isSubProduct,
    required this.isFavourite,
    required this.onPressed,
    required this.productName,
    this.productNum,
  });

  ///  Retrieving color indication of the ProductCategory
  final ProductCategory category;

  ///  Retrieving item's index
  final String id;

  ///  When true it removes product num and InkWell
  final bool isSubProduct;

  /// Marks wether or not the current product is favourite
  /// enable favourite with yellow star for `true` and grey for `false`
  final bool isFavourite;

  /// Callback executed when pressing the icon button
  final void Function() onPressed;

  /// Product name value retrieved from db/api
  final String productName;

  /// Product num value retrieved from db/api
  final String? productNum;

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool isSaved = false;

  Future<dynamic> _checkFav(String id) async {
    isSaved = await FaveSharedPreferences.checkFavByProductId(id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final color = widget.category.color;
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: color.withOpacity(0.2),
            ),
          ),
          // ignore: sort_child_properties_last
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: Dimens.paddingMedium),
            title: Text(
              widget.productName,
              style: theme.textTheme.titleMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            subtitle: !widget.isSubProduct && widget.productNum != null
                ? Text(
                    '${widget.productNum} products',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: color),
                  )
                : null,
            trailing: !widget.isFavourite
                ? IconButton(
                    padding: EdgeInsets.zero,
                    icon: Assets.icons.arrowForwardThin.svg(
                      colorFilter: ColorFilter.mode(
                        context.theme.isDark
                            ? Colors.white
                            : const Color(AppTheme.blackColor),
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: widget.onPressed,
                  )
                : FutureBuilder(
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<dynamic> snapshot,
                    ) {
                      return IconButton(
                        icon: Assets.icons.star.svg(
                          colorFilter: ColorFilter.mode(
                            isSaved == false ? Colors.grey : Colors.amber,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if (isSaved == false) {
                              isSaved = true;
                              FaveSharedPreferences.setFave(
                                id: widget.id,
                                productName: widget.productName,
                              );
                            } else {
                              isSaved = false;
                              FaveSharedPreferences.removeFav(
                                id: widget.id,
                                productName: widget.productName,
                              );
                            }
                          });
                        },
                      );
                    },
                    future: _checkFav(widget.id),
                  ),
            onTap: widget.onPressed,
          ),
        ),
        Visibility(
          visible: !widget.isSubProduct,
          child: ProductCategoryIndicator(color: color),
        ),
      ],
    ).padded(
      const EdgeInsets.only(
        left: Dimens.paddingMedium20,
        right: Dimens.paddingMedium20,
        top: Dimens.paddingMedium,
      ),
    );
  }
}
