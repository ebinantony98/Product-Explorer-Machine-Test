import 'package:flutter/material.dart';

class AppTheme {
  static const ink = Color(0xFF171923);
  static const muted = Color(0xFF777D8A);
  static const accent = Color(0xFF6C5CE7);
  static const canvas = Color(0xFFF7F7FA);

  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: accent,
      brightness: Brightness.light,
      surface: Colors.white,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: canvas,
      appBarTheme: const AppBarTheme(
        backgroundColor: canvas,
        foregroundColor: ink,
        elevation: 0,
        centerTitle: false,
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: ink),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: ink),
        titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: ink),
        bodyMedium: TextStyle(fontSize: 13, color: muted, height: 1.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: const TextStyle(color: muted),
        prefixIconColor: muted,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
