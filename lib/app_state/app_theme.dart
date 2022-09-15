import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemePreference {
  static const appDarkTheme = "appDarkTheme";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(appDarkTheme, value);
  }

  Future<bool> getDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(appDarkTheme) ?? false;
  }
}

class DarkThemeProvider with ChangeNotifier {
  AppThemePreference appThemePreference = AppThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    appThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
