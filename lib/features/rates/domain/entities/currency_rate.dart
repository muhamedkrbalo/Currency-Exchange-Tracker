import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_rate.freezed.dart';

@freezed
abstract class CurrencyRate with _$CurrencyRate {
  const CurrencyRate._();

  const factory CurrencyRate({
    required String code,
    required String name,
    required double rateInEgp,
    required double previousRateInEgp,
    required DateTime lastUpdated,
  }) = _CurrencyRate;

  double get absoluteChange => rateInEgp - previousRateInEgp;

  double get percentChange =>
      previousRateInEgp == 0 ? 0 : (absoluteChange / previousRateInEgp) * 100;

  bool get isEgpStrengthening => rateInEgp < previousRateInEgp;
}
