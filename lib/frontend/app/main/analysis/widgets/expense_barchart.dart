import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/app/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/analysis/analysis_provider.dart';
import 'package:keuanganku/frontend/components/bullet.dart';
import 'package:keuanganku/frontend/components/cards/k_card.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/bar_weekly.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/graph_color.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';
import 'package:keuanganku/frontend/utility/stringop.dart';

class ExpenseBarChart extends HookConsumerWidget {

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
    final provider = ref.watch(anlpgExpenseBarChart);
    final notifier = ref.read(anlpgExpenseBarChart.notifier);

    // TODO: implement build
    return KCard(
      context,
      title: '${capitalizeFirstLetter(provider.dataTimePeriod.value)}ly Expense',
      color: BaseColor.old_red.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lorem ipsum dolor sit amet'),
              SizedBox(
                width: vw(context, 30),
                child: kDropdown(
                    context,
                    items: DateRange.values,
                    itemsAsString: DateRange.month.labels,
                    value: provider.dataTimePeriod,
                    onChanged: (val) {
                      print('Clicked');
                      if (val != null && val != provider.dataTimePeriod){
                        notifier.setBarChartDataPeriod(val);
                        notifier.updateData(ref.read(globalExpenseCategoriesProvider.notifier).getById);
                      }
                    },
                    label: 'Time Period'),
              ),
            ],
          ),
          dummyHeight(25),
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
      ),
    );
  }
}