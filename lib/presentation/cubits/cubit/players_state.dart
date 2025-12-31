part of 'players_cubit.dart';

@immutable
sealed class PlayersState {}

final class PlayersInitial extends PlayersState {}

final class PlayersLoading extends PlayersState {}

final class PlayersLoaded extends PlayersState {
  final PlayerResponse playerResponse;

  PlayersLoaded(this.playerResponse);
}

final class PlayersError extends PlayersState {
  final String message;

  PlayersError(this.message);
}
