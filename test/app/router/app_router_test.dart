import 'package:currency_exchange_tracker/app/router/app_router.dart';
import 'package:currency_exchange_tracker/app/router/app_routes.dart';
import 'package:currency_exchange_tracker/core/di/injection.dart';
import 'package:currency_exchange_tracker/core/localization/app_localization.dart';
import 'package:currency_exchange_tracker/features/rates/presentation/cubit/rates_list_cubit.dart';
import 'package:currency_exchange_tracker/features/rates/presentation/cubit/rates_list_state.dart';
import 'package:currency_exchange_tracker/features/rates/presentation/screens/rates_list_screen.dart';
import 'package:currency_exchange_tracker/shared/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeRatesListCubit extends Cubit<RatesListState>
    implements RatesListCubit {
  _FakeRatesListCubit()
    : super(const RatesListState.loaded(rates: [], isFromCache: false));

  @override
  Future<void> load() async {}

  @override
  Future<void> refresh() async {}
}

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    getIt.registerFactory<RatesListCubit>(_FakeRatesListCubit.new);
  });

  tearDown(getIt.reset);

  Future<GoRouter> pumpRouter(WidgetTester tester) async {
    final router = AppRouter.create();
    final app = EasyLocalization(
      supportedLocales: AppLocalization.supported,
      path: AppLocalization.path,
      fallbackLocale: AppLocalization.fallback,
      startLocale: AppLocalization.english,
      child: Builder(
        builder: (context) => MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.light(),
          routerConfig: router,
        ),
      ),
    );
    // Translations load via real async asset I/O.
    await tester.runAsync(() async {
      await tester.pumpWidget(app);
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pumpAndSettle();
    return router;
  }

  testWidgets('starts on the rates list screen', (tester) async {
    await pumpRouter(tester);

    expect(find.byType(RatesListScreen), findsOneWidget);
  });

  testWidgets(
    'navigates to the currency detail route with its code path param',
    (tester) async {
      final router = await pumpRouter(tester);

      router.go(AppRoutes.currencyDetail('USD'));
      await tester.pumpAndSettle();

      expect(find.widgetWithText(AppBar, 'USD'), findsOneWidget);
    },
  );

  testWidgets('resolves the detail route by name with path parameters', (
    tester,
  ) async {
    final router = await pumpRouter(tester);

    router.goNamed(
      AppRoutes.currencyDetailName,
      pathParameters: {'code': 'EUR'},
    );
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'EUR'), findsOneWidget);
  });
}
