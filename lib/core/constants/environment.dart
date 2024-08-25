import 'dart:io';

import 'package:flutter/foundation.dart';

/// Environment variables defined for the project
abstract class Environment {
  /// Which env are we currently at
  static const String env = String.fromEnvironment('FLAVOR');

  /// Wether or not debuf is active
  static final bool debug = env.toLowerCase() == 'dev';

  /// Current build number
  static const String buildNumber = String.fromEnvironment('BUILD_NUMBER');

  /// One Trust AppId
  static String get otAppId {
    return kIsWeb
        ? const String.fromEnvironment('OT_WEB')
        : Platform.isIOS
            ? const String.fromEnvironment('OT_IOS')
            : const String.fromEnvironment('OT_ANDROID');
  }

  /// Contentful API
  static const String cmsApiKey = String.fromEnvironment('CMS_API_KEY');
  static const String cmsSpaceId =
      String.fromEnvironment('CMS_SPACE_ID', defaultValue: 'xoy1bnr8lcgl');
  static const String cmsEnv =
      String.fromEnvironment('CMS_ENV', defaultValue: 'dev');

  // Piano SDK
  static const int sideId = int.fromEnvironment('PIANO_SITE_ID');
  static const String domain = String.fromEnvironment('PIANO_DOMAIN');
}
