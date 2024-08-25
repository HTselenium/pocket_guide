import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/product_details/product_details.dart';

/// {@template custom_favourite_list}
/// Custom favourite list widget for product portfolio, sustainability & claims
/// {@endtemplate}
class CustomFavouriteListWidget extends StatefulWidget {
  /// {@macro custom_favourite_list}
  const CustomFavouriteListWidget({
    super.key,
    required this.category,
    required this.isFavourite,
    required this.productName,
  });

  /// Retrieving color indication of the ProductCategory
  final ProductCategory category;

  /// Marks wether or not the current product is favourite
  /// enable favourite with yellow star for `true` and grey for `false`
  final bool isFavourite;

  /// Product name value retrieved from db/api
  final String productName;

  @override
  State<CustomFavouriteListWidget> createState() =>
      _CustomFavouriteListWidgetState();
}

class _CustomFavouriteListWidgetState extends State<CustomFavouriteListWidget> {
  @override
  Widget build(BuildContext context) {
    final color = widget.category.color == Colors.white
        ? Colors.grey
        : widget.category.color;
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: AppTheme.defaultBorderRadius,
            border: Border.all(
              color: color.withOpacity(0.2),
            ),
          ),
          child: ListTile(
            title: Text(
              widget.productName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: IconButton(
              icon: Assets.icons.search.svg(),
              onPressed: () {},
            ),
            // TODO(cj): set state
          ),
        ),
      ],
    );
  }
}
