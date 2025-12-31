// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  name: json['name'] as String,
  main: MainData.fromJson(json['main'] as Map<String, dynamic>),
  weather: (json['weather'] as List<dynamic>)
      .map((e) => WeatherDesc.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'main': instance.main,
      'weather': instance.weather,
    };
