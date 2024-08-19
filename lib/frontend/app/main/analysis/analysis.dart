import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/app/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/analysis/analysis_provider.dart';
import 'package:keuanganku/frontend/app/main/analysis/widgets/expense_barchart.dart';
import 'package:keuanganku/frontend/app/main/analysis/widgets/expense_donut_chart.dart';
import 'package:keuanganku/frontend/app/main/page_padding.dart';
import 'package:keuanganku/frontend/components/bullet.dart';
import 'package:keuanganku/frontend/components/cards/k_card.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/bar_weekly.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/graph_color.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/piecart.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';


class AnalysisPage extends HookConsumerWidget {
  const AnalysisPage({super.key});

  List<BarChartGroupData> data_mingguan(BuildContext context) {
    return [
      weeklyBarData(context, 0, 10, barColor: KGraphColor.pastel_red.color),
      weeklyBarData(context, 1, 15, barColor: KGraphColor.pastel_red.color),
      weeklyBarData(context, 2, 13, barColor: KGraphColor.pastel_red.color),
      weeklyBarData(context, 3, 40, barColor: KGraphColor.pastel_red.color),
      weeklyBarData(context, 4, 20, barColor: KGraphColor.pastel_red.color),
      weeklyBarData(context, 5, 20, barColor: KGraphColor.pastel_red.color),
      weeklyBarData(context, 6, 10, barColor: KGraphColor.pastel_red.color),
    ];
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
            ExpenseBarChart(),
            dummyHeight(15),
            ExpenseDonutChart(),
            ElevatedButton(
                onPressed: () {
                  ref
                      .watch(anlpgExpensePieChartByCategoryProvider.notifier)
                      .updateData(
                          ref
                              .watch(globalExpenseCategoriesProvider.notifier)
                              .getById,
                          context);
                },
                child: const Text('Hola'))
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: content(),
    );
  }
}
