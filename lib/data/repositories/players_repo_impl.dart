import 'package:shopping_cart/core/api_services.dart';
import 'package:shopping_cart/data/models/player_response.dart';
import 'package:shopping_cart/domain/repositories/players_respostiory.dart';

class PlayerRepoImpl implements PlayerRepository {
  final ApiService apiService;

  PlayerRepoImpl(this.apiService);

  @override
  Future<PlayerResponse> getPlayers(String apiKey) async {
    return await apiService.getPlayers(apiKey);
  }
}
