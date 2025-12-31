import 'package:json_annotation/json_annotation.dart';

part 'main_data.g.dart';

@JsonSerializable()
class MainData {
  final double temp;
  @JsonKey(name: "feels_like")
  final double feelsLike;
  @JsonKey(name: "temp_min")
  final double tempMin;
  @JsonKey(name: "temp_max")
  final double tempMax;
  final int pressure;
  final int humidity;

  MainData({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });

  factory MainData.fromJson(Map<String, dynamic> json) =>
      _$MainDataFromJson(json);
  Map<String, dynamic> toJson() => _$MainDataToJson(this);
}
