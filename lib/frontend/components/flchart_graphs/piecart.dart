import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KPieSectionData {
  double value;
  String title;
  Color color;
  bool isTouched;
  double radius;
  int index;
  void Function() whenTouched;

  KPieSectionData(
      {required this.value,
      required this.index,
      required this.title,
      required this.color,
      required this.isTouched,
      required this.radius,
      required this.whenTouched});

  PieChartSectionData get data => PieChartSectionData(
      value: value, showTitle: false, color: color, radius: radius);
}

Widget KPieChart({List<KPieSectionData>? sections}) {
  return PieChart(
    PieChartData(
      sections: List.generate(sections!.length, (i) => sections[i].data),
    ),
    swapAnimationCurve: Curves.easeInOutCubic,
    swapAnimationDuration: const Duration(milliseconds: 500),
  );
}
