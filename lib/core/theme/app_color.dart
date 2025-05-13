import 'package:flutter/material.dart';

class AppColors {
  static const Color darkNavy = Color(0xFF1F2544);
  static const Color slateBlue = Color(0xFF474F7A);
  static const Color dustyPurple = Color(0xFF81689D);
  static const Color lightLilac = Color(0xFFFFD0EC);
  static const Color gray = Color(0xFF666671);
  static const Color moon = Color(0xFFD9D9D9);

  static ThemeData get darkTheme => ThemeData(
    scaffoldBackgroundColor: darkNavy,
    appBarTheme: const AppBarTheme(
      backgroundColor: slateBlue,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
    colorScheme: ColorScheme.dark(primary: dustyPurple, secondary: lightLilac),
  );
}
