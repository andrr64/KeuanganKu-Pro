import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/main/page_padding.dart';
import 'package:keuanganku/frontend/components/cards/k_card.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/bar_weekly.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/graph_color.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/piecart.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

class AnalysisPage extends HookConsumerWidget {
  int currentIndex = 0;
  List<BarChartGroupData> data_mingguan(BuildContext context) {
    return [
      weeklyBarData(context, 0, 10, barColor: KGraphColor.red.color),
      weeklyBarData(context, 1, 15, barColor: KGraphColor.red.color),
      weeklyBarData(context, 2, 13, barColor: KGraphColor.red.color),
      weeklyBarData(context, 3, 40, barColor: KGraphColor.red.color),
      weeklyBarData(context, 4, 20, barColor: KGraphColor.red.color),
      weeklyBarData(context, 5, 20, barColor: KGraphColor.red.color),
      weeklyBarData(context, 6, 10, barColor: KGraphColor.red.color),
    ];
  }
  List<KPieSectionData> data_donut(){
    return List.generate(10, (index){
      return KPieSectionData(
          value: Random().nextInt(200).toDouble(),
          index: index,
          title: index.toString(),
          color: Colors.red,
          isTouched: currentIndex == index,
          radius: 20,
          whenTouched: () => currentIndex = index
      );
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget content() {
      return PagePadding(
        context,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dummyHeight(10),
            KCard(
              context,
              title: 'Grafik Mingguan',
              color: BaseColor.old_red.color,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 250,
                    child: WeeklyBarChart(
                      context,
                      barGroups: data_mingguan(context),
                      maxY: findBarChartValue(data_mingguan(context)),
                    ),
                  )),
            ),
            dummyHeight(30),
            KCard(context,
                title: 'Kategori Pengeluaran',
                color: BaseColor.old_red.color,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 250,
                      child: KPieChart(sections: data_donut()),
                    )))
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: content(),
    );
  }
}
