import 'dart:io';

import 'package:burgan_app/models/user.dart';
import 'package:burgan_app/services/auth_services.dart';
import 'package:burgan_app/services/client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? user;

  void signup({
    required String email,
    required String password,
  }) async {
    var user = await AuthServices().signup(
      email: email,
      password: password,
    );
    notifyListeners();

    Client.dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", user!.username);
    prefs.setString("token", user!.token);
  }
}
