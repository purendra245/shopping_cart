import 'package:shopping_cart/core/network/location_service.dart';
import 'package:shopping_cart/domain/repositories/weather_location_repo.dart';

class WeatherLocationRepoImpl extends WeatherLocationRepo {
  final LocationService locationService;
  WeatherLocationRepoImpl({required this.locationService});

  @override
  Future<String> getCurrentCity() async {
    return await locationService.getCurrentCity();
  }
}
