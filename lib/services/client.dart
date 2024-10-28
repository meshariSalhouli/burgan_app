import 'package:dio/dio.dart';

class Client {
  static final _baseUrl = 'http://167.71.7.159/burgan-app';
  static final Dio dio = Dio(BaseOptions(baseUrl: _baseUrl));
}
