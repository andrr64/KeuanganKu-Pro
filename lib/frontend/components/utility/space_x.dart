import 'package:flutter/material.dart';

double vw(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.width * (percentage / 100);
}