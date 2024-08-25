import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

/// Tipically used in a stack
class BlobBackground extends StatelessWidget {
  const BlobBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = context.theme;

    return Stack(
      children: [
        Positioned(
          top: size.height * 0.05,
          left: size.width * 0.1,
          child: Blob.animatedRandom(
            size: size.height * 0.6,
            duration: const Duration(seconds: 5),
            styles: BlobStyles(
              gradient: LinearGradient(
                colors: [
                  const Color(0x0fffffff).withOpacity(0.2),
                  if (theme.isDark)
                    Colors.grey.withOpacity(0.15)
                  else
                    theme.primaryColor.withOpacity(0.05),
                ],
              ).createShader(const Rect.fromLTRB(0, 0, 300, 300)),
            ),
            loop: true,
          ),
        ),
        Positioned(
          top: size.height * 0.15,
          left: -100,
          child: Blob.animatedRandom(
            size: size.height * 0.55,
            duration: const Duration(seconds: 5),
            styles: BlobStyles(
              gradient: LinearGradient(
                colors: [
                  if (theme.isDark)
                    Colors.grey.withOpacity(0.15)
                  else
                    theme.primaryColor.withOpacity(0.12),
                  const Color(0x0fffffff).withOpacity(0.33),
                ],
              ).createShader(const Rect.fromLTRB(0, 0, 300, 300)),
            ),
            loop: true,
          ),
        ),
        Positioned(
          top: size.height * 0.15,
          right: 100,
          child: Blob.animatedRandom(
            size: size.height * 0.4,
            duration: const Duration(seconds: 5),
            styles: BlobStyles(
              gradient: LinearGradient(
                colors: [
                  if (theme.isDark)
                    Colors.grey.withOpacity(0.15)
                  else
                    theme.primaryColor.withOpacity(0.2),
                  const Color(0x0fffffff).withOpacity(0.2),
                ],
              ).createShader(const Rect.fromLTRB(0, 0, 300, 300)),
            ),
            loop: true,
          ),
        ),
      ],
    );
  }
}
