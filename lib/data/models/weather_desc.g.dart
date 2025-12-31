// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_desc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDesc _$WeatherDescFromJson(Map<String, dynamic> json) => WeatherDesc(
  main: json['main'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$WeatherDescToJson(WeatherDesc instance) =>
    <String, dynamic>{
      'main': instance.main,
      'description': instance.description,
    };
