import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shopping_cart/core/network/api_services.dart';
import 'package:shopping_cart/core/network/location_service.dart';
import 'package:shopping_cart/core/network/my_interceptor.dart';
import 'package:shopping_cart/domain/repositories/weather_location_repo.dart';
import 'package:shopping_cart/domain/repositories/weather_repository.dart';
import 'package:shopping_cart/data/repositories/weather_location_repo_impl.dart';
import 'package:shopping_cart/data/repositories/weather_repo_impl.dart';
import 'package:shopping_cart/domain/usecases/weather_location_use_case.dart';
import 'package:shopping_cart/domain/usecases/weather_use_cae.dart';
import 'package:shopping_cart/presentation/cubits/cubit/weather_cubit.dart';

final sl = GetIt.instance;

class Module {
  void init() {
    sl.registerLazySingleton<Dio>(
      () => Dio()..interceptors.add(MyInterceptor()),
    );
    //Services
    sl.registerLazySingleton<ApiService>(() => ApiService(sl()));

    // Repository
    sl.registerLazySingleton<WeatherRepository>(
      () => WeatherRepoImpl(apiService: sl()),
    );

    // UseCase

    sl.registerLazySingleton<WeatherUseCae>(
      () => WeatherUseCae(weatherRepository: sl()),
    );

    sl.registerLazySingleton<LocationService>(() => LocationService());

    sl.registerLazySingleton<WeatherLocationRepo>(
      () => WeatherLocationRepoImpl(locationService: sl()),
    );

    sl.registerLazySingleton<WeatherLocationUseCase>(
      () => WeatherLocationUseCase(weatherLocationRepo: sl()),
    );
    // Cubit
    sl.registerFactory<WeatherCubit>(
      () => WeatherCubit(weatherUseCase: sl(), weatherLocationUseCase: sl()),
    );
  }
}
