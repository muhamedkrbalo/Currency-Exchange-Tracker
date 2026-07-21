import 'package:dio/dio.dart' show CancelToken;

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/api_config.dart';
import '../../models/rates_response_dto.dart';

class CurrencyRemoteDataSource {
  const CurrencyRemoteDataSource(this._client, this._config);

  final ApiClient _client;
  final ApiConfig _config;

  Future<RatesResponseDto> getLatest({CancelToken? cancelToken}) async {
    final json = await _client.get<Map<String, dynamic>>(
      _config.latest(),
      cancelToken: cancelToken,
    );
    return RatesResponseDto.fromApi(json, base: ApiConfig.base);
  }

  Future<RatesResponseDto> getByDate(
    DateTime date, {
    CancelToken? cancelToken,
  }) async {
    final json = await _client.get<Map<String, dynamic>>(
      _config.onDate(date),
      cancelToken: cancelToken,
    );
    return RatesResponseDto.fromApi(json, base: ApiConfig.base);
  }
}
