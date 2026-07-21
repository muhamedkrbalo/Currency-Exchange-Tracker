import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network_info/network_info.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/currency_rate.dart';
import '../../domain/usecases/get_latest_rates_usecase.dart';
import 'rates_list_state.dart';

class RatesListCubit extends Cubit<RatesListState> {
  RatesListCubit(this._getLatestRates, this._networkInfo)
    : super(const RatesListState.initial());

  final GetLatestRatesUseCase _getLatestRates;
  final NetworkInfo _networkInfo;

  Future<void> load() => _fetch(showLoading: true);

  Future<void> refresh() => _fetch(showLoading: false);

  Future<void> _fetch({required bool showLoading}) async {
    if (showLoading) emit(const RatesListState.loading());

    final result = await _getLatestRates();
    if (isClosed) return;

    switch (result) {
      case Success(:final value):
        final online = await _networkInfo.isConnected;
        if (isClosed) return;
        emit(
          RatesListState.loaded(
            rates: value,
            isFromCache: !online,
            lastUpdated: _lastUpdatedOf(value),
          ),
        );
      case FailureResult(:final failure):
        emit(RatesListState.error(failure));
    }
  }

  DateTime? _lastUpdatedOf(List<CurrencyRate> rates) =>
      rates.isEmpty ? null : rates.first.lastUpdated;
}
