import 'dart:io';
import 'package:burgan_app/services/auth_services.dart';
import 'package:burgan_app/services/client.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {}
  User? user;

  Future<void> signup({required String email, required String password}) async {
    user = await signupAPI(email, password);

    notifyListeners();

    dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    var prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user!.username);
    prefs.setString("token", user!.token);
  }

  Future<void> login({required String email, required String password}) async {
    user = await loginApi(email, password);

    notifyListeners();

    dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    var prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user!.username);
    prefs.setString("token", user!.token);
  }

  // Check if Face ID is enabled
  Future<bool> isFaceIDEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("faceIDEnabled") ?? false;
  }

  // Enable Face ID
  Future<void> enableFaceID() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("faceIDEnabled", true);
  }

  // Disable Face ID
  Future<void> disableFaceID() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("faceIDEnabled", false);
  }

  Future<void> loadPreviousUser() async {
    var prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var token = prefs.getString("token");

    if (username == null || token == null) {
      prefs.remove("username");
      prefs.remove("token");
      return;
    }

    dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";

    user = User(token: token, username: username);
    notifyListeners();
  }

  Future<void> loginWithCredentials(
      {required String email, required String password}) async {
    user = await loginApi(email, password);

    notifyListeners();

    dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    var prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user!.username);
    prefs.setString("token", user!.token);
  }

  Future<void> loadUser() async {
    var prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var token = prefs.getString("token");

    if (username == null || token == null) {
      prefs.remove("username");
      prefs.remove("token");
      return;
    }

    dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";

    user = User(token: token, username: username);
    notifyListeners();
  }
}
