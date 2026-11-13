import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  static const String themeStatus = "THEMESTATUS";

  Future<void> setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themeStatus, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themeStatus) ?? true;
  }
}
