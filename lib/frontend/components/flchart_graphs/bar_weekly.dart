import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

double findValue(List<double> numbers, {bool highest = true}) {
  if (numbers.isEmpty) {
    throw ArgumentError('List cannot be empty');
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

BarChartGroupData weeklyBarData(BuildContext context, int x, double y1, {double barSpace = 2, required Color barColor}) {
  final width = (MediaQuery.sizeOf(context).width * 0.040);
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

BarChart WeeklyBarChart(
    BuildContext context,
    {required List<BarChartGroupData> barGroups, required double maxY}) {
  final xTitles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];
    return BarChart(
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
                    showTitles: true,
                    getTitlesWidget: (xVal, tileMeta) => SideTitleWidget(
                        axisSide: tileMeta.axisSide,
                        child: Text(
                          xTitles[xVal.toInt()],
                          style: getTextStyle(context, KTStyle.label, KTSType.medium, FontColor.black.color)
                        )
                    )
                )
            )
        )
    )
  );
}
