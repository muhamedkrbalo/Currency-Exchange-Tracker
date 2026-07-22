import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../../rates/domain/entities/historical_rate.dart';

part 'currency_detail_state.freezed.dart';

@freezed
sealed class CurrencyDetailState with _$CurrencyDetailState {
  const factory CurrencyDetailState.initial() = CurrencyDetailInitial;

  const factory CurrencyDetailState.loading() = CurrencyDetailLoading;

  const factory CurrencyDetailState.loaded(List<HistoricalRate> history) =
      CurrencyDetailLoaded;

  const factory CurrencyDetailState.error(Failure failure) =
      CurrencyDetailError;
}
