import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio(BaseOptions(
        contentType: 'application/json',
        baseUrl: 'https://jsonplaceholder.typicode.com/'));
    return dio;
  }
}
