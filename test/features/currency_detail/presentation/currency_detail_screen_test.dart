import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange_tracker/core/error/failures.dart';
import 'package:currency_exchange_tracker/core/localization/app_localization.dart';
import 'package:currency_exchange_tracker/features/currency_detail/presentation/cubit/currency_detail_cubit.dart';
import 'package:currency_exchange_tracker/features/currency_detail/presentation/cubit/currency_detail_state.dart';
import 'package:currency_exchange_tracker/features/currency_detail/presentation/screens/currency_detail_screen.dart';
import 'package:currency_exchange_tracker/features/currency_detail/presentation/widgets/history_line_chart.dart';
import 'package:currency_exchange_tracker/features/rates/domain/entities/historical_rate.dart';
import 'package:currency_exchange_tracker/shared/theme/app_theme.dart';
import 'package:currency_exchange_tracker/shared/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _MockCurrencyDetailCubit extends MockCubit<CurrencyDetailState>
    implements CurrencyDetailCubit {}

void main() {
  late _MockCurrencyDetailCubit cubit;

  final history = [
    HistoricalRate(date: DateTime(2026, 7, 19), rateInEgp: 50),
    HistoricalRate(date: DateTime(2026, 7, 20), rateInEgp: 51),
    HistoricalRate(date: DateTime(2026, 7, 21), rateInEgp: 52),
  ];

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
    cubit = _MockCurrencyDetailCubit();
  });

  Future<void> pumpScreen(
    WidgetTester tester,
    CurrencyDetailState state,
  ) async {
    whenListen(
      cubit,
      const Stream<CurrencyDetailState>.empty(),
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
          home: BlocProvider<CurrencyDetailCubit>.value(
            value: cubit,
            child: const CurrencyDetailScreen(code: 'usd'),
          ),
        ),
      ),
    );
    await tester.runAsync(() async {
      await tester.pumpWidget(widget);
      await Future<void>.delayed(const Duration(milliseconds: 100));
    });
    await tester.pump();
  }

  testWidgets('shows a shimmer placeholder while loading', (tester) async {
    await pumpScreen(tester, const CurrencyDetailState.loading());
    expect(find.byType(ShimmerBox), findsWidgets);
    expect(find.byType(HistoryLineChart), findsNothing);
  });

  testWidgets('renders the 7-day chart when loaded', (tester) async {
    await pumpScreen(tester, CurrencyDetailState.loaded(history));
    expect(find.byType(HistoryLineChart), findsOneWidget);
  });

  testWidgets('shows the empty view when history is empty', (tester) async {
    await pumpScreen(tester, const CurrencyDetailState.loaded([]));
    expect(find.byType(EmptyView), findsOneWidget);
    expect(find.byType(HistoryLineChart), findsNothing);
  });

  testWidgets('shows an error message with a working retry', (tester) async {
    when(() => cubit.load(any())).thenAnswer((_) async {});
    await pumpScreen(tester, const CurrencyDetailState.error(ServerFailure()));

    expect(find.byType(ErrorView), findsOneWidget);

    await tester.tap(find.byType(AppButton));
    verify(() => cubit.load('usd')).called(1);
  });
}
