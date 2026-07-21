// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rates_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RatesResponseDto _$RatesResponseDtoFromJson(Map<String, dynamic> json) =>
    _RatesResponseDto(
      date: json['date'] as String,
      base: json['base'] as String,
      rates: (json['rates'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$RatesResponseDtoToJson(_RatesResponseDto instance) =>
    <String, dynamic>{
      'date': instance.date,
      'base': instance.base,
      'rates': instance.rates,
    };
