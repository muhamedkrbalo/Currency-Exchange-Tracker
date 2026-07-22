import 'package:currency_exchange_tracker/core/error/exceptions.dart';
import 'package:currency_exchange_tracker/core/error/failures.dart';
import 'package:currency_exchange_tracker/core/network_info/network_info.dart';
import 'package:currency_exchange_tracker/features/rates/data/datasources/local/currency_local_data_source.dart';
import 'package:currency_exchange_tracker/features/rates/data/datasources/remote/rates_remote_data_source.dart';
import 'package:currency_exchange_tracker/features/rates/data/models/rates_response_dto.dart';
import 'package:currency_exchange_tracker/features/rates/data/repositories/currency_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemote extends Mock implements CurrencyRemoteDataSource {}

class MockLocal extends Mock implements CurrencyLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockRemote remote;
  late MockLocal local;
  late MockNetworkInfo networkInfo;
  late CurrencyRepositoryImpl repository;

  const today = RatesResponseDto(
    date: '2026-06-02',
    base: 'egp',
    rates: {'usd': 0.02},
  );
  const yesterday = RatesResponseDto(
    date: '2026-06-01',
    base: 'egp',
    rates: {'usd': 0.025},
  );

  setUpAll(() {
    registerFallbackValue(DateTime(2020));
    registerFallbackValue(today);
  });

  setUp(() {
    remote = MockRemote();
    local = MockLocal();
    networkInfo = MockNetworkInfo();
    repository = CurrencyRepositoryImpl(remote, local, networkInfo);
  });

  group('getLatestRates', () {
    test('fetches today + yesterday, caches today, returns fresh rates',
        () async {
      when(() => remote.getLatest()).thenAnswer((_) async => today);
      when(() => remote.getByDate(any())).thenAnswer((_) async => yesterday);
      when(() => local.cacheRates(any(), previous: any(named: 'previous')))
          .thenAnswer((_) async {});

      final result = await repository.getLatestRates();
      final usd = result.valueOrNull!.single;

      expect(usd.rateInEgp, closeTo(50, 1e-9)); // 1 / 0.02
      expect(usd.previousRateInEgp, closeTo(40, 1e-9)); // 1 / 0.025
      verify(() => local.cacheRates(today, previous: yesterday)).called(1);
    });

    test('serves cached today + yesterday change when offline', () async {
      when(() => remote.getLatest()).thenThrow(const NoInternetException());
      when(() => local.getCachedRates()).thenReturn(today);
      when(() => local.getCachedPreviousRates()).thenReturn(yesterday);

      final result = await repository.getLatestRates();
      final usd = result.valueOrNull!.single;

      expect(usd.rateInEgp, closeTo(50, 1e-9));
      expect(usd.previousRateInEgp, closeTo(40, 1e-9)); // real change offline
      expect(usd.absoluteChange, closeTo(10, 1e-9));
    });

    test('falls back to zero change when only today is cached', () async {
      when(() => remote.getLatest()).thenThrow(const NoInternetException());
      when(() => local.getCachedRates()).thenReturn(today);
      when(() => local.getCachedPreviousRates()).thenReturn(null);

      final result = await repository.getLatestRates();
      final usd = result.valueOrNull!.single;

      expect(usd.rateInEgp, closeTo(50, 1e-9));
      expect(usd.absoluteChange, 0); // no previous snapshot -> zero change
    });

    test('returns NetworkFailure when offline with no cache', () async {
      when(() => remote.getLatest()).thenThrow(const NoInternetException());
      when(() => local.getCachedRates()).thenReturn(null);

      final result = await repository.getLatestRates();

      expect(result.failureOrNull, isA<NetworkFailure>());
    });

    test('maps a server exception to ServerFailure (no cache fallback)',
        () async {
      when(() => remote.getLatest())
          .thenThrow(const ServerException(statusCode: 500));

      final result = await repository.getLatestRates();

      expect(result.failureOrNull, isA<ServerFailure>());
      verifyNever(() => local.getCachedRates());
    });
  });

  group('getHistory', () {
    test('fetches one snapshot per day and extracts the currency', () async {
      when(() => remote.getLatest()).thenAnswer((_) async => today);
      when(() => remote.getByDate(any())).thenAnswer((invocation) async {
        final date = invocation.positionalArguments.first as DateTime;
        final ymd =
            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        return RatesResponseDto(date: ymd, base: 'egp', rates: const {'usd': 0.02});
      });

      final result = await repository.getHistory('USD', days: 7);
      final points = result.valueOrNull!;

      expect(points, hasLength(7));
      expect(points.first.date.isBefore(points.last.date), isTrue); // sorted
      expect(points.first.rateInEgp, closeTo(50, 1e-9));
    });

    test('maps failures to a Failure', () async {
      when(() => remote.getLatest()).thenThrow(const TimeoutException());

      final result = await repository.getHistory('USD');

      expect(result.failureOrNull, isA<TimeoutFailure>());
    });
  });

  test('connectivity forwards the NetworkInfo stream', () {
    when(() => networkInfo.onStatusChange)
        .thenAnswer((_) => Stream.fromIterable([true, false]));

    expect(repository.connectivity, emitsInOrder([true, false]));
  });
}
