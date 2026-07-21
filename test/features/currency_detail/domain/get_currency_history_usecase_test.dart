import 'package:currency_exchange_tracker/core/error/failures.dart';
import 'package:currency_exchange_tracker/core/result/result.dart';
import 'package:currency_exchange_tracker/features/currency_detail/domain/usecases/get_currency_history_usecase.dart';
import 'package:currency_exchange_tracker/features/rates/domain/entities/historical_rate.dart';
import 'package:currency_exchange_tracker/features/rates/domain/repositories/currency_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  late MockCurrencyRepository repository;
  late GetCurrencyHistoryUseCase useCase;

  setUp(() {
    repository = MockCurrencyRepository();
    useCase = GetCurrencyHistoryUseCase(repository);
  });

  final history = [
    HistoricalRate(date: DateTime(2026, 7, 21), rateInEgp: 52),
    HistoricalRate(date: DateTime(2026, 7, 20), rateInEgp: 51),
  ];

  test(
    'returns the history for the code from the repository on success',
    () async {
      when(
        () => repository.getHistory(any(), days: any(named: 'days')),
      ).thenAnswer((_) async => Result.success(history));

      final result = await useCase('USD');

      expect(result, isA<Success<List<HistoricalRate>>>());
      expect(result.valueOrNull, history);
    },
  );

  test('defaults to a 7-day window when none is provided', () async {
    when(
      () => repository.getHistory(any(), days: any(named: 'days')),
    ).thenAnswer((_) async => Result.success(history));

    await useCase('EUR');

    verify(() => repository.getHistory('EUR', days: 7)).called(1);
  });

  test('forwards an explicit day window to the repository', () async {
    when(
      () => repository.getHistory(any(), days: any(named: 'days')),
    ).thenAnswer((_) async => Result.success(history));

    await useCase('GBP', days: 30);

    verify(() => repository.getHistory('GBP', days: 30)).called(1);
  });

  test('forwards the failure from the repository unchanged', () async {
    const failure = ServerFailure();
    when(
      () => repository.getHistory(any(), days: any(named: 'days')),
    ).thenAnswer((_) async => const Result.failure(failure));

    final result = await useCase('SAR');

    expect(result.failureOrNull, failure);
  });
}
