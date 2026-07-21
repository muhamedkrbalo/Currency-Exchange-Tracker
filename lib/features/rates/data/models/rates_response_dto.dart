import 'package:freezed_annotation/freezed_annotation.dart';

part 'rates_response_dto.freezed.dart';
part 'rates_response_dto.g.dart';

@freezed
abstract class RatesResponseDto with _$RatesResponseDto {
  const factory RatesResponseDto({
    required String date,
    required String base,
    required Map<String, double> rates,
  }) = _RatesResponseDto;

  factory RatesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RatesResponseDtoFromJson(json);

  factory RatesResponseDto.fromApi(
    Map<String, dynamic> json, {
    required String base,
  }) {
    final date = json['date'];
    final rawRates = json[base];
    if (date is! String || rawRates is! Map) {
      throw const FormatException('Unexpected currency API response shape');
    }
    final rates = <String, double>{
      for (final entry in rawRates.entries)
        if (entry.value is num)
          entry.key as String: (entry.value as num).toDouble(),
    };
    return RatesResponseDto(date: date, base: base, rates: rates);
  }
}
