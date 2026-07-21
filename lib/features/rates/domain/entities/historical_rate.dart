import 'package:freezed_annotation/freezed_annotation.dart';

part 'historical_rate.freezed.dart';

@freezed
abstract class HistoricalRate with _$HistoricalRate {
  const factory HistoricalRate({
    required DateTime date,
    required double rateInEgp,
  }) = _HistoricalRate;
}
