import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/web.dart';
import 'package:shopping_cart/core/api_services.dart';
import 'package:shopping_cart/data/repositories/players_repo_impl.dart';
import 'package:shopping_cart/domain/repositories/players_respostiory.dart';
import 'package:shopping_cart/domain/usecases/players_usecase.dart';
import 'package:shopping_cart/presentation/cubits/cubit/players_cubit.dart';

final sl = GetIt.instance;

class Module {
  void init() {
    final logger = Logger();

    sl.registerLazySingleton<ApiService>(
      () => ApiService(
        Dio()
          ..interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) {
                logger.i("Sending Request: ${options.path}");
                return handler.next(options);
              },
              onResponse: (response, handler) {
                logger.d("Received Response: ${response.data}");
                return handler.next(response);
              },
              onError: (DioException e, handler) {
                logger.e("Network Error: ${e.message}");
                return handler.next(e);
              },
            ),
          ),
      ),
    );
    sl.registerLazySingleton<PlayerRepository>(() => PlayerRepoImpl(sl()));
    sl.registerLazySingleton<PlayersUseCase>(() => PlayersUseCase(sl()));
    sl.registerFactory<PlayersCubit>(() => PlayersCubit(sl()));
  }
}
