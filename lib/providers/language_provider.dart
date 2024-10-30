import 'package:burgan_app/providers/language_provider.dart';
import 'package:burgan_app/translations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// magic code to translate strings
extension TranslateString on String {
  String get tr =>
      Translations.get(this, LanguageProvider._instance._languageCode);
}

class LanguageProvider with ChangeNotifier {
  String _languageCode = 'en';

  static late LanguageProvider _instance;

  String get languageCode => _languageCode;

  LanguageProvider() {
    //loadLanguage();
    _instance = this;
  }

  void setLanguage(String languageCode) {
    _languageCode = languageCode;
    _saveLanguage(languageCode);
    notifyListeners();
  }

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _languageCode = prefs.getString('selectedLanguage') ?? 'en';
    notifyListeners();
  }

  Future<void> _saveLanguage(String languageCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', languageCode);
  }
}
