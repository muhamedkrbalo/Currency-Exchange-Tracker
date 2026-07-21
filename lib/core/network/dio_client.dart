import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';


class DioFactory {
  const DioFactory();

  Dio create() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      
        validateStatus: (status) =>
            status != null && status >= 200 && status < 300,
      ),
    );

    dio.interceptors.addAll([
      buildRetryInterceptor(dio),
      if (kDebugMode) buildLoggingInterceptor(),
      const ErrorInterceptor(),
    ]);

    return dio;
  }
}
