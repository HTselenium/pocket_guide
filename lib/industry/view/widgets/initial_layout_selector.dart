import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/industry/cubit/industry_type_hydrated_cubit.dart';
import 'package:pocket_guide/industry/industry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialLayoutSelector extends StatefulWidget {
  const InitialLayoutSelector({
    super.key,
    required this.industry,
  });

  final IndustryType industry;

  @override
  State<InitialLayoutSelector> createState() => _InitialLayoutSelectorState();
}

class _InitialLayoutSelectorState extends State<InitialLayoutSelector> {
  double alpha = 1, startPoint = 0;
  int currentType = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final size = MediaQuery.of(context).size;
    final initialLayoutHydratedCubit =
        context.read<InitialLayoutHydratedCubit>();
    return SizedBox(
      height: size.height * 0.6,
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          startPoint = details.globalPosition.dx;
        },
        onHorizontalDragUpdate: (details) {
          var calculatedAlpha = 1.0;
          if (widget.industry.index == 0) {
            //1st
            if (startPoint < details.globalPosition.dx) {
              calculatedAlpha = 1 - ((details.globalPosition.dx) / size.width);
            }
          } else {
            //2nd
            if (startPoint > details.globalPosition.dx) {
              calculatedAlpha = (details.globalPosition.dx) / size.width;
            }
          }
          setState(() {
            alpha = calculatedAlpha;
          });
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          setState(() {
            alpha = 1.0;
          });
          if (details.primaryVelocity! > 0) {
            // User swiped Left
            initialLayoutHydratedCubit.updateIndustryTypeIndex(1);
            context.read<InitialLayoutCubit>().toogleIndustryLayout(1);
          } else if (details.primaryVelocity! < 0) {
            initialLayoutHydratedCubit.updateIndustryTypeIndex(0);
            context.read<InitialLayoutCubit>().toogleIndustryLayout(0);
            // User swiped Right
          }
        },
        child: Stack(
          children: [
            InitialLayoutImage(
              image: widget.industry.image(),
              size: size,
              alpha: alpha,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      context
                          .read<InitialLayoutCubit>()
                          .setIndustryType(widget.industry);
                      final prefs = await SharedPreferences.getInstance();
                      if (widget.industry.index == 0) {
                        await prefs.setString(
                          'POCKET_GUIDE_INDUSTRY_TYPE',
                          'HOME_CARE',
                        );
                      } else if (widget.industry.index == 1) {
                        await prefs.setString(
                          'POCKET_GUIDE_INDUSTRY_TYPE',
                          'INDUSTRY',
                        );
                      }
                      initialLayoutHydratedCubit.updateButtonClickState();
                      if (mounted) {
                        context.go(AppRoutes.home.path);
                      }
                    },
                    child: Text(
                      l10n.selectIndustry,
                      style: TextStyle(
                        color: theme.primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  VerticalSpacer.mediumLarge(),
                  Text(
                    widget.industry.localeTitle(context),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ).padded(),
                  VerticalSpacer.xxxLarge(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
