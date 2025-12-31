// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainData _$MainDataFromJson(Map<String, dynamic> json) => MainData(
  temp: (json['temp'] as num).toDouble(),
  feelsLike: (json['feels_like'] as num).toDouble(),
  tempMin: (json['temp_min'] as num).toDouble(),
  tempMax: (json['temp_max'] as num).toDouble(),
  pressure: (json['pressure'] as num).toInt(),
  humidity: (json['humidity'] as num).toInt(),
);

Map<String, dynamic> _$MainDataToJson(MainData instance) => <String, dynamic>{
  'temp': instance.temp,
  'feels_like': instance.feelsLike,
  'temp_min': instance.tempMin,
  'temp_max': instance.tempMax,
  'pressure': instance.pressure,
  'humidity': instance.humidity,
};
