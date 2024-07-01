import 'package:flutter/material.dart';

Widget dummyHeight(double h){
  return Container(height: h,);
}

double vh(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.height * (percentage / 100);
}