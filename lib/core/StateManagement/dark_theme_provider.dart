import 'package:material_ui/material_ui.dart';

import '../utility/shared_preferences_dark_theme.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    if (_darkTheme == value) return;
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  void toggleTheme() {
    darkTheme = !_darkTheme;
  }
}
