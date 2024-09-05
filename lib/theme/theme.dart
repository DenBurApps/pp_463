import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFFD5D69),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF1E1E1E),
    onSecondary: Color(0xFFFFFFFF),
    surfaceContainer: Color(0xFFFFE5B3),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1D1D1D),
    outline: Color(0xFFE7E7E7),
    onBackground: Color(0xFF1E1E1E),
    background: Color(0xFFFFFBF3),
  ),
);

class AppColors {
  static const Color green = Color(0xFF9AEC48);
  static const Color red = Color(0xFFFD5D69);
  static const Color yellow = Color(0xFFFBB74C);
  static const Color purple = Color(0xFFB782DF);
  static const Color blue = Color(0xFF1479BA);
}
