import 'package:equatable/equatable.dart';

import '../localization/locale_keys.dart';

class CurrencyInfo extends Equatable {
  const CurrencyInfo({required this.code, required this.nameKey});

  final String code;
  final String nameKey;

  String get responseKey => code.toLowerCase();

  @override
  List<Object?> get props => [code, nameKey];
}

abstract final class CurrencyCatalog {
  const CurrencyCatalog._();

  static const List<CurrencyInfo> targets = [
    CurrencyInfo(code: 'USD', nameKey: LocaleKeys.currencies_usd),
    CurrencyInfo(code: 'EUR', nameKey: LocaleKeys.currencies_eur),
    CurrencyInfo(code: 'GBP', nameKey: LocaleKeys.currencies_gbp),
    CurrencyInfo(code: 'SAR', nameKey: LocaleKeys.currencies_sar),
    CurrencyInfo(code: 'JPY', nameKey: LocaleKeys.currencies_jpy),
  ];

  static final List<String> targetCodes =
      List.unmodifiable(targets.map((currency) => currency.code));

  static final Map<String, CurrencyInfo> _byCode = {
    for (final currency in targets) currency.code: currency,
  };

  static CurrencyInfo? byCode(String code) => _byCode[code.toUpperCase()];

  static bool isTarget(String code) => _byCode.containsKey(code.toUpperCase());

  static String? nameKeyOf(String code) => byCode(code)?.nameKey;
}
