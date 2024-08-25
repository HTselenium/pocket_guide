import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';

class ClaimsWidget extends StatelessWidget {
  const ClaimsWidget({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return ProductsButton(
      onTap: onTap,
      colors: const [
        Color(0xff3D6712),
        Color(0xFF4B7B1C),
      ],
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: FittedBox(
              child: Text(
                l10n.claims,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ).padded(
              const EdgeInsets.only(top: Dimens.paddingSemi),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Assets.icons.longArrowBack.svg(
              height: 53,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
