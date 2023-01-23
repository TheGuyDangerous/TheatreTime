import 'package:flutter/material.dart';

import '../models/theme_preferences.dart';

class DarkthemeProvider with ChangeNotifier {
  Future<void> getCurrentThemeMode() async {
    darktheme = await themeModePreferences.getThemeMode();
  }

  ThemeModePreferences themeModePreferences = ThemeModePreferences();
  bool _darktheme = false;
  bool get darktheme => _darktheme;

  set darktheme(bool value) {
    _darktheme = value;
    themeModePreferences.setThemeMode(value);
    notifyListeners();
  }
}
