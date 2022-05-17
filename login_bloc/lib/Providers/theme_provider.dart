import 'package:flutter/cupertino.dart';
import 'package:login_bloc/Models/theme_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemePreference themePreference = ThemePreference();
  String _theme = ThemePreference.LIGHT;

  String get theme => _theme;

  set setTheme(String theme) {
    _theme = theme;
    notifyListeners();
  }

  set updateTheme(String theme) {
    themePreference.setModeTheme(theme);
  }

  bool isDarkTheme() => _theme == ThemePreference.DARK;
}
