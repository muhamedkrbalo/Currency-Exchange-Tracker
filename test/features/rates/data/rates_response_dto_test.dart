import 'package:currency_exchange_tracker/features/rates/data/models/rates_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromApi', () {
    test('reads the date and the nested base-currency rate map', () {
      final dto = RatesResponseDto.fromApi(
        {
          'date': '2026-06-01',
          'egp': {'usd': 0.02, 'eur': 0.017},
        },
        base: 'egp',
      );

      expect(dto.date, '2026-06-01');
      expect(dto.base, 'egp');
      expect(dto.rates, {'usd': 0.02, 'eur': 0.017});
    });

    test('coerces integer rate values to double', () {
      final dto = RatesResponseDto.fromApi(
        {
          'date': '2026-06-01',
          'egp': {'jpy': 3},
        },
        base: 'egp',
      );

      expect(dto.rates['jpy'], 3.0);
      expect(dto.rates['jpy'], isA<double>());
    });

    test('throws FormatException when the base map is missing', () {
      expect(
        () => RatesResponseDto.fromApi({'date': '2026-06-01'}, base: 'egp'),
        throwsFormatException,
      );
    });

    test('throws FormatException when the date is missing', () {
      expect(
        () => RatesResponseDto.fromApi({'egp': {'usd': 0.02}}, base: 'egp'),
        throwsFormatException,
      );
    });
  });

  group('json round-trip (cache shape)', () {
    test('fromJson/toJson preserve the canonical DTO', () {
      const dto = RatesResponseDto(
        date: '2026-06-01',
        base: 'egp',
        rates: {'usd': 0.02},
      );

      expect(RatesResponseDto.fromJson(dto.toJson()), dto);
    });
  });
}
