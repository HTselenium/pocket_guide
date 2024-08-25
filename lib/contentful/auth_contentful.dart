import 'dart:convert';

import 'package:contentful/client.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_guide/contentful/interceptors/auth_interceptor.dart';
import 'package:pocket_guide/core/core.dart';

class AuthenticatingContentfulHTTPClient implements ContentfulHTTPClient {
  AuthenticatingContentfulHTTPClient({required this.accessToken})
      : _innerClient = DioClient(
          interceptors: [AuthInterceptor(accessToken: accessToken)],
        );
  final String accessToken;
  final DioClient _innerClient;

  @override
  void close() {
    _innerClient.close();
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    final response = await _innerClient.getUri<dynamic>(
      url,
      options: Options(headers: headers),
    );
    final dynamic encodedJson =
        response.data is String ? response.data : json.encode(response.data);

    return http.Response.bytes(
      utf8.encoder.convert(encodedJson.toString()),
      response.statusCode ?? 400,
    );
  }
}
