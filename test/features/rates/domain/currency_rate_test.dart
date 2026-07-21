import 'package:currency_exchange_tracker/features/rates/domain/entities/currency_rate.dart';
import 'package:flutter_test/flutter_test.dart';

CurrencyRate buildRate({
  required double rateInEgp,
  required double previousRateInEgp,
}) {
  return CurrencyRate(
    code: 'USD',
    name: 'currencies.usd',
    rateInEgp: rateInEgp,
    previousRateInEgp: previousRateInEgp,
    lastUpdated: DateTime(2026, 7, 21),
  );
}

void main() {
  group('absoluteChange', () {
    test('is the difference between current and previous EGP rate', () {
      final rate = buildRate(rateInEgp: 52, previousRateInEgp: 50);

      expect(rate.absoluteChange, closeTo(2, 1e-9));
    });

    test('is negative when the rate dropped', () {
      final rate = buildRate(rateInEgp: 50, previousRateInEgp: 52);

      expect(rate.absoluteChange, closeTo(-2, 1e-9));
    });
  });

  group('percentChange', () {
    test('is the change relative to the previous rate', () {
      final rate = buildRate(rateInEgp: 55, previousRateInEgp: 50);

      expect(rate.percentChange, closeTo(10, 1e-9));
    });

    test('is zero when the previous rate is zero (no division by zero)', () {
      final rate = buildRate(rateInEgp: 55, previousRateInEgp: 0);

      expect(rate.percentChange, 0);
    });
  });

  group('isEgpStrengthening', () {
    test('is true when fewer EGP buy one unit (rate dropped)', () {
      final rate = buildRate(rateInEgp: 50, previousRateInEgp: 52);

      expect(rate.isEgpStrengthening, isTrue);
    });

    test('is false when more EGP are needed (rate rose)', () {
      final rate = buildRate(rateInEgp: 52, previousRateInEgp: 50);

      expect(rate.isEgpStrengthening, isFalse);
    });

    test('is false when the rate is unchanged', () {
      final rate = buildRate(rateInEgp: 50, previousRateInEgp: 50);

      expect(rate.isEgpStrengthening, isFalse);
    });
  });
}
