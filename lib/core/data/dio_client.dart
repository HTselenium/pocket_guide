import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pocket_guide/core/data/interceptors/log_interceptor.dart';

class DioClient extends DioForNative {
  DioClient({List<Interceptor>? interceptors, BaseOptions? options})
      : super(
          options ??
              BaseOptions(
                connectTimeout: _defaultTimeout,
                sendTimeout: _defaultTimeout,
                receiveTimeout: _defaultTimeout,
              ),
        ) {
    this.interceptors.clear();
    this.interceptors.addAll(
          // Retry Interceptor
          interceptors ?? [RetryInterceptor(dio: this, logPrint: print)],
        );

    this.interceptors.add(LoggerInterceptor());
  }
  static const Duration _defaultTimeout = Duration(seconds: 15);
}
