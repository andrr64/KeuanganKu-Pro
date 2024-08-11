import 'package:flutter/material.dart';

enum BackgroundColor {
  white(Color(0xffffffff)),
  black(Color(0xff14192b));
  const BackgroundColor(this.color);
  final Color color;
}
enum FontColor {
  black(Color(0xff14192b));
  const FontColor(this.color);
  final Color color;
}

enum BaseColor {
  old_red(Color(0xff8f3e3e)),
  primary(Color(0xff15193a)),
  old_green(Color(0xff3f8852));
  const BaseColor(this.color);
  final Color color;
}

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