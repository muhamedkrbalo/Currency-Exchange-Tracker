import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure_mapper.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network_info/network_info.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/currency_rate.dart';
import '../../domain/entities/historical_rate.dart';
import '../../domain/repositories/currency_repository.dart';
import '../datasources/local/currency_local_data_source.dart';
import '../datasources/remote/rates_remote_data_source.dart';
import '../mappers/rate_mapper.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  const CurrencyRepositoryImpl(
    this._remote,
    this._local,
    this._networkInfo, {
    this._mapper = const RateMapper(),
  });

  final CurrencyRemoteDataSource _remote;
  final CurrencyLocalDataSource _local;
  final NetworkInfo _networkInfo;
  final RateMapper _mapper;

  @override
  Stream<bool> get connectivity => _networkInfo.onStatusChange;

  @override
  Future<Result<List<CurrencyRate>>> getLatestRates() async {
    try {
      final today = await _remote.getLatest();
      final previousDay =
          DateTime.parse(today.date).subtract(const Duration(days: 1));
      final yesterday = await _remote.getByDate(previousDay);
      await _local.cacheRates(today);
      return Result.success(
        _mapper.toCurrencyRates(latest: today, previous: yesterday),
      );
    } on AppException catch (e) {
      return _recoverFromCache(mapExceptionToFailure(e));
    } catch (_) {
      return const Result.failure(UnknownFailure());
    }
  }

  @override
  Future<Result<List<HistoricalRate>>> getHistory(
    String code, {
    int days = 7,
  }) async {
    try {
      final today = DateTime.parse((await _remote.getLatest()).date);
      final snapshots = await Future.wait([
        for (var offset = 0; offset < days; offset++)
          _remote.getByDate(today.subtract(Duration(days: offset))),
      ]);
      return Result.success(_mapper.toHistoricalRates(snapshots, code));
    } on AppException catch (e) {
      return Result.failure(mapExceptionToFailure(e));
    } catch (_) {
      return const Result.failure(UnknownFailure());
    }
  }

  Result<List<CurrencyRate>> _recoverFromCache(Failure failure) {
    if (failure is NetworkFailure || failure is TimeoutFailure) {
      final cached = _local.getCachedRates();
      if (cached != null) {
        return Result.success(
          _mapper.toCurrencyRates(latest: cached, previous: cached),
        );
      }
    }
    return Result.failure(failure);
  }
}
