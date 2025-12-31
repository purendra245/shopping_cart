import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shopping_cart/data/models/player_response.dart';
import 'package:shopping_cart/utils/constants.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  @GET("players")
  Future<PlayerResponse> getPlayers(@Header("Authorization") String apiKey);
}
