import 'package:currency_exchange_tracker/features/currency_detail/presentation/widgets/currency_history_summary.dart';
import 'package:currency_exchange_tracker/features/rates/domain/entities/historical_rate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<HistoricalRate> series(List<double> rates) => [
    for (var i = 0; i < rates.length; i++)
      HistoricalRate(date: DateTime(2026, 7, 15 + i), rateInEgp: rates[i]),
  ];

  test('current rate and last updated come from the most recent point', () {
    final history = series([50, 51, 52]);

    expect(history.currentRate, 52);
    expect(history.lastUpdated, DateTime(2026, 7, 17));
  });

  test('daily change compares the two most recent points', () {
    final history = series([50, 51, 52]);

    expect(history.dailyChange, 1);
    expect(history.dailyChangePercent, closeTo((1 / 51) * 100, 1e-9));
    expect(history.isEgpStrengthening, isFalse);
  });

  test('EGP strengthening when the most recent rate falls', () {
    final history = series([52, 50]);

    expect(history.dailyChange, -2);
    expect(history.isEgpStrengthening, isTrue);
  });

  test('single point has no daily change', () {
    final history = series([52]);

    expect(history.dailyChange, isNull);
    expect(history.dailyChangePercent, 0);
    expect(history.isEgpStrengthening, isFalse);
  });
}
