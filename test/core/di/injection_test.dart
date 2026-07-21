import 'package:currency_exchange_tracker/core/di/injection.dart';
import 'package:currency_exchange_tracker/core/network/api_client.dart';
import 'package:currency_exchange_tracker/core/network/api_config.dart';
import 'package:currency_exchange_tracker/core/network/dio_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() async {
    await getIt.reset();
  });

  test('registers ApiConfig, Dio and ApiClient', () async {
    await configureDependencies();

    expect(getIt.isRegistered<ApiConfig>(), isTrue);
    expect(getIt.isRegistered<Dio>(), isTrue);
    expect(getIt.isRegistered<ApiClient>(), isTrue);
    expect(getIt<ApiClient>(), isA<DioApiClient>());
  });

  test('ApiClient is injected with the registered Dio instance', () async {
    await configureDependencies();

    final dio = getIt<Dio>();
    final client = getIt<ApiClient>() as DioApiClient;
    expect(identical(client.dio, dio), isTrue);
  });

  test('lazy singletons resolve to the same instance every time', () async {
    await configureDependencies();

    expect(identical(getIt<ApiClient>(), getIt<ApiClient>()), isTrue);
    expect(identical(getIt<ApiConfig>(), getIt<ApiConfig>()), isTrue);
    expect(identical(getIt<Dio>(), getIt<Dio>()), isTrue);
  });
}
