import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';
import 'package:pocket_guide/industry/industry.dart';

class IndustrialFormulatorsLayout extends StatelessWidget {
  const IndustrialFormulatorsLayout({super.key});

  static const industryType = IndustryType.industrialForm;

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
                    context.push(AppRoutes.productPortfolioIndustrial.path),
              ),
              SustainabilityWidget(
                onTap: () =>
                    context.push(AppRoutes.sustainabilityIndustrial.path),
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
