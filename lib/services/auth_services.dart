import 'package:burgan_app/models/user.dart';
import 'package:burgan_app/services/client.dart';

// Future<User> signupAPI(String email, String password) async =>
//     _authenticate("/signup", email, password);

Future<User> signupAPI(String email, String password) async {
  var response = await dio.post("/signup", data: {
    "email": email,
    "password": password,
  });

  return User.fromjson(response.data['data']);
}

Future<User> loginApi(String email, String password) async {
  var response = await dio.post("/login", data: {
    "email": email,
    "password": password,
  });

  return User.fromjson(response.data['data']);
}

// Future<User> _authenticate(String path, String email, String password) async {
//   var response = await dio.post(path, data: {
//     "email": email,
//     "password": password,
//   }); 

//   return User.fromjson(response.data['data']);
// }
