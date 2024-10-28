import 'package:burgan_app/models/user.dart';
import 'package:burgan_app/services/client.dart';
import 'package:dio/dio.dart';

class AuthServices {
  Future<User> signup({
    required String email,
    required String password,
  }) async {
    Response response = await Client.dio.post('/signup', data: {
      "email": email,
      "password": password,
    });
    if (response.statusCode != 200) {
      throw response.data is Map
          ? response.data['message']
          : "Unexpected server error";
    }
    var user = User.fromjson(response.data['data']);
    print(response.statusCode);

    return user;
  }
}
