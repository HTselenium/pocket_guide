import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';

class ProductPortfolioWidget extends StatelessWidget {
  const ProductPortfolioWidget({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const height = 145.0;

    return Stack(
      children: [
        ProductsButton(
          onTap: onTap,
          width: double.maxFinite,
          colors: const [
            Color(0xff142206),
            Color(0xFF29440F),
          ],
          child: Text(
            l10n.productPortfolio,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ).padded(AppTheme.defaultScreenPadding.copyWith(left: 0)),
        ),
        Container(
          alignment: Alignment.bottomRight,
          height: height,
          child: Assets.icons.roboticArm.svg(
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ).padded(),
      ],
    );
  }
}
