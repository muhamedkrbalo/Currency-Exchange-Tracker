import 'package:currency_exchange_tracker/app/router/app_router.dart';
import 'package:currency_exchange_tracker/app/router/app_routes.dart';
import 'package:currency_exchange_tracker/app/router/route_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  Future<GoRouter> pumpRouter(WidgetTester tester) async {
    final router = AppRouter.create();
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();
    return router;
  }

  testWidgets('starts on the rates route', (tester) async {
    await pumpRouter(tester);

    expect(find.byType(RoutePlaceholder), findsOneWidget);
    expect(find.widgetWithText(AppBar, AppRoutes.ratesName), findsOneWidget);
  });

  testWidgets('navigates to the currency detail route with its code path param',
      (tester) async {
    final router = await pumpRouter(tester);

    router.go(AppRoutes.currencyDetail('USD'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'USD'), findsOneWidget);
  });

  testWidgets('resolves the detail route by name with path parameters',
      (tester) async {
    final router = await pumpRouter(tester);

    router.goNamed(
      AppRoutes.currencyDetailName,
      pathParameters: {'code': 'EUR'},
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'EUR'), findsOneWidget);
  });
}
