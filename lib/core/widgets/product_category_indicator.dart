import 'package:flutter/cupertino.dart';

class ProductCategoryIndicator extends StatelessWidget {
  const ProductCategoryIndicator({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 33,
      child: Container(
        height: 25,
        width: 2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
