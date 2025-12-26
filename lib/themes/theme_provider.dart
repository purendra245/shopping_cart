import 'package:flutter/material.dart';
import 'package:shopping_cart/themes/theme_dark.dart';
import 'package:shopping_cart/themes/theme_light.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  bool get isDarkMode => themeData == darkMode;

  void toggleTheme() {
    themeData = isDarkMode ? lightMode : darkMode;
  }
}
