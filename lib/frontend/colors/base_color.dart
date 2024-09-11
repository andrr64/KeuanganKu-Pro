import 'dart:math';
import 'package:flutter/material.dart';

const Color baseColor_dark_red = Color(0xff7e312a);
const Color baseColor_dark_blue = Color(0xff15193a);
const Color baseColor_dark_green = Color(0xff117347);

Color invertColor(Color? color) {
  color = color ?? Colors.white;
  return Color.fromARGB(
    color.alpha,
    255 - color.red,
    255 - color.green,
    255 - color.blue,
  );
}

List<Color> generate3Color(Color mainColor) {
  return [
    mainColor,
    Color(mainColor.value + 1249810),
    Color(mainColor.value + (2 * 0x101797))
  ];
}

Color generatePastelColor() {
  final Random random = Random();
  final int r = (random.nextInt(256) + 255) ~/ 2;
  final int g = (random.nextInt(256) + 255) ~/ 2;
  final int b = (random.nextInt(256) + 255) ~/ 2;

  return Color.fromARGB(255, r, g, b);
}

List<Color> generatePastelPalette(int count) {
  final List<Color> colors = [];
  final double hueStep = 360 / count;
  final Random random = Random();

  for (int i = 0; i < count; i++) {
    final double hue = i * hueStep + random.nextDouble() * hueStep / 2;
    final HSLColor hslColor = HSLColor.fromAHSL(1.0, hue, 0.7, 0.9);
    colors.add(hslColor.toColor());
  }

  return colors;
}

Color generateSoftColor() {
  final Random random = Random();
  final int r = (random.nextInt(156) + 100); // Nilai r antara 100-255
  final int g = (random.nextInt(156) + 100); // Nilai g antara 100-255
  final int b = (random.nextInt(156) + 100); // Nilai b antara 100-255

  return Color.fromARGB(255, r, g, b);
}

List<Color> generateSoftPalette(int count) {
  final List<Color> colors = [];

  for (int i = 0; i < count; i++) {
    final Color color = generateSoftColor();
    colors.add(color);
  }

  return colors;
}
