import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pocket_guide/core/core.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error, this.onRetry});

  final dynamic error;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final message =
        error.toString().replaceAll('Exception:', '').trim().toCapitalized();

    return GradientBlobBackground(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Assets.images.noInternet.image(),
              Text(
                l10n.weHaveALittleProblem,
                style: theme.textTheme.headlineSmall,
              ),
              VerticalSpacer.mediumSmall(),
              Container(
                margin: AppTheme.defaultScreenPadding,
                padding: const EdgeInsets.all(Dimens.paddingDefault),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade100,
                  borderRadius: AppTheme.defaultBorderRadius,
                ),
                child: Text(
                  error is NoInternetException ? 'No Internet' : message,
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              if (onRetry != null)
                retryButton()
              else
                ElevatedButton.icon(
                  label: Text(
                    l10n.generalHome,
                    style: const TextStyle(
                      color: Color(AppTheme.lightGreenColor),
                    ),
                  ),
                  icon: Assets.icons.longArrowBack.svg(
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Color(AppTheme.lightGreenColor),
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () => context.go(AppRoutes.welcome.path),
                ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ],
    );
  }

  Widget retryButton() {
    return Builder(
      builder: (context) {
        final retryingNotifier = ValueNotifier<bool>(false);

        return ValueListenableBuilder<bool>(
          valueListenable: retryingNotifier,
          builder: (context, isRetrying, _) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: ElevatedButton.icon(
                key: isRetrying
                    ? const ValueKey('retry')
                    : const ValueKey('retrying'),
                icon: Assets.icons.refresh.svg(
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(AppTheme.lightGreenColor),
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () => retry(retryingNotifier),
                label: const Text(
                  'Retry',
                  style: TextStyle(
                    color: Color(AppTheme.lightGreenColor),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void retry(ValueNotifier<bool> retryingNotifier) {
    if (onRetry != null) {
      retryingNotifier.value = true;

      Future.delayed(Duration.zero, () => onRetry!());
    }
  }
}
