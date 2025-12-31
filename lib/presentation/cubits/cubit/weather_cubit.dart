import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopping_cart/domain/entities/weather_entity.dart';
import 'package:shopping_cart/domain/usecases/weather_location_use_case.dart';
import 'package:shopping_cart/domain/usecases/weather_use_cae.dart';
import 'package:shopping_cart/utils/constant.dart';
part 'weather_cubit_state.dart';

class WeatherCubit extends Cubit<WeatherCubitState> {
  final WeatherUseCae weatherUseCase;
  final WeatherLocationUseCase weatherLocationUseCase;
  WeatherCubit({
    required this.weatherUseCase,
    required this.weatherLocationUseCase,
  }) : super(WeatherCubitInitial());

  Future<void> fetchWeatherForCurrentLocation() async {
    emit(WeatherCubitLoading());
    try {
      final currentCity = await weatherLocationUseCase.getCurrentCity();
      final weather = await weatherUseCase.executeWeather(
        currentCity,
        Constant.apiKey,
      );
      emit(WeatherCubitLoaded(weather: weather));
    } catch (e) {
      emit(WeatherCubitError(message: e.toString()));
    }
  }
}
