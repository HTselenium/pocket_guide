import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';
import 'package:pocket_guide/industry/industry.dart';

class HomeCareLayout extends StatelessWidget {
  const HomeCareLayout({super.key});

  static const industryType = IndustryType.homeCare;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: Column(
            children: [
              VerticalSpacer.small(),
              ProductPortfolioWidget(
                onTap: () =>
                    context.go(AppRoutes.productPortfolioHomeCare.path),
              ),
              Row(
                children: [
                  Expanded(
                    child: SustainabilityWidget(
                      onTap: () =>
                          context.push(AppRoutes.sustainabilityHomeCare.path),
                    ),
                  ),
                  Expanded(
                    child: ClaimsWidget(
                      onTap: () => context.push(AppRoutes.claims.path),
                    ),
                  ),
                ].joinWith(HorizontalSpacer.large()),
              ),
              AskRedisoWidget(
                onTap: () => context.push(AppRoutes.askRediso.path),
              ),
              VerticalSpacer.xxLarge(),
            ].joinWith(VerticalSpacer.large()),
          ).padded(
            const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium),
          ),
        ),
      ),
    );
  }
}
