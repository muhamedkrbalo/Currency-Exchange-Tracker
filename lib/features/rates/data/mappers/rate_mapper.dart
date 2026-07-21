import '../../../../core/config/currency_catalog.dart';
import '../../domain/entities/currency_rate.dart';
import '../models/rates_response_dto.dart';

class RateMapper {
  const RateMapper();

  List<CurrencyRate> toCurrencyRates({
    required RatesResponseDto latest,
    required RatesResponseDto previous,
  }) {
    final lastUpdated = DateTime.parse(latest.date);
    final result = <CurrencyRate>[];
    for (final info in CurrencyCatalog.targets) {
      final current = _egpPerUnit(latest.rates[info.responseKey]);
      if (current == null) continue;
      final prior = _egpPerUnit(previous.rates[info.responseKey]) ?? current;
      result.add(
        CurrencyRate(
          code: info.code,
          name: info.nameKey,
          rateInEgp: current,
          previousRateInEgp: prior,
          lastUpdated: lastUpdated,
        ),
      );
    }
    return result;
  }

  double? _egpPerUnit(double? egpToForeignUnit) =>
      (egpToForeignUnit == null || egpToForeignUnit == 0)
          ? null
          : 1 / egpToForeignUnit;
}
