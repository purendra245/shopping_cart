import 'package:shopping_cart/data/repositories/weather_repository.dart';
import 'package:shopping_cart/domain/entities/weather_entity.dart';

class WeatherUseCae {
  final WeatherRepository weatherRepository;

  WeatherUseCae({required this.weatherRepository});

  Future<WeatherEntity> executeWeather(String city, String apiKey) async {
    return await weatherRepository.getWeather(city, apiKey);
  }
}
