import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

class HomeCareBlobBackground extends StatelessWidget {
  const HomeCareBlobBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.theme.isDark;
    return Stack(
      children: [
        Positioned(
          top: size.height * 0.08,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Assets.svgs.blob1.svg(
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
          top: size.height * 0.08,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Assets.svgs.blob2.svg(
                colorFilter: ColorFilter.mode(
                  const Color(0xffE0EED2).withOpacity(0.2),
                  BlendMode.srcIn,
                ),
              );
            },
          ),
        ),
        Positioned(
          top: size.height * 0.25,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Assets.svgs.blob3.svg(
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
