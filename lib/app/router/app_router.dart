import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import 'route_placeholder.dart';

abstract final class AppRouter {
  const AppRouter._();

  static GoRouter create() {
    return GoRouter(
      initialLocation: AppRoutes.ratesPath,
      routes: [
        GoRoute(
          path: AppRoutes.ratesPath,
          name: AppRoutes.ratesName,
          builder: (context, state) =>
              const RoutePlaceholder(title: AppRoutes.ratesName),
        ),
        GoRoute(
          path: AppRoutes.currencyDetailPath,
          name: AppRoutes.currencyDetailName,
          builder: (context, state) =>
              RoutePlaceholder(title: state.pathParameters['code'] ?? ''),
        ),
      ],
    );
  }
}
