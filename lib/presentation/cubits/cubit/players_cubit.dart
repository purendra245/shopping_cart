import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/data/models/player_response.dart';
import 'package:shopping_cart/domain/usecases/players_usecase.dart';

part 'players_state.dart';

class PlayersCubit extends Cubit<PlayersState> {
  final PlayersUseCase playersUseCase;
  PlayersCubit(this.playersUseCase) : super(PlayersInitial());

  void getPlayers() async {
    emit(PlayersLoading());
    try {
      final playerResponse = await playersUseCase.execute();
      emit(PlayersLoaded(playerResponse));
    } catch (e) {
      emit(PlayersError(e.toString()));
    }
  }
}
