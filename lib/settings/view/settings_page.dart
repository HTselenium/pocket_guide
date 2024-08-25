import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final isDark = theme.brightness == Brightness.dark;
    final textStyle = theme.textTheme.headlineSmall!.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    );

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          actions: const [SizedBox.shrink()],
          systemOverlayStyle: isDark ? null : SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          title: Text(l10n.generalSettings),
          centerTitle: true,
          collapsedHeight: 160,
          flexibleSpace: FlexibleSpaceBar(
            background: GradientBlobBackground(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Assets.images.basf
                          .image(color: isDark ? Colors.white : null),
                    ),
                    VerticalSpacer.small(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pocket Guide',
                        style: TextStyle(
                            fontSize: 42, color: isDark ? null : Colors.black,),
                      ),
                    ),
                    //const Spacer(),
                  ],
                ).padded(
                  const EdgeInsets.symmetric(
                    horizontal: Dimens.paddingMedium20,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ColoredBox(
            color: AppTheme.darkPopup(theme) ?? Colors.white,
            child: Column(
              children: [
                const ThemeSelector().padded(
                  const EdgeInsets.symmetric(
                      vertical: Dimens.paddingMediumLarge,),
                ),
                const Divider(color: Colors.grey),
                ...List.generate(AppRoutes.legalPages.length, (index) {
                  final route = AppRoutes.legalPages[index];

                  return _CustomLegalTextButton(
                    route: route,
                    textStyle: textStyle,
                  );
                }),
                // const LogoutButton(),
              ],
            ).padded(),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              VerticalSpacer.large(),
              Assets.images.basfOutlinedLogo
                  .image(width: 100, color: theme.primaryColor),
              const AppVersion(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CustomLegalTextButton extends StatelessWidget {
  const _CustomLegalTextButton({
    required this.route,
    required this.textStyle,
  });

  final AppRoutes route;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            child: Text(
              route.localeTitle(context),
              style: textStyle,
            ),
            onPressed: () => context.push(route.path),
          ),
        ),
      ],
    );
  }
}
