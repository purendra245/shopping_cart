import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_cart/di/module.dart';
import 'package:shopping_cart/domain/entities/weather_entity.dart';
import 'package:shopping_cart/presentation/cubits/cubit/weather_cubit.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  String getWeatherCondition(String condition) {
    switch (condition) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
        return 'assets/cloud.json';
      case 'rain':
      case 'dizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WeatherCubit>()..fetchWeatherForCurrentLocation(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: BlocBuilder<WeatherCubit, WeatherCubitState>(
          builder: (context, state) {
            if (state is WeatherCubitLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WeatherCubitError) {
              return Center(child: Text(state.message));
            }
            if (state is WeatherCubitLoaded) {
              final weather = state.weather;
              return _buildWeather(context, weather);
            }
            return const Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWeather(BuildContext context, WeatherEntity weather) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Icon(
              Icons.map,
              size: 100,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(height: 10),
            Text(
              weather.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            Lottie.asset(
              getWeatherCondition(weather.mainCondition.toLowerCase()),
            ),
            Text(
              '${weather.temperature.round()}°C',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
