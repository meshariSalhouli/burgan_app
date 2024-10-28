import 'package:burgan_app/models/user.dart';
import 'package:burgan_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String token = "";
  User? user;

  void signup({required User user}) async {
    token = await AuthServices().signup(user: user);
    await setToken(token);
    notifyListeners();
  }

  void signin({required User user}) async {
    token = await AuthServices().signin(user: user);
    await setToken(token);
    notifyListeners();
  }

  void verifyToken() {
    if (token.isNotEmpty) {
      if (Jwt.getExpiryDate(token)!.isBefore(DateTime.now())) {
        token = "";
      } else {
        user = User.fromJson(Jwt.parseJwt(token));
      }
    }
  }

  void logout() {
    token = "";
    notifyListeners();
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }
}
