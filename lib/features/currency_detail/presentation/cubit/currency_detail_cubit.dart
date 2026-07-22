import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/result/result.dart';
import '../../domain/usecases/get_currency_history_usecase.dart';
import 'currency_detail_state.dart';

class CurrencyDetailCubit extends Cubit<CurrencyDetailState> {
  CurrencyDetailCubit(this._getHistory)
    : super(const CurrencyDetailState.initial());

  final GetCurrencyHistoryUseCase _getHistory;

  Future<void> load(String code) async {
    emit(const CurrencyDetailState.loading());

    final result = await _getHistory(code);
    if (isClosed) return;

    switch (result) {
      case Success(:final value):
        emit(CurrencyDetailState.loaded(value));
      case FailureResult(:final failure):
        emit(CurrencyDetailState.error(failure));
    }
  }
}
