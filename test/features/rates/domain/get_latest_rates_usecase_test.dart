import 'package:currency_exchange_tracker/core/error/failures.dart';
import 'package:currency_exchange_tracker/core/result/result.dart';
import 'package:currency_exchange_tracker/features/rates/domain/entities/currency_rate.dart';
import 'package:currency_exchange_tracker/features/rates/domain/repositories/currency_repository.dart';
import 'package:currency_exchange_tracker/features/rates/domain/usecases/get_latest_rates_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrencyRepository extends Mock implements CurrencyRepository {}

void main() {
  late MockCurrencyRepository repository;
  late GetLatestRatesUseCase useCase;

  setUp(() {
    repository = MockCurrencyRepository();
    useCase = GetLatestRatesUseCase(repository);
  });

  final rates = [
    CurrencyRate(
      code: 'USD',
      name: 'currencies.usd',
      rateInEgp: 52,
      previousRateInEgp: 50,
      lastUpdated: DateTime(2026, 7, 21),
    ),
  ];

  test('returns the latest rates from the repository on success', () async {
    when(() => repository.getLatestRates())
        .thenAnswer((_) async => Result.success(rates));

    final result = await useCase();

    expect(result, isA<Success<List<CurrencyRate>>>());
    expect(result.valueOrNull, rates);
    verify(() => repository.getLatestRates()).called(1);
  });

  test('forwards the failure from the repository unchanged', () async {
    const failure = NetworkFailure();
    when(() => repository.getLatestRates())
        .thenAnswer((_) async => const Result.failure(failure));

    final result = await useCase();

    expect(result.failureOrNull, failure);
    verifyNever(() => repository.getHistory(any()));
  });
}
