import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';

class SustainabilityWidget extends StatelessWidget {
  const SustainabilityWidget({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const color = Color(0xff518A18);
    final l10n = context.l10n;

    return ProductsButton(
      onTap: onTap,
      colors: [
        const Color(0xffC1DEA5).lighten(40),
        const Color(0xffC1DEA5).darken(),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            alignment: Alignment.topLeft,
            child: Text(
              l10n.sustainability,
              style: const TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
            ),
          ).padded(
            const EdgeInsets.only(
              top: Dimens.paddingSemi,
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Assets.icons.leaf.svg(
              height: 53,
              colorFilter: const ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
