import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:pocket_guide/core/constants/environment.dart';

class LoggerInterceptor extends LogInterceptor {
  LoggerInterceptor()
      : super(
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          logPrint: (log) {
            if (!Environment.debug) {
              return;
            }
            debugPrint('🌐 $log');
          },
        );
}
