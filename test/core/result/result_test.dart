import 'package:currency_exchange_tracker/core/error/exceptions.dart';
import 'package:currency_exchange_tracker/core/error/failures.dart';
import 'package:currency_exchange_tracker/core/localization/locale_keys.dart';
import 'package:currency_exchange_tracker/core/result/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('success exposes its value and folds to the success arm', () {
      const result = Result<int>.success(42);

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.valueOrNull, 42);
      expect(result.failureOrNull, isNull);
      expect(result.fold((v) => 'ok:$v', (f) => 'err'), 'ok:42');
    });

    test('failure exposes its failure and folds to the failure arm', () {
      const failure = NetworkFailure();
      const result = Result<int>.failure(failure);

      expect(result.isFailure, isTrue);
      expect(result.valueOrNull, isNull);
      expect(result.failureOrNull, failure);
      expect(result.fold((v) => 'ok', (f) => 'err'), 'err');
    });

    test('map transforms success and passes failure through unchanged', () {
      const ok = Result<int>.success(21);
      expect(ok.map((v) => v * 2).valueOrNull, 42);

      const err = Result<int>.failure(TimeoutFailure());
      final mapped = err.map((v) => v * 2);
      expect(mapped.failureOrNull, isA<TimeoutFailure>());
    });
  });

  group('guardAsync', () {
    test('returns success when the body completes', () async {
      final result = await guardAsync(() async => 'value');
      expect(result.valueOrNull, 'value');
    });

    test('maps a thrown AppException to the matching Failure', () async {
      final result = await guardAsync<String>(
        () async => throw const NotFoundException(),
      );

      expect(result.failureOrNull, isA<NotFoundFailure>());
      expect(result.failureOrNull?.messageKey, LocaleKeys.errors_not_found);
      expect(result.failureOrNull?.statusCode, 404);
    });

    test('maps an unexpected error to UnknownFailure', () async {
      final result = await guardAsync<String>(
        () async => throw StateError('boom'),
      );

      expect(result.failureOrNull, isA<UnknownFailure>());
    });
  });
}
