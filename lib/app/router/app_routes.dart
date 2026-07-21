abstract final class AppRoutes {
  const AppRoutes._();

  static const String ratesName = 'rates';
  static const String ratesPath = '/';

  static const String currencyDetailName = 'currencyDetail';
  static const String currencyDetailPath = '/currency/:code';

  static String currencyDetail(String code) => '/currency/$code';
}
