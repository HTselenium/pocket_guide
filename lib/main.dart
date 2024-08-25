import 'dart:async';
import 'dart:developer';

import 'package:contentful/client.dart' as contentful;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocket_guide/app.dart';
import 'package:pocket_guide/contentful/auth_contentful.dart';
import 'package:pocket_guide/core/core.dart';
import 'package:pocket_guide/core/data/data_injection.dart';
import 'package:pocket_guide/core/utils/one_trust.dart';
import 'package:pocket_guide/dependency_injection.dart';
import 'package:pocket_guide/error/view/error_page.dart';
import 'package:pocket_guide/get_it_service.dart';

void main() => _bootstrap(() {
      //Register get it service
      GetItService.registerAppServices();
      return const App();
    });

// TODO(someone): Do what's listed below
// Deep linking -> Update web/.well-known/assetlinks.json -> sha256_cert_fingerprints (GUIDE)[https://o-ifeanyi.hashnode.dev/deep-linking-in-flutter-part-2]
// Analytics
// Crashlytics
// Notifications

/// Prepares the app with some settings
Future<void> _bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError =
      (details) => log(details.exceptionAsString(), stackTrace: details.stack);

  Bloc.observer = AppBlocObserver();

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Error widget for prod mode, so they don't see the grey screen
      if (Environment.env.toLowerCase() == 'prod') {
        ErrorWidget.builder = (FlutterErrorDetails details) => ErrorPage(
              error: Exception(details.exception),
            );
      }

      // Set up oneTrust
      await _setupOneTrust();

      // Set url mode
      usePathUrlStrategy();

      await _setupHydratedBloc(await builder());
      await _setupHive();
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}

/// set up Hive
Future<void> _setupHive() async {
  await Hive.initFlutter();
  final _hiveDataInjection = HiveDataInjection();
  await _hiveDataInjection.dataInjection();
}

Future<void> _setupOneTrust() async {
  // One trust implementation
  // final oneTrust = OneTrust(
  //   otAppId: Environment.otAppId,
  //   logChanges: Environment.debug,
  //   sdks: [
  //     Sdk(
  //       categoryId: performanceSdkCatId,
  //       changeSdkStatus: (status) async {
  //         // Turn off SDK's depending on state
  //         // ! await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(status);
  //         // ! await PianoAnalytics.instance.setStatus(status);
  //
  //         // Delete unuset reports from Crashlytics if it's disabled
  //         if (status == false) {
  //           // FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled
  //           // 'Deleted Crashlytics reports'.log();
  //           // ! await FirebaseCrashlytics.instance.deleteUnsentReports();
  //         }
  //         '[$performanceSdkCatId] status: $status'.log();
  //       },
  //     ),
  //   ],
  // );

  await initOneTrust(
    domainIdentifier: Environment.otAppId,
    sdks: [
      Sdk(
        categoryId: 'C0002',
        changeSdkStatus: (status) async {
          // Turn off SDK's depending on state
          // await FirebaseCrashlytics.instance
          //     .setCrashlyticsCollectionEnabled(status);

          // Delete unuset reports from Crashlytics if it's disabled
          // if (status == false) {
          // FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled
          // log('Deleted Crashlytics reports');
          // await FirebaseCrashlytics.instance.deleteUnsentReports();
          // }
          log('Crashlytics status: $status');
        },
      ),
    ],
  );
}

/// Sets up the hydrated storage for the app and passes over root providers
Future<void> _setupHydratedBloc(Widget child) async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  ///request contentful
  final contentfulClient = contentful.Client(
    AuthenticatingContentfulHTTPClient(accessToken: Environment.cmsApiKey),
    spaceId: Environment.cmsSpaceId,
    environment: Environment.cmsEnv,
  );

  Bloc.observer = AppBlocObserver(
    showOnClose: false,
    showOnTransition: false,
    showOnEvent: false,
  );

  return runApp(
    RepositoryProviders(
      cmsClient: contentfulClient,
      child: child,
    ),
  );
}
