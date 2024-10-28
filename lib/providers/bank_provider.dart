import 'package:flutter/material.dart';

class Bankprovider extends ChangeNotifier {
  // Profile fields
  String? _username;
  String? _email;
  String? _password;
  String? _profileImage; // Add profileImage field
  bool _isLoggedIn = false;

  // Getters for profile fields
  String? get username => _username;
  String? get email => _email;
  String? get password => _password;
  String? get profileImage => _profileImage; // Getter for profile image
  bool get isLoggedIn => _isLoggedIn;

  // Method to update profile information
  void updateProfile(
    String username,
    String email,
    String password,
  ) {
    _username = username;
    _email = email;
    _password = password;
    notifyListeners(); // Notify listeners that data has changed
  }

  // Method to log in and check credentials
  bool login(String username, String password) {
    if (_username == username && _password == password) {
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }
}
