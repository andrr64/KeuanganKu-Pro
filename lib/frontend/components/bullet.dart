import 'package:flutter/cupertino.dart';
import 'package:keuanganku/frontend/colors/font_color.dart';

Widget KBullet(double d, {Color? color}){
  return Container(
    height: d,
    width: d,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(d),
      color: color?? fontColor_black
    ),
  );
}