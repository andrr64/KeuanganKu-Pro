import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

const Color BLACK_FONT_COLOR = Color(0xff14192b);

ThemeData light_theme = ThemeData(
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'OpenSans'),
      displayMedium: TextStyle(fontFamily: 'OpenSans'),
      displaySmall: TextStyle(fontFamily: 'OpenSans'),
      bodyLarge: TextStyle(fontFamily: 'OpenSans'),
      bodyMedium: TextStyle(fontFamily: 'OpenSans'),
      bodySmall: TextStyle(fontFamily: 'OpenSans'),
      titleLarge: TextStyle(fontFamily: 'OpenSans'),
      titleMedium: TextStyle(fontFamily: 'OpenSans'),
      titleSmall: TextStyle(fontFamily: 'OpenSans'),
      labelLarge: TextStyle(fontFamily: 'OpenSans'),
      labelMedium: TextStyle(fontFamily: 'OpenSans'),
      labelSmall: TextStyle(fontFamily: 'OpenSans'),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        backgroundColor: BackgroundColor.black.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        )
      )
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: BackgroundColor.white.color,
      shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.35)),
      iconTheme: IconThemeData(color: FontColor.black.color),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ));
