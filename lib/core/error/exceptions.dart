

import '../localization/locale_keys.dart';

sealed class AppException implements Exception {
  const AppException({
    this.messageKey = LocaleKeys.errors_unknown,
    this.apiMessage,
    this.statusCode,
    this.cause,
  });

  final String messageKey;

  final String? apiMessage;

  final int? statusCode;

  final Object? cause;

  @override
  String toString() => '$runtimeType(status: $statusCode, key: $messageKey)';
}

final class ServerException extends AppException {
  const ServerException({
    super.apiMessage,
    super.statusCode,
    super.cause,
    super.messageKey = LocaleKeys.errors_server,
  });
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.apiMessage,
    super.messageKey = LocaleKeys.errors_unauthorized,
    super.statusCode = 401,
  });
}

final class ForbiddenException extends AppException {
  const ForbiddenException({
    super.apiMessage,
    super.messageKey = LocaleKeys.errors_forbidden,
    super.statusCode = 403,
  });
}

final class NotFoundException extends AppException {
  const NotFoundException({
    super.apiMessage,
    super.messageKey = LocaleKeys.errors_not_found,
    super.statusCode = 404,
  });
}

final class ValidationException extends AppException {
  const ValidationException(
    this.fieldErrors, {
    super.apiMessage,
    super.messageKey = LocaleKeys.errors_validation,
    super.statusCode = 422,
  });

  final Map<String, List<String>> fieldErrors;
}

final class TimeoutException extends AppException {
  const TimeoutException({super.messageKey = LocaleKeys.errors_timeout});
}

final class NoInternetException extends AppException {
  const NoInternetException({super.messageKey = LocaleKeys.errors_network});
}

final class CacheException extends AppException {
  const CacheException({super.messageKey = LocaleKeys.errors_cache});
}

final class UnknownException extends AppException {
  const UnknownException({super.cause});
}
