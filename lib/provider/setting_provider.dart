import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;

  void changeAppTheme(ThemeMode newMode) async {
    if (newMode == appTheme) {
      return;
    }
    appTheme = newMode;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', newMode == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }

  void changeAppLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', newLanguage);
    notifyListeners();
  }
}
