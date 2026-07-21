import 'package:currency_exchange_tracker/core/error/failures.dart';
import 'package:currency_exchange_tracker/core/localization/app_localization.dart';
import 'package:currency_exchange_tracker/main.dart';
import 'package:currency_exchange_tracker/shared/formatters/failure_message_mapper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  Future<void> pumpLocalized(WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: AppLocalization.supported,
        path: AppLocalization.path,
        fallbackLocale: AppLocalization.fallback,
        startLocale: AppLocalization.english,
        child: const CurrencyExchangeApp(),
      ),
    );
    // Translation JSON loads asynchronously — wait for it before calling .tr().
    await tester.pumpAndSettle();
  }

  testWidgets(
    'ValidationFailure shows the server message when present',
    (tester) async {
      await pumpLocalized(tester);

      const failure = ValidationFailure({}, apiMessage: 'Invalid amount');
      expect(mapFailureToMessage(failure), 'Invalid amount');
    },
  );

  testWidgets(
    'ValidationFailure falls back to the localized key when apiMessage is blank',
    (tester) async {
      await pumpLocalized(tester);

      const failure = ValidationFailure({}, apiMessage: '   ');
      expect(
        mapFailureToMessage(failure),
        'Some values were rejected by the server.',
      );
    },
  );

  testWidgets(
    'ServerFailure ignores apiMessage and always uses the localized key',
    (tester) async {
      await pumpLocalized(tester);

      const failure = ServerFailure(apiMessage: 'stack trace: NullPointer...');
      expect(
        mapFailureToMessage(failure),
        'The server ran into a problem. Please try again.',
      );
    },
  );

  testWidgets(
    'NetworkFailure uses the localized key (no apiMessage possible)',
    (tester) async {
      await pumpLocalized(tester);

      const failure = NetworkFailure();
      expect(
        mapFailureToMessage(failure),
        'No internet connection. Check your network and try again.',
      );
    },
  );
}
