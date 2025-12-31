import 'package:json_annotation/json_annotation.dart';

part 'weather_desc.g.dart';

@JsonSerializable()
class WeatherDesc {
  final String main;
  final String description;

  WeatherDesc({required this.main, required this.description});
  factory WeatherDesc.fromJson(Map<String, dynamic> json) =>
      _$WeatherDescFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDescToJson(this);
}
