import 'package:flutter/material.dart';

Color invertColor(Color? color) {
  color = color?? Colors.white;
  return Color.fromARGB(
    color.alpha,
    255 - color.red,
    255 - color.green,
    255 - color.blue,
  );
}

List<Color> generate3Color(Color mainColor){
  return [
    mainColor,
    Color(mainColor.value + 1249810),
    Color(mainColor.value + (2* 0x101797))
  ];
}