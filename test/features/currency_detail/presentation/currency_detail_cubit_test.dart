import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange_tracker/core/error/failures.dart';
import 'package:currency_exchange_tracker/core/result/result.dart';
import 'package:currency_exchange_tracker/features/currency_detail/domain/usecases/get_currency_history_usecase.dart';
import 'package:currency_exchange_tracker/features/currency_detail/presentation/cubit/currency_detail_cubit.dart';
import 'package:currency_exchange_tracker/features/currency_detail/presentation/cubit/currency_detail_state.dart';
import 'package:currency_exchange_tracker/features/rates/domain/entities/historical_rate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetCurrencyHistoryUseCase extends Mock
    implements GetCurrencyHistoryUseCase {}

void main() {
  late _MockGetCurrencyHistoryUseCase useCase;

  final history = [
    HistoricalRate(date: DateTime(2026, 7, 21), rateInEgp: 52),
    HistoricalRate(date: DateTime(2026, 7, 20), rateInEgp: 51),
  ];

  setUp(() => useCase = _MockGetCurrencyHistoryUseCase());

  CurrencyDetailCubit build() => CurrencyDetailCubit(useCase);

  test('initial state is CurrencyDetailInitial', () {
    expect(build().state, const CurrencyDetailState.initial());
  });

  blocTest<CurrencyDetailCubit, CurrencyDetailState>(
    'emits [Loading, Loaded] with the history on success',
    setUp: () {
      when(
        () => useCase(any(), days: any(named: 'days')),
      ).thenAnswer((_) async => Result.success(history));
    },
    build: build,
    act: (cubit) => cubit.load('usd'),
    expect: () => [
      const CurrencyDetailState.loading(),
      CurrencyDetailState.loaded(history),
    ],
    verify: (_) => verify(() => useCase('usd')).called(1),
  );

  blocTest<CurrencyDetailCubit, CurrencyDetailState>(
    'emits [Loading, Loaded] with an empty history',
    setUp: () {
      when(
        () => useCase(any(), days: any(named: 'days')),
      ).thenAnswer((_) async => const Result.success(<HistoricalRate>[]));
    },
    build: build,
    act: (cubit) => cubit.load('eur'),
    expect: () => [
      const CurrencyDetailState.loading(),
      const CurrencyDetailState.loaded([]),
    ],
  );

  blocTest<CurrencyDetailCubit, CurrencyDetailState>(
    'emits [Loading, Error] when the use case fails',
    setUp: () {
      when(
        () => useCase(any(), days: any(named: 'days')),
      ).thenAnswer((_) async => const Result.failure(ServerFailure()));
    },
    build: build,
    act: (cubit) => cubit.load('gbp'),
    expect: () => [
      const CurrencyDetailState.loading(),
      const CurrencyDetailState.error(ServerFailure()),
    ],
  );
}
