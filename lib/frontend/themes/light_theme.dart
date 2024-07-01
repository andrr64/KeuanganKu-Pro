import 'package:flutter/material.dart';

ThemeData light_theme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: Colors.white,
    shape: Border(
      bottom: BorderSide(
        color: Colors.grey,
        width: 0.35
      )
    ),
    iconTheme: IconThemeData(color: Colors.black),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
);