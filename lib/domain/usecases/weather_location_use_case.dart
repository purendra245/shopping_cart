import 'package:shopping_cart/data/repositories/weather_location_repo.dart';

class WeatherLocationUseCase {
  final WeatherLocationRepo weatherLocationRepo;
  WeatherLocationUseCase({required this.weatherLocationRepo});

  Future<String> getCurrentCity() async {
    return await weatherLocationRepo.getCurrentCity();
  }
}
