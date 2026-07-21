import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/currency_rate.dart';

part 'rates_list_state.freezed.dart';

@freezed
sealed class RatesListState with _$RatesListState {
  const factory RatesListState.initial() = RatesListInitial;

  const factory RatesListState.loading() = RatesListLoading;

  const factory RatesListState.loaded({
    required List<CurrencyRate> rates,
    required bool isFromCache,
    DateTime? lastUpdated,
  }) = RatesListLoaded;

  const factory RatesListState.error(Failure failure) = RatesListError;
}
