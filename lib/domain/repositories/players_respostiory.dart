import 'package:shopping_cart/data/models/player_response.dart';

abstract class PlayerRepository {
  Future<PlayerResponse> getPlayers(String apiKey);
}
