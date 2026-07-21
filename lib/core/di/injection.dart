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
import '../../features/rates/data/datasources/local/currency_local_data_source.dart';
import '../../features/rates/data/datasources/remote/rates_remote_data_source.dart';
import '../../features/rates/data/repositories/currency_repository_impl.dart';
import '../../features/rates/domain/repositories/currency_repository.dart';
import '../../features/rates/domain/usecases/get_latest_rates_usecase.dart';
import '../../features/rates/presentation/cubit/rates_list_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  _registerCore();
  _registerRates();
}

void _registerRates() {
  getIt
    ..registerLazySingleton<CurrencyLocalDataSource>(
      () => CurrencyLocalDataSource(Hive.box<dynamic>(HiveBoxes.ratesCache)),
    )
    ..registerLazySingleton<CurrencyRemoteDataSource>(
      () => CurrencyRemoteDataSource(getIt<ApiClient>(), getIt<ApiConfig>()),
    )
    ..registerLazySingleton<CurrencyRepository>(
      () => CurrencyRepositoryImpl(
        getIt<CurrencyRemoteDataSource>(),
        getIt<CurrencyLocalDataSource>(),
        getIt<NetworkInfo>(),
      ),
    )
    ..registerLazySingleton<GetLatestRatesUseCase>(
      () => GetLatestRatesUseCase(getIt<CurrencyRepository>()),
    )
    ..registerFactory<RatesListCubit>(
      () => RatesListCubit(getIt<GetLatestRatesUseCase>(), getIt<NetworkInfo>()),
    );
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
