import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';


RetryInterceptor buildRetryInterceptor(Dio dio) {
  return RetryInterceptor(
    dio: dio,
    logPrint: kDebugMode ? debugPrint : null,
    retries: 3,
    retryDelays: const [
      Duration(milliseconds: 300),
      Duration(milliseconds: 600),
      Duration(milliseconds: 1200),
    ],
    retryEvaluator: _shouldRetry,
  );
}

bool _shouldRetry(DioException error, int attempt) {
  if (error.requestOptions.method.toUpperCase() != 'GET') return false;

  final isTransient = switch (error.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.connectionError =>
      true,
    _ => false,
  };

  final status = error.response?.statusCode;
  final isServerError = status != null && status >= 500;

  return isTransient || isServerError;
}
