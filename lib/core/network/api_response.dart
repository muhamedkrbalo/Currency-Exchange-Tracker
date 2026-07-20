import 'package:dio/dio.dart';

import '../error/exceptions.dart';


extension ApiResponseX<T> on Response<T> {
 
  T unwrapOr(AppException Function(Response<T> response) orElse) {
    final code = statusCode;
    final body = data;
    if (code != null && code >= 200 && code < 300 && body != null) {
      return body;
    }
    throw orElse(this);
  }

  T unwrap() => unwrapOr(
        (r) => ServerException(statusCode: r.statusCode),
      );
}
