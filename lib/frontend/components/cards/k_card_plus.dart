import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/colors/base_color.dart';

const int constanta = 0x101797;

Widget KCardPlus(BuildContext context, Widget child,
    {String? title, Icon? icon, Color? color, bool? withoutTitle}) {
  color = color ?? Colors.white;
  List<Color> generated3Color = generate3Color(color);

  if (withoutTitle == true) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: generated3Color[0],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
        ],
      ),
    );
  }

  return Stack(
    clipBehavior: Clip.none,
    children: <Widget>[
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: generated3Color[0],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.5),
                child: child,
              ),
            ],
          ),
        ),
      ),
      Positioned(
          left: 15 + 35,
          top: -12,
          child: Container(
            decoration: BoxDecoration(
                color: generated3Color[1],
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, bottom: 3.5, top: 3.5, right: 15),
              child: kText(
                  context, title ?? 'Widget', KTStyle.label, KTSType.medium,
                  color: Colors.white),
            ),
          )),
      Positioned(
        left: 15,
        top: -20.5,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: generated3Color[2],
            borderRadius: BorderRadius.circular(40),
          ),
          child: icon ??
              const Icon(
                Icons.show_chart,
                color: Colors.white,
              ),
        ),
      ),
    ],
  );
}
