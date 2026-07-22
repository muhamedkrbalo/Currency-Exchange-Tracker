import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../../features/currency_detail/presentation/cubit/currency_detail_cubit.dart';
import '../../features/currency_detail/presentation/screens/currency_detail_screen.dart';
import '../../features/rates/presentation/cubit/rates_list_cubit.dart';
import '../../features/rates/presentation/screens/rates_list_screen.dart';
import 'app_routes.dart';

abstract final class AppRouter {
  const AppRouter._();

  static GoRouter create() {
    return GoRouter(
      initialLocation: AppRoutes.ratesPath,
      routes: [
        GoRoute(
          path: AppRoutes.ratesPath,
          name: AppRoutes.ratesName,
          builder: (context, state) => BlocProvider<RatesListCubit>(
            create: (_) => getIt<RatesListCubit>()..load(),
            child: const RatesListScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.currencyDetailPath,
          name: AppRoutes.currencyDetailName,
          builder: (context, state) {
            final code = state.pathParameters['code'] ?? '';
            return BlocProvider<CurrencyDetailCubit>(
              create: (_) => getIt<CurrencyDetailCubit>()..load(code),
              child: CurrencyDetailScreen(code: code),
            );
          },
        ),
      ],
    );
  }
}
