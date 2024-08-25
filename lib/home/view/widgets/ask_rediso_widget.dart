import 'package:flutter/material.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';

class AskRedisoWidget extends StatelessWidget {
  const AskRedisoWidget({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    const color = Color(0xff3D6712);
    const height = 145.0;

    return Stack(
      children: [
        ProductsButton(
          width: double.maxFinite,
          colors: const [
            Color(0xFF8CA970),
            Color(0xffB2D68E),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.needSomeHelp,
                style: const TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  padding: AppTheme.defaultScreenPadding,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: onTap,
                child: Text(
                  l10n.askRediso,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ), //.padded(AppTheme.defaultScreenPadding),
        ),
        Container(
          alignment: Alignment.bottomRight,
          height: height,
          child: Assets.images.redisoSupport.image(height: 100),
        ).padded(),
      ],
    );
  }
}
