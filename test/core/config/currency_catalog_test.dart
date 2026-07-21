import 'package:currency_exchange_tracker/core/config/currency_catalog.dart';
import 'package:currency_exchange_tracker/core/localization/locale_keys.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('targets', () {
    test('lists the five task currencies in order', () {
      expect(
        CurrencyCatalog.targetCodes,
        ['USD', 'EUR', 'GBP', 'SAR', 'JPY'],
      );
    });

    test('maps each code to its localization key', () {
      expect(CurrencyCatalog.nameKeyOf('USD'), LocaleKeys.currencies_usd);
      expect(CurrencyCatalog.nameKeyOf('EUR'), LocaleKeys.currencies_eur);
      expect(CurrencyCatalog.nameKeyOf('GBP'), LocaleKeys.currencies_gbp);
      expect(CurrencyCatalog.nameKeyOf('SAR'), LocaleKeys.currencies_sar);
      expect(CurrencyCatalog.nameKeyOf('JPY'), LocaleKeys.currencies_jpy);
    });
  });

  group('byCode', () {
    test('is case-insensitive', () {
      expect(CurrencyCatalog.byCode('usd'), CurrencyCatalog.byCode('USD'));
      expect(
        CurrencyCatalog.byCode('usd'),
        const CurrencyInfo(code: 'USD', nameKey: LocaleKeys.currencies_usd),
      );
    });

    test('returns null for an unknown code', () {
      expect(CurrencyCatalog.byCode('CAD'), isNull);
      expect(CurrencyCatalog.nameKeyOf('CAD'), isNull);
    });
  });

  group('isTarget', () {
    test('is true for target currencies regardless of case', () {
      expect(CurrencyCatalog.isTarget('jpy'), isTrue);
      expect(CurrencyCatalog.isTarget('JPY'), isTrue);
    });

    test('is false for non-target currencies', () {
      expect(CurrencyCatalog.isTarget('CAD'), isFalse);
    });
  });

  group('responseKey', () {
    test('is the lowercase code used by the API rates map', () {
      expect(CurrencyCatalog.byCode('USD')!.responseKey, 'usd');
      expect(CurrencyCatalog.byCode('JPY')!.responseKey, 'jpy');
    });
  });
}
