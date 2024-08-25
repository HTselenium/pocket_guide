import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

class ProductsButton extends StatelessWidget {
  const ProductsButton({
    super.key,
    required this.colors,
    required this.child,
    this.width,
    this.onTap,
  });
  final List<Color> colors;
  final Widget child;
  final double? width;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const height = 145.0;

    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
          stops: const [0, 1],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: child.padded(AppTheme.defaultScreenPadding),
        ),
      ),
    );
  }
}
