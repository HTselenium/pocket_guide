import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/home/home.dart';
import 'package:pocket_guide/industry/cubit/industry_type_hydrated_cubit.dart';
import 'package:pocket_guide/industry/industry.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final initialLayoutHydratedCubit =
        context.read<InitialLayoutHydratedCubit>();
    return Stack(
      children: [
        if (IndustryType
                .all[initialLayoutHydratedCubit.state.industryTypeIndex].index <
            1)
          const HomeCareBlobBackground()
        else
          const IndustrialBlobBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: appBar(),
          ),
          body: IndustryType
              .all[initialLayoutHydratedCubit.state.industryTypeIndex].layout,
        ),
      ],
    );
  }

  Widget appBar() {
    return Builder(
      builder: (context) {
        final theme = context.theme;

        final initialLayoutHydratedCubit =
            context.read<InitialLayoutHydratedCubit>();
        return AppBar(
          systemOverlayStyle: theme.isDark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      IndustryType.all[initialLayoutHydratedCubit
                              .state.industryTypeIndex]
                          .localeTitle(context),
                      maxLines: 2,
                      style: theme.textTheme.headlineSmall!
                          .copyWith(fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                IconButton(
                  icon: Assets.icons.industry.svg(
                    colorFilter: ColorFilter.mode(
                      theme.isDark
                          ? Colors.white
                          : const Color(AppTheme.blackColor),
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () => {
                    context.go(AppRoutes.welcome.path),
                    initialLayoutHydratedCubit.updateButtonClickState(),
                  },
                ),
              ],
            ).padded(
              const EdgeInsets.only(
                right: Dimens.paddingMediumLarge,
                left: Dimens.paddingXLarge,
                top: Dimens.paddingXXLarge,
              ),
            ),
            collapseMode: CollapseMode.none,
          ),
        );
      },
    );
  }
}
