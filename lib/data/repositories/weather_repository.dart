import 'package:shopping_cart/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getWeather(String city,String apiKey);
}
