import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/utility/color.dart';

const int constanta = 0x101797;

Widget KCardPlus(BuildContext context, Widget child,
    {String? title, Icon? icon, Color? color}) {
  color = color ?? Colors.white;
  List<Color> generated3Color = generate3Color(color);

  return Stack(
    clipBehavior: Clip.none,
    children: <Widget>[
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: generated3Color[0],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: 8.5), child: child,),
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
              child: Text(
                title?? 'Widget',
                style: TextStyle(
                  fontFamily: Theme.of(context).textTheme.labelMedium?.fontFamily,
                  fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
              ),
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
