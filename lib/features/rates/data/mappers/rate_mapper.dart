import '../../../../core/config/currency_catalog.dart';
import '../../domain/entities/currency_rate.dart';
import '../../domain/entities/historical_rate.dart';
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

  List<HistoricalRate> toHistoricalRates(
    Iterable<RatesResponseDto> snapshots,
    String code,
  ) {
    final key = code.toLowerCase();
    final points = <HistoricalRate>[];
    for (final snapshot in snapshots) {
      final rate = _egpPerUnit(snapshot.rates[key]);
      if (rate == null) continue;
      points.add(
        HistoricalRate(date: DateTime.parse(snapshot.date), rateInEgp: rate),
      );
    }
    points.sort((a, b) => a.date.compareTo(b.date));
    return points;
  }

  double? _egpPerUnit(double? egpToForeignUnit) =>
      (egpToForeignUnit == null || egpToForeignUnit == 0)
          ? null
          : 1 / egpToForeignUnit;
}
