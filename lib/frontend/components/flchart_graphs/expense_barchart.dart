import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/device_info.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

double findValue(List<double> numbers, {bool highest = true}) {
  if (numbers.isEmpty) {
    return 0;
  }

  double result = numbers[0];  // Inisialisasi dengan nilai pertama

  for (var number in numbers) {
    if (highest) {
      if (number > result) {
        result = number;
      }
    } else {
      if (number < result) {
        result = number;
      }
    }
  }

  return result;
}
double findAverage(List<double> numbers) {
  double total = numbers.fold(0, (sum, element) => sum + element );
  return total / numbers.length;
}
double findBarChartValue(List<BarChartGroupData> data, {bool highest = true}) {
  if (data.isEmpty) {
    throw ArgumentError('List cannot be empty');
  }

  double result = data[0].barRods[0].toY;  // Inisialisasi dengan nilai pertama

  for (var groupData in data) {
    for (var rodData in groupData.barRods) {
      if (highest) {
        if (rodData.toY > result) {
          result = rodData.toY;
        }
      } else {
        if (rodData.toY < result) {
          result = rodData.toY;
        }
      }
    }
  }

  return result;
}

BarChartGroupData weeklyBarData(int x, double y1, {double barSpace = 2, required Color barColor}) {
  final width = (DEVICE_WIDTH * 0.040);
  return BarChartGroupData(
    barsSpace: barSpace,
    x: x,
    barRods: [
      BarChartRodData(
        toY: y1,
        width: width,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(2.5),
          topRight: Radius.circular(2.5),
        ),
        color: barColor
      ),
    ],
  );
}
BarChartGroupData monthlyBarData(int x, double y1, {required Color barColor}) {
  final width = (DEVICE_WIDTH * 0.020);
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
          toY: y1,
          width: width,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2.5),
            topRight: Radius.circular(2.5),
          ),
          color: barColor
      ),
    ],
  );
}
BarChartGroupData yearlyBarData(int x, double y1, {double barSpace = 2, required Color barColor}) {
  final width = (DEVICE_WIDTH * 0.030);
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
          toY: y1,
          width: width,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2.5),
            topRight: Radius.circular(2.5),
          ),
          color: barColor
      ),
    ],
  );
}

BarChart WeeklyExpenseBarChart(BuildContext context, {required List<BarChartGroupData> barGroups, required double maxY}) {
  final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];
  return BarChart(
      swapAnimationDuration: const Duration(seconds: 1),
      swapAnimationCurve: Curves.easeInOutCubic,
      BarChartData(
          barGroups: barGroups,
          barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipColor: (_) => Colors.black26,
                tooltipHorizontalAlignment: FLHorizontalAlignment.center,
                tooltipMargin: -10,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  String weekDay;
                  switch (group.x) {
                    case 0:
                      weekDay = 'Monday';
                      break;
                    case 1:
                      weekDay = 'Tuesday';
                      break;
                    case 2:
                      weekDay = 'Wednesday';
                      break;
                    case 3:
                      weekDay = 'Thursday';
                      break;
                    case 4:
                      weekDay = 'Friday';
                      break;
                    case 5:
                      weekDay = 'Saturday';
                      break;
                    case 6:
                      weekDay = 'Sunday';
                      break;
                    default:
                      throw Error();
                  }
                  return BarTooltipItem(
                    '$weekDay\n',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: (rod.toY).toString(),
                        style: const TextStyle(
                          color: Colors.white, //widget.touchedBarColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
          ),
          gridData: const FlGridData(
              show: true,
              drawVerticalLine: false
          ),
          borderData: FlBorderData(
              show: true,
              border: Border(
                  left: BorderSide(
                      width: 2, color: Colors.black.withOpacity(0.2)
                  ),
                  bottom: BorderSide(
                      width: 2, color: Colors.black.withOpacity(0.2)
                  )
              )
          ),
          titlesData: FlTitlesData(
              show: true,
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (xVal, tileMeta) => SideTitleWidget(
                          axisSide: tileMeta.axisSide,
                          child: Text(
                              titles[xVal.toInt()],
                              style: getTextStyle(context, KTStyle.label, KTSType.medium, FontColor.black.color)
                          )
                      )
                  )
              )
          )
      )
  );
}
BarChart MonthlyExpenseBarChart(BuildContext context, {required List<BarChartGroupData> barGroups}){
  final titles = barGroups.map((val) => val.x.toString()).toList();
  const showBottomTitles = false;
  return BarChart(
    swapAnimationDuration: const Duration(seconds: 1),
    swapAnimationCurve: Curves.easeInOutCubic,
    BarChartData(
      barGroups: barGroups,
      gridData: const FlGridData(
          show: true,
          drawVerticalLine: false
      ),
      borderData: FlBorderData(
          show: true,
          border: Border(
              left: BorderSide(
                  width: 2, color: Colors.black.withOpacity(0.2)
              ),
              bottom: BorderSide(
                  width: 2, color: Colors.black.withOpacity(0.2)
              )
          )
      ),
      titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: showBottomTitles,
                  getTitlesWidget: (xVal, tileMeta) => SideTitleWidget(
                      axisSide: tileMeta.axisSide,
                      child: xVal.toInt() % 7 == 0? Text(
                          titles[xVal.toInt() + 1],
                          style: getTextStyle(context, KTStyle.label, KTSType.medium, FontColor.black.color)
                      ) : const Text('')
                  )
              )
          )
      )
    ),
  );
}
BarChart YearlyExpenseBarChart(BuildContext context, {required List<BarChartGroupData> barGroups}){
  const showBottomTitles = true;
  return BarChart(
    swapAnimationDuration: const Duration(seconds: 1),
    swapAnimationCurve: Curves.easeInOutCubic,
    BarChartData(
        barGroups: barGroups,
        gridData: const FlGridData(
            show: true,
            drawVerticalLine: false
        ),
        borderData: FlBorderData(
            show: true,
            border: Border(
                left: BorderSide(
                    width: 2, color: Colors.black.withOpacity(0.2)
                ),
                bottom: BorderSide(
                    width: 2, color: Colors.black.withOpacity(0.2)
                )
            )
        ),
        titlesData: FlTitlesData(
            show: showBottomTitles,
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (xVal, tileMeta) => SideTitleWidget(
                        axisSide: tileMeta.axisSide,
                        child: Text(
                            (xVal.toInt() + 1).toString(),
                            style: getTextStyle(context, KTStyle.label, KTSType.medium, FontColor.black.color)
                        )
                    )
                )
            )
        )
    )
  );
}