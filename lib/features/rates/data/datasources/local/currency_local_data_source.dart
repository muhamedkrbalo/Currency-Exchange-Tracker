import 'dart:convert';

import 'package:hive_ce/hive_ce.dart';

import '../../models/cached_rates.dart';
import '../../models/rates_response_dto.dart';

class CurrencyLocalDataSource {
  const CurrencyLocalDataSource(this._box);

  final Box<dynamic> _box;

  static const String _snapshotKey = 'snapshot';
  static const String _previousSnapshotKey = 'previous_snapshot';

  Future<void> cacheRates(
    RatesResponseDto rates, {
    RatesResponseDto? previous,
    DateTime? at,
  }) async {
    final snapshot = CachedRates(
      rates: rates,
      lastUpdatedAt: at ?? DateTime.now(),
    );
    await _box.put(_snapshotKey, jsonEncode(snapshot.toJson()));
    if (previous != null) {
      final previousSnapshot = CachedRates(
        rates: previous,
        lastUpdatedAt: at ?? DateTime.now(),
      );
      await _box.put(
        _previousSnapshotKey,
        jsonEncode(previousSnapshot.toJson()),
      );
    }
  }

  RatesResponseDto? getCachedRates() => _readSnapshot(_snapshotKey)?.rates;

  RatesResponseDto? getCachedPreviousRates() =>
      _readSnapshot(_previousSnapshotKey)?.rates;

  DateTime? getLastUpdated() => _readSnapshot(_snapshotKey)?.lastUpdatedAt;

  CachedRates? _readSnapshot(String key) {
    final raw = _box.get(key);
    if (raw is! String) return null;
    return CachedRates.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}
