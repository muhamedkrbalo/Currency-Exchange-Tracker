import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange_tracker/core/error/failures.dart';
import 'package:currency_exchange_tracker/core/network_info/network_info.dart';
import 'package:currency_exchange_tracker/core/result/result.dart';
import 'package:currency_exchange_tracker/features/rates/domain/entities/currency_rate.dart';
import 'package:currency_exchange_tracker/features/rates/domain/usecases/get_latest_rates_usecase.dart';
import 'package:currency_exchange_tracker/features/rates/presentation/cubit/rates_list_cubit.dart';
import 'package:currency_exchange_tracker/features/rates/presentation/cubit/rates_list_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetLatestRatesUseCase extends Mock
    implements GetLatestRatesUseCase {}

class _MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late _MockGetLatestRatesUseCase useCase;
  late _MockNetworkInfo networkInfo;

  final lastUpdated = DateTime(2026, 7, 21);
  final rates = [
    CurrencyRate(
      code: 'usd',
      name: 'US Dollar',
      rateInEgp: 48,
      previousRateInEgp: 47,
      lastUpdated: lastUpdated,
    ),
  ];

  setUp(() {
    useCase = _MockGetLatestRatesUseCase();
    networkInfo = _MockNetworkInfo();
  });

  RatesListCubit build() => RatesListCubit(useCase, networkInfo);

  test('initial state is RatesListInitial', () {
    expect(build().state, const RatesListState.initial());
  });

  group('load', () {
    blocTest<RatesListCubit, RatesListState>(
      'emits [Loading, Loaded] with fresh data when online',
      setUp: () {
        when(() => useCase()).thenAnswer((_) async => Result.success(rates));
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      },
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => [
        const RatesListState.loading(),
        RatesListState.loaded(
          rates: rates,
          isFromCache: false,
          lastUpdated: lastUpdated,
        ),
      ],
    );

    blocTest<RatesListCubit, RatesListState>(
      'emits [Loading, Loaded(isFromCache: true)] when offline serves cache',
      setUp: () {
        when(() => useCase()).thenAnswer((_) async => Result.success(rates));
        when(() => networkInfo.isConnected).thenAnswer((_) async => false);
      },
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => [
        const RatesListState.loading(),
        RatesListState.loaded(
          rates: rates,
          isFromCache: true,
          lastUpdated: lastUpdated,
        ),
      ],
    );

    blocTest<RatesListCubit, RatesListState>(
      'emits [Loading, Error] when the use case fails',
      setUp: () {
        when(() => useCase())
            .thenAnswer((_) async => const Result.failure(NetworkFailure()));
      },
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => [
        const RatesListState.loading(),
        const RatesListState.error(NetworkFailure()),
      ],
    );

    blocTest<RatesListCubit, RatesListState>(
      'emits Loaded with null lastUpdated for empty rates',
      setUp: () {
        when(() => useCase())
            .thenAnswer((_) async => const Result.success(<CurrencyRate>[]));
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      },
      build: build,
      act: (cubit) => cubit.load(),
      expect: () => [
        const RatesListState.loading(),
        const RatesListState.loaded(rates: [], isFromCache: false),
      ],
    );
  });

  group('refresh', () {
    blocTest<RatesListCubit, RatesListState>(
      'emits only Loaded (no Loading) so the current list stays visible',
      setUp: () {
        when(() => useCase()).thenAnswer((_) async => Result.success(rates));
        when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      },
      build: build,
      act: (cubit) => cubit.refresh(),
      expect: () => [
        RatesListState.loaded(
          rates: rates,
          isFromCache: false,
          lastUpdated: lastUpdated,
        ),
      ],
    );

    blocTest<RatesListCubit, RatesListState>(
      'emits Error without a Loading state on failure',
      setUp: () {
        when(() => useCase())
            .thenAnswer((_) async => const Result.failure(ServerFailure()));
      },
      build: build,
      act: (cubit) => cubit.refresh(),
      expect: () => [const RatesListState.error(ServerFailure())],
    );
  });
}
