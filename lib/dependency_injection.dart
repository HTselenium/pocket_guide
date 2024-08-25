import 'dart:developer';

import 'package:contentful/client.dart' as contentful;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_guide/home/home.dart';
import 'package:pocket_guide/industry/cubit/industry_type_hydrated_cubit.dart';
import 'package:pocket_guide/industry/industry.dart';
import 'package:pocket_guide/news/news.dart';
import 'package:pocket_guide/settings/settings.dart';

/// {@template bloc_providers}
/// Place to add all the blocs being provided at root
/// {@endtemplate}
class BlocProviders extends MultiBlocProvider {
  /// {@macro bloc_providers}
  BlocProviders({
    super.key,
    required super.child,
  }) : super(
          providers: [
            BlocProvider<SettingsCubit>(
              lazy: false,
              create: (context) => SettingsCubit(),
            ),
            BlocProvider<InitialLayoutCubit>(
              create: (context) => InitialLayoutCubit(),
            ),
            BlocProvider<BadgeNotificationsCubit>(
              create: (context) => BadgeNotificationsCubit(),
            ),
            BlocProvider<InitialLayoutHydratedCubit>(
              create: (context) => InitialLayoutHydratedCubit(),
            ),
          ],
        );
}

/// {@template repo_providers}
/// Place to add all the repo providers being provided at root
/// {@endtemplate}
class RepositoryProviders extends MultiRepositoryProvider {
  /// {@macro repo_providers}
  RepositoryProviders({
    super.key,
    required Widget child,
    required contentful.Client cmsClient,
  }) : super(
          providers: [
            RepositoryProvider<NewsProviderRepository>(
              create: (context) => NewsProviderRepository(cmsClient: cmsClient),
            ),
          ],
          child: BlocProviders(child: child),
        );
}

/// {@template app_bloc_observer}
/// Bloc observer used to track bloc changes trough the app
/// {@endtemplate}
class AppBlocObserver extends BlocObserver {
  /// {@macro app_bloc_observer}
  AppBlocObserver({
    this.showOnCreate = true,
    this.showOnEvent = true,
    this.showOnChange = true,
    this.showOnTransition = true,
    this.showOnError = true,
    this.showOnClose = true,
  });

  /// Wheter to show OnCreate events on the log
  final bool showOnCreate;

  /// Wheter to show OnEvent events on the log
  final bool showOnEvent;

  /// Wheter to show OnChange events on the log
  final bool showOnChange;

  /// Wheter to show OnTransition events on the log
  final bool showOnTransition;

  /// Wheter to show OnError events on the log
  final bool showOnError;

  /// Wheter to show OnError events on the log
  final bool showOnClose;

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (showOnCreate) log('onCreate(${bloc.runtimeType})');
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (showOnEvent) log('onEvent(${bloc.runtimeType}, $event)');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (showOnChange) log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    if (showOnTransition) log('onTransition(${bloc.runtimeType}, $transition)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    if (showOnError) super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (showOnClose) log('onClose(${bloc.runtimeType})');
  }
}
