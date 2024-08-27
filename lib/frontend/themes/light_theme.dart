import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

const Color BLACK_FONT_COLOR = Color(0xff14192b);
const String FONT_FAMILY = 'OpenSans';

ThemeData light_theme = ThemeData(
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: FONT_FAMILY),
      displayMedium: TextStyle(fontFamily: FONT_FAMILY),
      displaySmall: TextStyle(fontFamily: FONT_FAMILY),
      bodyLarge: TextStyle(fontFamily: FONT_FAMILY),
      bodyMedium: TextStyle(fontFamily: FONT_FAMILY),
      bodySmall: TextStyle(fontFamily: FONT_FAMILY),
      titleLarge: TextStyle(fontFamily: FONT_FAMILY),
      titleMedium: TextStyle(fontFamily: FONT_FAMILY),
      titleSmall: TextStyle(fontFamily: FONT_FAMILY),
      labelLarge: TextStyle(fontFamily: FONT_FAMILY),
      labelMedium: TextStyle(fontFamily: FONT_FAMILY),
      labelSmall: TextStyle(fontFamily: FONT_FAMILY),
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
