
// ignore_for_file: constant_identifier_names
// Snake_case keys mirror the easy_localization codegen convention so this class
// stays drop-in compatible if code generation is enabled later.

abstract final class LocaleKeys {
  const LocaleKeys._();

  // App
  static const String app_title = 'app.title';

  // Language switcher
  static const String language_label = 'language.label';
  static const String language_english = 'language.english';
  static const String language_arabic = 'language.arabic';

  // Rates list
  static const String rates_title = 'rates.title';
  static const String rates_base_hint = 'rates.base_hint';
  static const String rates_unit_format = 'rates.unit_format';
  static const String rates_empty = 'rates.empty';
  static const String rates_pull_to_refresh = 'rates.pull_to_refresh';

  // Currency detail
  static const String detail_title = 'detail.title';
  static const String detail_current_rate = 'detail.current_rate';
  static const String detail_daily_change = 'detail.daily_change';
  static const String detail_last_update = 'detail.last_update';
  static const String detail_chart_title = 'detail.chart_title';
  static const String detail_chart_empty = 'detail.chart_empty';

  // Offline / cache
  static const String offline_banner = 'offline.banner';
  static const String offline_last_updated = 'offline.last_updated';

  // Daily change direction
  static const String change_egp_stronger = 'change.egp_stronger';
  static const String change_egp_weaker = 'change.egp_weaker';

  // Common
  static const String common_retry = 'common.retry';
  static const String common_loading = 'common.loading';
  static const String common_cancel = 'common.cancel';
  static const String common_ok = 'common.ok';

  // Error messages (one per Failure type)
  static const String errors_server = 'errors.server';
  static const String errors_network = 'errors.network';
  static const String errors_timeout = 'errors.timeout';
  static const String errors_not_found = 'errors.not_found';
  static const String errors_unauthorized = 'errors.unauthorized';
  static const String errors_forbidden = 'errors.forbidden';
  static const String errors_validation = 'errors.validation';
  static const String errors_cache = 'errors.cache';
  static const String errors_unknown = 'errors.unknown';

  // Currency display names (keyed by lowercase code)
  static const String currencies_usd = 'currencies.usd';
  static const String currencies_eur = 'currencies.eur';
  static const String currencies_gbp = 'currencies.gbp';
  static const String currencies_sar = 'currencies.sar';
  static const String currencies_jpy = 'currencies.jpy';
}
