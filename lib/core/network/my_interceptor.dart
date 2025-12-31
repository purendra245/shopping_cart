import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class MyInterceptor extends Interceptor {
  final logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i("URL: ${options.uri}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d("DATA: ${response.data}");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e("ERROR[${err.response?.statusCode}]: ${err.response?.data}");
    super.onError(err, handler);
  }
}
