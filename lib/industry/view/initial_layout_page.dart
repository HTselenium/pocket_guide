import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/industry/cubit/industry_type_cubit.dart';
import 'package:pocket_guide/industry/cubit/industry_type_hydrated_cubit.dart';
import 'package:pocket_guide/industry/models/industry_type_enum.dart';
import 'package:pocket_guide/industry/view/widgets/dotted_line.dart';
import 'package:pocket_guide/industry/view/widgets/initial_layout_selector.dart';

class InitialLayout extends StatelessWidget {
  const InitialLayout({super.key});
  @override
  Widget build(BuildContext context) {
    final initialLayoutHydratedCubit =
        context.read<InitialLayoutHydratedCubit>();

    return Theme(
      data: AppTheme.lightTheme,
      child: GradientBlobBackground(
        theme: AppTheme.lightTheme,
        children: [
          Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: Colors.transparent,
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            body: BlocBuilder<InitialLayoutCubit, IndustryType>(
              builder: (context, industry) {
                return Column(
                  children: [
                    const Spacer(),
                    const AppTitle().padded(),
                    const Spacer(),
                    Stack(
                      children: [
                        InitialLayoutSelector(
                          industry: IndustryType.all[initialLayoutHydratedCubit
                              .state.industryTypeIndex],
                        ).padded(const EdgeInsets.only(top: 50)),
                        DottedLine(
                          industryType: IndustryType.all[
                              initialLayoutHydratedCubit
                                  .state.industryTypeIndex],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
