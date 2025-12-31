import 'package:json_annotation/json_annotation.dart';
import 'package:shopping_cart/data/models/main_data.dart';
import 'package:shopping_cart/data/models/weather_desc.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final String name;
  final MainData main;
  final List<WeatherDesc> weather;

  WeatherModel({required this.name, required this.main, required this.weather});

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
