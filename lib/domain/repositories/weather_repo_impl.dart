import 'package:shopping_cart/core/network/api_services.dart';
import 'package:shopping_cart/data/repositories/weather_repository.dart';
import 'package:shopping_cart/domain/entities/weather_entity.dart';
import 'package:logger/logger.dart';

class WeatherRepoImpl implements WeatherRepository {
  final ApiService apiService;

  WeatherRepoImpl({required this.apiService});

  @override
  Future<WeatherEntity> getWeather(String city, String apiKey) async {
    try {
      final weatherModel = await apiService.getWeather(city, apiKey);
      return WeatherEntity(
        name: weatherModel.name,
        temperature: weatherModel.main.temp,
        mainCondition: weatherModel.weather.first.main,
      );
    } catch (e, stacktrace) {
      final logger = Logger();
      // This will show you exactly where the failure happened in the mapping
      logger.e("Mapping Error", error: e, stackTrace: stacktrace);
      return WeatherEntity(name: "", temperature: 0, mainCondition: "");
    }
  }
}
