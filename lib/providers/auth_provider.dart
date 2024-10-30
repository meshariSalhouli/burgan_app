import 'dart:io';
import 'package:burgan_app/services/auth_services.dart';
import 'package:burgan_app/services/client.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  bool _isUserLoggedInBefore = false; // if logged in previously

  bool get isUserLoggedInBefore => _isUserLoggedInBefore;

  // Local authentication instance
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> signup({required String email, required String password}) async {
    user = await signupAPI(email, password);

    notifyListeners();

    dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    var prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user!.username);
    prefs.setString("token", user!.token);
    _isUserLoggedInBefore = true; // Update login state after successful signup
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
    _isUserLoggedInBefore = true; // User has previously logged in

    notifyListeners();
  }

  Future<void> login({required String email, required String password}) async {
    user = await loginApi(email, password);

    notifyListeners();

    // dio.options.headers[HttpHeaders.authorizationHeader] =
    //     "Bearer ${user!.token}";
    dio.options.headers[HttpHeaders.authorizationHeader] =
        "Bearer ${user!.token}";

    var prefs = await SharedPreferences.getInstance();
    prefs.setString("username", user!.username);
    prefs.setString("token", user!.token);
    _isUserLoggedInBefore = true; // Update login state after successful login
  }

  // Method for Face ID authentication
  Future<bool> authenticateWithFaceID() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to proceed',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      print("Authentication error: $e");
    }
    return isAuthenticated;
  }

  // Method to log in using the previously stored token if biometric authentication is valid
  Future<void> loginWithStoredCredentials() async {
    var prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    var token = prefs.getString("token");

    if (username != null && token != null) {
      dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
      user = User(token: token, username: username);
      notifyListeners();
    } else {
      // If no previous credentials, prompt regular login
      print("No stored credentials found.");
    }
  }

  // Method for Face ID button to trigger login if user has logged in previously
  Future<void> tryFaceIDLogin() async {
    if (_isUserLoggedInBefore) {
      bool isAuthenticated = await authenticateWithFaceID();
      if (isAuthenticated) {
        await loginWithStoredCredentials();
      } else {
        print("Face ID authentication failed.");
      }
    }
  }

  void loogyui() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    user = null;
    dio.options.headers.remove(HttpHeaders.authorizationHeader);
  }
}

  // Future<void> loadUser() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   var username = prefs.getString("username");
  //   var token = prefs.getString("token");

  //   if (username == null || token == null) {
  //     prefs.remove("username");
  //     prefs.remove("token");
  //     return;
  //   }

  //   dio.options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";

  //   user = User(token: token, username: username);
  //   notifyListeners();
  // }



