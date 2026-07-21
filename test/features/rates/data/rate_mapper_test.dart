import 'package:currency_exchange_tracker/core/config/currency_catalog.dart';
import 'package:currency_exchange_tracker/core/localization/locale_keys.dart';
import 'package:currency_exchange_tracker/features/rates/data/mappers/rate_mapper.dart';
import 'package:currency_exchange_tracker/features/rates/data/models/rates_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mapper = RateMapper();

  RatesResponseDto dto(String date, Map<String, double> rates) =>
      RatesResponseDto(date: date, base: 'egp', rates: rates);

  test('inverts egp->unit into EGP-per-unit', () {
    final rates = mapper.toCurrencyRates(
      latest: dto('2026-06-02', {'usd': 0.02}),
      previous: dto('2026-06-01', {'usd': 0.025}),
    );

    final usd = rates.firstWhere((r) => r.code == 'USD');
    expect(usd.rateInEgp, closeTo(50, 1e-9)); // 1 / 0.02
    expect(usd.previousRateInEgp, closeTo(40, 1e-9)); // 1 / 0.025
  });

  test('joins the currency code to its localization name key', () {
    final rates = mapper.toCurrencyRates(
      latest: dto('2026-06-02', {'usd': 0.02}),
      previous: dto('2026-06-01', {'usd': 0.02}),
    );

    expect(rates.single.name, LocaleKeys.currencies_usd);
    expect(rates.single.lastUpdated, DateTime(2026, 6, 2));
  });

  test('falls back to the current rate when yesterday is missing', () {
    final rates = mapper.toCurrencyRates(
      latest: dto('2026-06-02', {'usd': 0.02}),
      previous: dto('2026-06-01', const {}),
    );

    final usd = rates.single;
    expect(usd.previousRateInEgp, usd.rateInEgp);
    expect(usd.absoluteChange, 0);
  });

  test('emits only present target currencies, in catalog order', () {
    final rates = mapper.toCurrencyRates(
      latest: dto('2026-06-02', {'jpy': 3, 'usd': 0.02}),
      previous: dto('2026-06-01', {'jpy': 3, 'usd': 0.02}),
    );

    expect(rates.map((r) => r.code), ['USD', 'JPY']);
    expect(rates.length, lessThan(CurrencyCatalog.targets.length));
  });
}
