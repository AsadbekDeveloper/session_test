import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Colors.grey.shade100,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black54),
      ),
    );
  }
}
