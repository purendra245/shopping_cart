import 'package:shopping_cart/data/models/player_response.dart';
import 'package:shopping_cart/domain/repositories/players_respostiory.dart';
import 'package:shopping_cart/utils/constants.dart';

class PlayersUseCase {
  final PlayerRepository playerRepository;

  PlayersUseCase(this.playerRepository);

  Future<PlayerResponse> execute() async {
    return await playerRepository.getPlayers(Constants.apiKey);
  }
}