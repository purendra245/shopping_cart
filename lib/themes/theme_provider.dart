import 'package:flutter/material.dart';
import 'package:shopping_cart/themes/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool isDarkMode() => _themeData == darkMode;

  set theme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    theme = isDarkMode() ? lightMode : darkMode;
  }
}
