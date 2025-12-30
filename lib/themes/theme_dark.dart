import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade800,
    tertiary: Colors.black,
    inversePrimary: Colors.grey.shade300,
    inverseSurface: Colors.grey.shade900,
    onInverseSurface: Colors.grey.shade200,
    onSurface: Colors.grey.shade100,
    onPrimary: Colors.grey.shade900,
    onSecondary: Colors.grey.shade400,
    onTertiary: Colors.white,
  ),
);
