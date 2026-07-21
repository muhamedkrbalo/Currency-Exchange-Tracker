
class ApiConfig {
  const ApiConfig();

  static const String _basePath = '/v1/currencies';

  static const String base = 'egp';

  Uri latest() => Uri.parse(
        'https://latest.currency-api.pages.dev$_basePath/$base.json',
      );

  Uri onDate(DateTime date) => Uri.parse(
        'https://${_ymd(date)}.currency-api.pages.dev$_basePath/$base.json',
      );

  static String _ymd(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }
}
