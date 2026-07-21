import 'dart:io' show SocketException;

import 'package:dio/dio.dart';

import '../../error/exceptions.dart';


class ErrorInterceptor extends Interceptor {
  const ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.error is AppException) {
      return handler.next(err);
    }
    final mapped = _map(err);
    handler.next(
      err.copyWith(error: mapped),
    );
  }

  AppException _map(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
        return const NoInternetException();
      case DioExceptionType.badCertificate:
        return const ServerException();
      case DioExceptionType.badResponse:
        return _mapStatus(err.response);
      case DioExceptionType.cancel:
        // Cancellation is expected during navigation/refresh; surface it as
        // unknown — the disposed Cubit won't emit it anyway.
        return UnknownException(cause: err);
      case DioExceptionType.unknown:
        if (err.error is SocketException) return const NoInternetException();
        return UnknownException(cause: err.error ?? err);
    }
  }

  AppException _mapStatus(Response<dynamic>? response) {
    final code = response?.statusCode;
    final apiMessage = _parseApiMessage(response?.data);
    switch (code) {
      case 401:
        return UnauthorizedException(apiMessage: apiMessage);
      case 403:
        return ForbiddenException(apiMessage: apiMessage);
      case 404:
        return NotFoundException(apiMessage: apiMessage);
      case 422:
        return ValidationException(
          _parseFieldErrors(response?.data),
          apiMessage: apiMessage,
        );
      default:
        return ServerException(statusCode: code, apiMessage: apiMessage);
    }
  }


  String? _parseApiMessage(dynamic data) {
    if (data is! Map) return null;
    final raw = data['message'] ?? data['error'];
    if (raw is! String) return null;
    final trimmed = raw.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Map<String, List<String>> _parseFieldErrors(dynamic data) {
    if (data is! Map) return const {};
    final errors = data['errors'];
    if (errors is! Map) return const {};
    return errors.map(
      (key, value) => MapEntry(
        key.toString(),
        value is List
            ? value.map((e) => e.toString()).toList()
            : <String>[value.toString()],
      ),
    );
  }
}
