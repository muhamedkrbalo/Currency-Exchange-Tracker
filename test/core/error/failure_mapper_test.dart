import 'package:currency_exchange_tracker/core/error/exceptions.dart';
import 'package:currency_exchange_tracker/core/error/failure_mapper.dart';
import 'package:currency_exchange_tracker/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('mapExceptionToFailure', () {
    test('carries apiMessage through for ServerException', () {
      final failure = mapExceptionToFailure(
        const ServerException(statusCode: 500, apiMessage: 'db down'),
      );

      expect(failure, isA<ServerFailure>());
      expect(failure.apiMessage, 'db down');
      expect(failure.statusCode, 500);
    });

    test('carries apiMessage through for ValidationException', () {
      final failure = mapExceptionToFailure(
        const ValidationException(
          {
            'amount': ['must be positive'],
          },
          apiMessage: 'Invalid amount',
        ),
      );

      expect(failure, isA<ValidationFailure>());
      expect(failure.apiMessage, 'Invalid amount');
      expect(
        (failure as ValidationFailure).fieldErrors['amount'],
        ['must be positive'],
      );
    });

    test('maps NotFoundException with no apiMessage to null', () {
      final failure = mapExceptionToFailure(const NotFoundException());

      expect(failure, isA<NotFoundFailure>());
      expect(failure.apiMessage, isNull);
    });

    test('TimeoutException/NoInternetException never carry apiMessage', () {
      expect(
        mapExceptionToFailure(const TimeoutException()).apiMessage,
        isNull,
      );
      expect(
        mapExceptionToFailure(const NoInternetException()).apiMessage,
        isNull,
      );
    });
  });
}
