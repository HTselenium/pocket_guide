import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

class InitialLayoutImage extends StatelessWidget {
  const InitialLayoutImage({
    super.key,
    required this.size,
    required this.image,
    required this.alpha,
  });

  final Size size;
  final AssetGenImage image;
  final double alpha;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _OvalTopBorderClipper(),
      child: Stack(
        children: [
          Opacity(
            opacity: alpha<0.4?0.4:alpha,
            child: image.image(
              width: double.maxFinite,
              height: size.height,
              fit: BoxFit.cover,
            ),
          ),

          Container(
            width: double.maxFinite,
            height: size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x2D000000),
                  Color(0x00000000),
                  Color(0xCC000000),
                ],
                stops: [0.0, 0.4, 0.9],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Clip widget in oval shape at top side
class _OvalTopBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, 0)
      ..lineTo(0, 10)
      ..quadraticBezierTo(size.width / 4, 0, size.width / 2, 0)
      ..quadraticBezierTo(size.width - size.width / 4, 0, size.width, 10)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
