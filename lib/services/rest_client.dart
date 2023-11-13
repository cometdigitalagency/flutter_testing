import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/user_model.dart';
part 'rest_client.g.dart';

@lazySingleton
@RestApi()
abstract class RestClient {
  @factoryMethod
  factory RestClient(Dio dio) = _RestClient;

  @GET('/users')
  Future<List<User>> getUserList();

  @GET('/users/{id}')
  Future<User> getUserDetail(@Path('id') int id);
}
