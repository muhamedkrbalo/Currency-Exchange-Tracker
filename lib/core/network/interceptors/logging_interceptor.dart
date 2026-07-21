import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';


Interceptor buildLoggingInterceptor() {
  return PrettyDioLogger(
    request: true,
    requestHeader: false, // redact auth/cookies — never log headers
    requestBody: false,
    responseHeader: false,
    responseBody: true,
    error: true,
    compact: true,
    maxWidth: 120,
  );
}
