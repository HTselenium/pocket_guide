import 'dart:io';

import 'package:dio/dio.dart';

class AuthInterceptor extends InterceptorsWrapper {
  AuthInterceptor({required this.accessToken})
      : super(
          onRequest: (options, handler) =>
              _authorizeRequest(options, handler, accessToken),
        );
  final String accessToken;

  static void _authorizeRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
    String accessToken,
  ) {
    options.headers.putIfAbsent(
      HttpHeaders.authorizationHeader,
      () => 'Bearer $accessToken',
    );
    handler.next(options);
  }
}
