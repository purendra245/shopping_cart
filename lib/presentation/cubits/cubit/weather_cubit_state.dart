part of 'weather_cubit.dart';

@immutable
sealed class WeatherCubitState {}

final class WeatherCubitInitial extends WeatherCubitState {}

final class WeatherCubitLoading extends WeatherCubitState {}

final class WeatherCubitLoaded extends WeatherCubitState {
  final WeatherEntity weather;
  WeatherCubitLoaded({required this.weather});
}

final class WeatherCubitError extends WeatherCubitState {
  final String message;

  WeatherCubitError({required this.message});
}
