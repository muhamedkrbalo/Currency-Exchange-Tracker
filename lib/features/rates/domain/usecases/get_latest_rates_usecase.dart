import '../../../../core/result/result.dart';
import '../entities/currency_rate.dart';
import '../repositories/currency_repository.dart';

class GetLatestRatesUseCase {
  const GetLatestRatesUseCase(this._repository);

  final CurrencyRepository _repository;

  Future<Result<List<CurrencyRate>>> call() => _repository.getLatestRates();
}
