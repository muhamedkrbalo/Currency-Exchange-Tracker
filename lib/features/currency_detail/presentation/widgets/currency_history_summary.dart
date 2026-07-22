import '../../../rates/domain/entities/historical_rate.dart';

extension CurrencyHistorySummary on List<HistoricalRate> {
  double get currentRate => last.rateInEgp;

  DateTime get lastUpdated => last.date;

  double? get dailyChange =>
      length < 2 ? null : last.rateInEgp - this[length - 2].rateInEgp;

  double get dailyChangePercent {
    if (length < 2) return 0;
    final previous = this[length - 2].rateInEgp;
    if (previous == 0) return 0;
    return (dailyChange! / previous) * 100;
  }

  bool get isEgpStrengthening => (dailyChange ?? 0) < 0;
}
