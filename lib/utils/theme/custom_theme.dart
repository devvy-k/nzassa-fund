import 'package:flutter/material.dart';

class CustomTheme {
  CustomTheme._();

  // Couleurs extraites du logo
  static const Color bluePrimary = Color(0xFF154A88);
  static const Color blueAccent = Color(0xFF2A74B5);
  static const Color green = Color(0xFF7AC943);
  static const Color orange = Color(0xFFF5A623);
  static const Color yellow = Color(0xFFFEC932);
  static const Color red = Color(0xFFD84339);

  // Palette neutre
  static const Color lightBackground = Colors.white;
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: bluePrimary,
    scaffoldBackgroundColor: lightBackground,
    colorScheme: ColorScheme.light(
      primary: bluePrimary,
      secondary: green,
      error: red,
      surface: Color(0xFFF5F5F5),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      bodyMedium: TextStyle(fontSize: 13, color: Colors.black87),
      labelLarge: TextStyle(fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: bluePrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: bluePrimary),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: bluePrimary,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 2,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    // BottomSheet
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFFF5F5F5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
    // Checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return bluePrimary;
        }
        return Colors.grey;
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: bluePrimary,
    scaffoldBackgroundColor: darkBackground,
    colorScheme: ColorScheme.dark(
      primary: bluePrimary,
      secondary: green,
      error: red,
      surface: darkSurface
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyMedium: TextStyle(fontSize: 13, color: Colors.white70),
      labelLarge: TextStyle(fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: bluePrimary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkSurface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: bluePrimary),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: bluePrimary,
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 2,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: darkSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return bluePrimary;
        }
        return Colors.grey;
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  );
}
