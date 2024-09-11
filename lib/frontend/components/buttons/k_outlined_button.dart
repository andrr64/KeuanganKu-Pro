import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/colors/font_color.dart';

class KButtonColor {
  Color backgroundColor;
  Color foregroundColor;

  KButtonColor({required this.backgroundColor, required this.foregroundColor});

  static Color transformColor(Color color, [int brightnessIncrement = 0x09]) {
    int newR = (color.red + 0xBB + brightnessIncrement).clamp(0, 255);
    int newG = (color.green + 0x87 + brightnessIncrement).clamp(0, 255);
    int newB = (color.blue + 0xA6 + brightnessIncrement).clamp(0, 255);

    return Color.fromARGB(color.alpha, newR, newG, newB);
  }

  static KButtonColor createFromColor(Color foregroundColor) {
    return KButtonColor(
        backgroundColor: transformColor(foregroundColor),
        foregroundColor: foregroundColor);
  }
}

OutlinedButton KOutlinedButton(
    {required void Function() onPressed,
    required String text,
    Color? color,
    Color? textColor,
    bool withOutline = true,
    double? paddingHorizontal,
    Icon? icon}) {
  KButtonColor button_color;
  if (color != null) {
    button_color = KButtonColor.createFromColor(color);
    button_color.foregroundColor = textColor ?? button_color.foregroundColor;
  } else {
    button_color = KButtonColor(
        backgroundColor: Colors.white,
        foregroundColor: textColor ?? fontColor_black);
  }

  ButtonStyle style = OutlinedButton.styleFrom(
      backgroundColor: button_color.backgroundColor,
      foregroundColor: button_color.foregroundColor,
      side: withOutline
          ? BorderSide(color: button_color.foregroundColor)
          : BorderSide.none);

  if (icon != null) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      label: Text(text),
      icon: icon,
      style: style,
    );
  }
  return OutlinedButton(
    onPressed: onPressed,
    style: style,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal?? 0),
      child: Text(text),
    ),
  );
}
