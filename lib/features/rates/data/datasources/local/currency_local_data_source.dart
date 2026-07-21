import 'dart:convert';

import 'package:hive_ce/hive_ce.dart';

import '../../models/cached_rates.dart';
import '../../models/rates_response_dto.dart';

class CurrencyLocalDataSource {
  const CurrencyLocalDataSource(this._box);

  final Box<dynamic> _box;

  static const String _snapshotKey = 'snapshot';

  Future<void> cacheRates(RatesResponseDto rates, {DateTime? at}) async {
    final snapshot = CachedRates(
      rates: rates,
      lastUpdatedAt: at ?? DateTime.now(),
    );
    await _box.put(_snapshotKey, jsonEncode(snapshot.toJson()));
  }

  RatesResponseDto? getCachedRates() => _readSnapshot()?.rates;

  DateTime? getLastUpdated() => _readSnapshot()?.lastUpdatedAt;

  CachedRates? _readSnapshot() {
    final raw = _box.get(_snapshotKey);
    if (raw is! String) return null;
    return CachedRates.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}
