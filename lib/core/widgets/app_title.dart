import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.theme.isDark;

    return Column(
      children: [
        //const Spacer(),
        Align(
          alignment: Alignment.centerLeft,
          child: Assets.images.basf.image(color: isDark ? Colors.white : null),
        ),
        VerticalSpacer.small(),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Pocket Guide',
            style: TextStyle(fontSize: 42, color: isDark ? null : Colors.black),
          ),
        ),
        //const Spacer(),
      ],
    );
  }
}
