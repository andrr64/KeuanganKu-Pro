import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

const Color BLACK_FONT_COLOR = Color(0xff14192b);

ThemeData light_theme = ThemeData(
    textTheme: GoogleFonts.openSansTextTheme(),
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
