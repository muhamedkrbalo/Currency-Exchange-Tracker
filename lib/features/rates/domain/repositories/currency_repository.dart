import '../../../../core/result/result.dart';
import '../entities/currency_rate.dart';
import '../entities/historical_rate.dart';

abstract interface class CurrencyRepository {
  Future<Result<List<CurrencyRate>>> getLatestRates();

  Future<Result<List<HistoricalRate>>> getHistory(String code, {int days = 7});

  Stream<bool> get connectivity;
}
