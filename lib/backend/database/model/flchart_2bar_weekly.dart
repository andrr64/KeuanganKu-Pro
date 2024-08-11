import 'package:fl_chart/fl_chart.dart';

class KFLChart2BarWeekly {
  BarChartGroupData data;
  KFLChart2BarWeekly({required this.data});


}


// BarChartGroupData(
// x: 4,
// barRods: [
// BarChartRodData(
// toY: 13,
// gradient: _barsGradient,
// )
// ],
// showingTooltipIndicators: [0],
// ),
var y = BarChartGroupData(
  x: 1,
  barRods: [
    BarChartRodData(toY: 13)
  ]
);
