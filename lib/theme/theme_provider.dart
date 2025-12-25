import 'package:flutter/material.dart';
import 'package:shopping_cart/theme/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme() {
    themeData = _themeData == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
