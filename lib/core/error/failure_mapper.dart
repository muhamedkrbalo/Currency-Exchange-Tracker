import 'exceptions.dart';
import 'failures.dart';


Failure mapExceptionToFailure(AppException exception) => switch (exception) {
      ServerException() => ServerFailure(
          statusCode: exception.statusCode,
          apiMessage: exception.apiMessage,
        ),
      UnauthorizedException() =>
        UnauthorizedFailure(apiMessage: exception.apiMessage),
      ForbiddenException() =>
        ForbiddenFailure(apiMessage: exception.apiMessage),
      NotFoundException() => NotFoundFailure(apiMessage: exception.apiMessage),
      ValidationException() => ValidationFailure(
          exception.fieldErrors,
          apiMessage: exception.apiMessage,
        ),
      TimeoutException() => const TimeoutFailure(),
      NoInternetException() => const NetworkFailure(),
      CacheException() => const CacheFailure(),
      UnknownException() => const UnknownFailure(),
    };
