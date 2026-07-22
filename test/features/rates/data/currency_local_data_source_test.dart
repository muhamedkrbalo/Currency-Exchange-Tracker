import 'dart:io';

import 'package:currency_exchange_tracker/features/rates/data/datasources/local/currency_local_data_source.dart';
import 'package:currency_exchange_tracker/features/rates/data/models/rates_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive_ce.dart';

void main() {
  late Directory tempDir;
  late Box<dynamic> box;
  late CurrencyLocalDataSource dataSource;

  const dto = RatesResponseDto(
    date: '2026-06-01',
    base: 'egp',
    rates: {'usd': 0.02, 'eur': 0.017},
  );

  setUp(() async {
    tempDir = Directory.systemTemp.createTempSync('rates_cache_test');
    Hive.init(tempDir.path);
    box = await Hive.openBox<dynamic>('rates_cache_test');
    dataSource = CurrencyLocalDataSource(box);
  });

  tearDown(() async {
    await box.deleteFromDisk();
    await Hive.close();
    tempDir.deleteSync(recursive: true);
  });

  test('returns null when nothing is cached', () {
    expect(dataSource.getCachedRates(), isNull);
    expect(dataSource.getLastUpdated(), isNull);
  });

  test('round-trips the cached DTO', () async {
    await dataSource.cacheRates(dto);

    expect(dataSource.getCachedRates(), dto);
  });

  test('has no previous snapshot until one is provided', () async {
    await dataSource.cacheRates(dto);

    expect(dataSource.getCachedPreviousRates(), isNull);
  });

  test('round-trips the previous snapshot when provided', () async {
    const previous = RatesResponseDto(
      date: '2026-05-31',
      base: 'egp',
      rates: {'usd': 0.021},
    );

    await dataSource.cacheRates(dto, previous: previous);

    expect(dataSource.getCachedRates(), dto);
    expect(dataSource.getCachedPreviousRates(), previous);
  });

  test('stores the provided last-updated timestamp', () async {
    final at = DateTime(2026, 6, 1, 9, 30);

    await dataSource.cacheRates(dto, at: at);

    expect(dataSource.getLastUpdated(), at);
  });

  test('overwrites the previous snapshot', () async {
    await dataSource.cacheRates(dto, at: DateTime(2026, 6, 1));

    const newer = RatesResponseDto(
      date: '2026-06-02',
      base: 'egp',
      rates: {'usd': 0.021},
    );
    await dataSource.cacheRates(newer, at: DateTime(2026, 6, 2));

    expect(dataSource.getCachedRates(), newer);
    expect(dataSource.getLastUpdated(), DateTime(2026, 6, 2));
  });
}
