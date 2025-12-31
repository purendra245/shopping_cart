import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:shopping_cart/utils/constant.dart';
import 'package:shopping_cart/data/models/weather_model.dart';
part 'api_services.g.dart';

@RestApi(baseUrl: Constant.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("weather")
  Future<WeatherModel> getWeather(
    @Query("q") String city,
    @Query("appid") String apiKey,
  );
}
