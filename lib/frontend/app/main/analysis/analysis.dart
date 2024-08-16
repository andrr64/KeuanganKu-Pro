import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/analysis/analysis_provider.dart';
import 'package:keuanganku/frontend/app/main/page_padding.dart';
import 'package:keuanganku/frontend/components/bullet.dart';
import 'package:keuanganku/frontend/components/cards/k_card.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/bar_weekly.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/graph_color.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/piecart.dart';
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
    Widget expenseByCategoryGraph() {
      final expenseByCategoryGraphProvider =
          ref.watch(analysisPageExpenseByCategoryProvider);

      Widget buildLegends() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              expenseByCategoryGraphProvider.textLegends.length, (index) {
            return Row(
              children: [
                Container(
                  color: expenseByCategoryGraphProvider.sectionColors[index],
                  height: 10,
                  width: 10,
                ),
                dummyWidth(5),
                SizedBox(
                  width: vw(context, 27.5), // Atur lebar sesuai kebutuhan
                  child: expenseByCategoryGraphProvider.textLegends[index],
                ),
              ],
            );
          }),
        );
      }

      return KCard(
        context,
        title: 'Expense by Category',
        color: BaseColor.old_red.color,
        child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: vh(context, 22.5),
                      width: vw(context, 40),
                      child: expenseByCategoryGraphProvider.loading
                          ? const Center(child: CircularProgressIndicator())
                          : KPieChart(
                              sections:
                                  expenseByCategoryGraphProvider.pieChart),
                    ),
                    const SizedBox(
                        width:
                            25), // Menambahkan jarak antara grafik dan legenda
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kText(
                              context,
                              'Total',
                              KTStyle.title,
                              fontWeight: FontWeight.w600,
                              KTSType.medium),
                          kText(
                              context,
                              currencyFormat(
                                  expenseByCategoryGraphProvider.total),
                              KTStyle.title,
                              KTSType.medium),
                          dummyHeight(10),
                          buildLegends(),
                          dummyHeight(10),
                          OutlinedButton(
                              onPressed: () {}, child: const Text('Detail'))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      );
    }

    Widget expenseBarGraph() {
      return KCard(
        context,
        title: 'Weekly Expense',
        color: BaseColor.old_red.color,
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dummyHeight(20),
                SizedBox(
                  height: 225,
                  child: WeeklyBarChart(
                    context,
                    barGroups: data_mingguan(context),
                    maxY: findBarChartValue(data_mingguan(context)),
                  ),
                ),
                dummyHeight(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            KBullet(10, color: KGraphColor.pastel_red.color),
                            dummyWidth(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kText(context, 'Total', KTStyle.title,
                                    KTSType.small,
                                    fontWeight: FontWeight.w600),
                                kText(context, currencyFormat(120000000),
                                    KTStyle.label, KTSType.small),
                              ],
                            )
                          ],
                        ),
                        dummyHeight(10),
                        Row(
                          children: [
                            KBullet(10),
                            dummyWidth(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Average',
                                  style: getTextStyle(context, KTStyle.title,
                                      KTSType.small, FontColor.black.color,
                                      fontWeight: FontWeight.w600),
                                ),
                                kText(context, currencyFormat(120000000),
                                    KTStyle.label, KTSType.small),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            KBullet(10, color: KGraphColor.pastel_red.color),
                            dummyWidth(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                kText(context, 'Highest', KTStyle.title,
                                    KTSType.small,
                                    fontWeight: FontWeight.w600),
                                kText(context, currencyFormat(120000000),
                                    KTStyle.label, KTSType.small),
                              ],
                            )
                          ],
                        ),
                        dummyHeight(10),
                        Row(
                          children: [
                            KBullet(10),
                            dummyWidth(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lowest',
                                  style: getTextStyle(context, KTStyle.title,
                                      KTSType.small, FontColor.black.color,
                                      fontWeight: FontWeight.w600),
                                ),
                                kText(context, currencyFormat(120000000),
                                    KTStyle.label, KTSType.small),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            )),
      );
    }

    Widget content() {
      return PagePadding(
        context,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            expenseBarGraph(),
            dummyHeight(15),
            expenseByCategoryGraph(),
            ElevatedButton(
                onPressed: () {
                  ref
                      .watch(analysisPageExpenseByCategoryProvider.notifier)
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
