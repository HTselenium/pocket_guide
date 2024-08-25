import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  const AppException(this.message);

  final String message;

  static AppException fromDio(DioException error) {
    final errors = <String>['socketexception', 'timeoutexception'];
    if (errors.any((el) => error.toString().toLowerCase().contains(el))) {
      return NoInternetException();
    } else {
      throw UnknownException(stackTrace: error.stackTrace);
    }
  }
}

class NoInternetException implements AppException {
  @override
  String get message => 'No internet connection';
}

class UnknownException implements AppException {
  const UnknownException({this.stackTrace});

  @override
  String get message => 'Something went wrong';
  final StackTrace? stackTrace;
}
