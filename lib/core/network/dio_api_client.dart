import 'package:dio/dio.dart';

import '../error/exceptions.dart';
import 'api_client.dart';
import 'api_response.dart';


class DioApiClient implements ApiClient {
  const DioApiClient(this._dio);

  final Dio _dio;

  Dio get dio => _dio;

  @override
  Future<T> get<T>(
    Uri uri, {
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.getUri<T>(
        uri,
        options: Options(headers: headers),
        cancelToken: cancelToken,
      );
      return response.unwrap();
    } on DioException catch (e) {
      // ErrorInterceptor already mapped this to an AppException on `e.error`.
      throw e.error is AppException
          ? e.error! as AppException
          : UnknownException(cause: e);
    }
  }
}
