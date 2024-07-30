import 'package:flutter/material.dart';

Widget KCard(Widget child, Color color){
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: color
    ),
    padding: const EdgeInsets.all(20),
    child: child,
  );
}