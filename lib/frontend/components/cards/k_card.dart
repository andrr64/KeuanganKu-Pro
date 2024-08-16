import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

Widget KCard(BuildContext context,
    {required Widget child, required String title, Color? color, Icon? icon}) {
  TextStyle textStyle = getTextStyle(context, KTStyle.title, KTSType.medium, FontColor.black.color);
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color:
              Colors.black.withOpacity(0.1), // Warna bayangan dengan opasitas
          offset: const Offset(0, 0.5), // Posisi bayangan
          blurRadius: 1, // Jarak blur bayangan
          spreadRadius: 0.5, // Penyebaran bayangan
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: textStyle.fontSize,
            fontFamily: textStyle.fontFamily,
            color: textStyle.color
          )),
          child,
        ],
      ),
    ),
  );
}
