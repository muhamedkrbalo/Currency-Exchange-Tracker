import '../../../../core/result/result.dart';
import '../../../rates/domain/entities/historical_rate.dart';
import '../../../rates/domain/repositories/currency_repository.dart';

class GetCurrencyHistoryUseCase {
  const GetCurrencyHistoryUseCase(this._repository);

  final CurrencyRepository _repository;

  Future<Result<List<HistoricalRate>>> call(String code, {int days = 7}) =>
      _repository.getHistory(code, days: days);
}
