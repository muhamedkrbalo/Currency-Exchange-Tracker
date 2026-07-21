import 'package:dio/dio.dart' show CancelToken;


abstract interface class ApiClient {
  Future<T> get<T>(
    Uri uri, {
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  });
}
