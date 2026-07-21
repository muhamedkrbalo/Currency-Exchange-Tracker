import 'rates_response_dto.dart';

class CachedRates {
  const CachedRates({required this.rates, required this.lastUpdatedAt});

  final RatesResponseDto rates;
  final DateTime lastUpdatedAt;

  Map<String, dynamic> toJson() => {
        'rates': rates.toJson(),
        'lastUpdatedAt': lastUpdatedAt.toIso8601String(),
      };

  factory CachedRates.fromJson(Map<String, dynamic> json) => CachedRates(
        rates: RatesResponseDto.fromJson(
          Map<String, dynamic>.from(json['rates'] as Map),
        ),
        lastUpdatedAt: DateTime.parse(json['lastUpdatedAt'] as String),
      );
}
