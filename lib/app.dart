import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/settings/cubit/settings_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  static final _appRouter = router;

  @override
  Widget build(BuildContext context) {
    // Handles in app reviews
    _inAppRequest(context);

    return MaterialApp.router(
      title: 'Pocket Guide',
      debugShowCheckedModeBanner: Environment.debug,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.select((SettingsCubit c) => c.state.themeMode),
      locale: context.select((SettingsCubit c) => c.state.language.locale),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationProvider: _appRouter.routeInformationProvider,
      routerDelegate: _appRouter.routerDelegate,
      routeInformationParser: _appRouter.routeInformationParser,
      builder: (BuildContext context, Widget? child) {
        return child!;
      },
    );
  }

  void _inAppRequest(BuildContext context) {
    // Adds a new login to the app
    final cubit = context.read<SettingsCubit>()..updateLogins();

    // Handles wethever the user has already reviewed the app or not
    if (!kIsWeb &&
        cubit.state.reviewRequested == false &&
        cubit.state.loginTimes % 15 == 0) {
      // We ask for a review if we are not in web
      // the user has not already requested a review
      // and the ammount of reviews is a multiple of 15

      // TODO(cj): implement app review
      // AppReview.requestReview.then((value) {
      //   value?.log();
      //
      //   // We set the review requested to true so we don't ask again
      //   cubit.updateReviewRequested();
      // }).onError((error, stackTrace) {
      //   // We log the errors
      //   'Error requesting review: $error [$stackTrace]'.log();
      // });
    }
  }
}
