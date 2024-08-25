import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

class IndustrialBlobBackground extends StatelessWidget {
  const IndustrialBlobBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.theme.isDark;
    return Stack(
      children: [
        Positioned(
          top: size.height * 0.05,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Assets.svgs.blob5.svg(
                colorFilter: ColorFilter.mode(
                  const Color(0xffE0EED2).withOpacity(0.2),
                  BlendMode.srcIn,
                ),
              );
            },
          ),
        ),
        Positioned(
          top: size.height * 0.1,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Assets.svgs.blob4.svg(
                colorFilter: ColorFilter.mode(
                  isDark
                      ? const Color(0xffE0EED2).withOpacity(0.2)
                      : const Color(0xffE0EED2).withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              );
            },
          ),
        ),
        Positioned(
          top: size.height * 0.14,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Assets.svgs.blob6.svg(
                colorFilter: ColorFilter.mode(
                  isDark
                      ? const Color(0xffE0EED2).withOpacity(0.2)
                      : const Color(0xffE0EED2).withOpacity(0.5),
                  BlendMode.srcIn,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
