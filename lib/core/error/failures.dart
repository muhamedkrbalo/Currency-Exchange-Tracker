import 'package:equatable/equatable.dart';

import '../localization/locale_keys.dart';

sealed class Failure extends Equatable {
  const Failure({required this.messageKey, this.apiMessage, this.statusCode});

  final String messageKey;

  final String? apiMessage;

  final int? statusCode;

  @override
  List<Object?> get props => [messageKey, apiMessage, statusCode];
}

final class ServerFailure extends Failure {
  const ServerFailure({
    super.apiMessage,
    super.statusCode,
    super.messageKey = LocaleKeys.errors_server,
  });
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.apiMessage,
    super.messageKey = LocaleKeys.errors_unauthorized,
    super.statusCode = 401,
  });
}

final class ForbiddenFailure extends Failure {
  const ForbiddenFailure({
    super.apiMessage,
    super.messageKey = LocaleKeys.errors_forbidden,
    super.statusCode = 403,
  });
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.apiMessage,
    super.messageKey = LocaleKeys.errors_not_found,
    super.statusCode = 404,
  });
}

final class ValidationFailure extends Failure {
  const ValidationFailure(
    this.fieldErrors, {
    super.apiMessage,
    super.messageKey = LocaleKeys.errors_validation,
    super.statusCode = 422,
  });

  final Map<String, List<String>> fieldErrors;

  @override
  List<Object?> get props => [...super.props, fieldErrors];
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure({super.messageKey = LocaleKeys.errors_timeout});
}

final class NetworkFailure extends Failure {
  const NetworkFailure({super.messageKey = LocaleKeys.errors_network});
}

final class CacheFailure extends Failure {
  const CacheFailure({super.messageKey = LocaleKeys.errors_cache});
}

final class UnknownFailure extends Failure {
  const UnknownFailure({super.messageKey = LocaleKeys.errors_unknown});
}
