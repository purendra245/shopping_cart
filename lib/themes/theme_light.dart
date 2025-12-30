import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
    inverseSurface: Colors.grey.shade100,
    onInverseSurface: Colors.grey.shade800,
    onSurface: Colors.grey.shade400,
    onPrimary: Colors.grey.shade50,
    onSecondary: Colors.grey.shade600,
    onTertiary: Colors.black,
  ),
);
