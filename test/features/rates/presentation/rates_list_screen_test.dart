import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange_tracker/core/error/failures.dart';
import 'package:currency_exchange_tracker/core/localization/app_localization.dart';
import 'package:currency_exchange_tracker/features/rates/domain/entities/currency_rate.dart';
import 'package:currency_exchange_tracker/features/rates/presentation/cubit/rates_list_cubit.dart';
import 'package:currency_exchange_tracker/features/rates/presentation/cubit/rates_list_state.dart';
import 'package:currency_exchange_tracker/features/rates/presentation/screens/rates_list_screen.dart';
import 'package:currency_exchange_tracker/features/rates/presentation/widgets/rate_tile.dart';
import 'package:currency_exchange_tracker/shared/theme/app_theme.dart';
import 'package:currency_exchange_tracker/shared/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockRatesListCubit extends MockCubit<RatesListState>
    implements RatesListCubit {}

CurrencyRate _rate(String code) => CurrencyRate(
  code: code,
  name: code.toUpperCase(),
  rateInEgp: 48,
  previousRateInEgp: 47,
  lastUpdated: DateTime(2026, 7, 21),
);

void main() {
  late _MockRatesListCubit cubit;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    cubit = _MockRatesListCubit();
  });

  Future<void> pumpScreen(WidgetTester tester, RatesListState state) async {
    whenListen(
      cubit,
      const Stream<RatesListState>.empty(),
      initialState: state,
    );
    final widget = EasyLocalization(
      supportedLocales: AppLocalization.supported,
      path: AppLocalization.path,
      fallbackLocale: AppLocalization.fallback,
      startLocale: AppLocalization.english,
      child: Builder(
        builder: (context) => MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.light(),
          home: BlocProvider<RatesListCubit>.value(
            value: cubit,
            child: const RatesListScreen(),
          ),
        ),
      ),
    );
    // Translation JSON loads via real async asset I/O; runAsync lets it
    // complete before we settle the frame (pumpAndSettle alone hangs on the
    // loading spinner and races the async load).
    await tester.runAsync(() async {
      await tester.pumpWidget(widget);
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pump();
  }

  testWidgets('shows LoadingView while loading', (tester) async {
    await pumpScreen(tester, const RatesListState.loading());
    expect(find.byType(LoadingView), findsOneWidget);
  });

  testWidgets('shows ErrorView on failure with a working retry', (
    tester,
  ) async {
    when(() => cubit.load()).thenAnswer((_) async {});
    await pumpScreen(tester, const RatesListState.error(NetworkFailure()));

    expect(find.byType(ErrorView), findsOneWidget);

    await tester.tap(find.byType(AppButton));
    verify(() => cubit.load()).called(1);
  });

  testWidgets('shows EmptyView when loaded with no rates', (tester) async {
    await pumpScreen(
      tester,
      const RatesListState.loaded(rates: [], isFromCache: false),
    );
    expect(find.byType(EmptyView), findsOneWidget);
  });

  testWidgets('renders a tile per rate when loaded', (tester) async {
    await pumpScreen(
      tester,
      RatesListState.loaded(
        rates: [_rate('usd'), _rate('eur')],
        isFromCache: false,
      ),
    );
    expect(find.byType(RateTile), findsNWidgets(2));
  });

  testWidgets('pull-to-refresh triggers refresh()', (tester) async {
    when(() => cubit.refresh()).thenAnswer((_) async {});
    await pumpScreen(
      tester,
      RatesListState.loaded(rates: [_rate('usd')], isFromCache: false),
    );

    await tester.fling(find.byType(RateTile), const Offset(0, 400), 1000);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    verify(() => cubit.refresh()).called(1);
  });
}
