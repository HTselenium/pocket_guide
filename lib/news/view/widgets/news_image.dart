import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:shimmer/shimmer.dart';

class NewsImage extends StatelessWidget {
  const NewsImage({
    super.key,
    this.fit,
    this.height,
    this.width,
    required this.imageUrl,
  });

  final BoxFit? fit;
  final double? height;
  final double? width;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      height: height,
      width: width,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;

        return Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.white,
          child: child,
        );
      },
      errorBuilder: (context, error, stackTrace) => Center(
        child: Container(
          height: height,
          padding: const EdgeInsets.all(Dimens.paddingMediumLarge),
          child: Assets.images.unkownPage.image(fit: fit),
        ),
      ),
    );
  }
}
