import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive_ce.dart';

import '../../app/theme/theme_cubit.dart';
import '../config/hive_boxes.dart';
import '../network/api_client.dart';
import '../network/api_config.dart';
import '../network/dio_api_client.dart';
import '../network/dio_client.dart';
import '../network_info/connectivity_network_info.dart';
import '../network_info/network_info.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  _registerCore();
}

void _registerCore() {
  getIt
    ..registerLazySingleton<ApiConfig>(() => const ApiConfig())
    ..registerLazySingleton<Dio>(() => const DioFactory().create())
    ..registerLazySingleton<ApiClient>(() => DioApiClient(getIt<Dio>()))
    ..registerLazySingleton<Connectivity>(() => Connectivity())
    ..registerLazySingleton<NetworkInfo>(
      () => ConnectivityNetworkInfo(getIt<Connectivity>()),
    )
    ..registerLazySingleton<Box>(() => Hive.box(HiveBoxes.settings))
    ..registerLazySingleton<ThemeCubit>(() => ThemeCubit(getIt<Box>()));
}
