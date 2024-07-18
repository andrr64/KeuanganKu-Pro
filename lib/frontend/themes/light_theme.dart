import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/k_color.dart';

const Color BLACK_FONT_COLOR = Color(0xff14192b);

ThemeData light_theme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      displayMedium: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),

      labelSmall: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      labelMedium: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),

      titleSmall: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontFamily: "Quicksand",
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: BackgroundColor.white.getColor(),
      shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.35)),
      iconTheme: IconThemeData(color: FontColor.black.getColor()),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ));
