import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../network/api_client.dart';
import '../network/api_config.dart';
import '../network/dio_api_client.dart';
import '../network/dio_client.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  _registerCore();
}

void _registerCore() {
  getIt
    ..registerLazySingleton<ApiConfig>(() => const ApiConfig())
    ..registerLazySingleton<Dio>(() => const DioFactory().create())
    ..registerLazySingleton<ApiClient>(() => DioApiClient(getIt<Dio>()));
}
