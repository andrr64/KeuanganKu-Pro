import 'package:flutter/material.dart';

const Color black_font_color = Color(0xff14192b);

ThemeData light_theme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  textTheme: const TextTheme(
    displaySmall:
        TextStyle(fontFamily: "Quicksand", fontSize: 14, color: Colors.white),
    displayMedium: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white),
    titleMedium: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: black_font_color),
    titleSmall: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: Colors.white,
    shape: Border(bottom: BorderSide(color: Colors.grey, width: 0.35)),
    iconTheme: IconThemeData(color: black_font_color),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
);
