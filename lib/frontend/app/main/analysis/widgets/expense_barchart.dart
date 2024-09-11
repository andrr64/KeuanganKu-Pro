import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/colors/font_color.dart';
import 'package:keuanganku/frontend/components/bullet.dart';
import 'package:keuanganku/frontend/components/cards/k_card.dart';
import 'package:keuanganku/frontend/components/empty_data.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/expense_barchart.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/graph_color.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/colors/base_color.dart';

class ExpenseBarChart extends StatelessWidget {
  const ExpenseBarChart(
      {super.key,
      required this.bar_data,
      required this.dataTimePeriod,
      required this.maxVal,
      required this.total,
      required this.average,
      required this.callbackWhenDataTimePeriodChanged,
      required this.lowestVal});

  final List<BarChartGroupData> bar_data;
  final double total;
  final double maxVal;
  final double lowestVal;
  final double average;
  final DateRange dataTimePeriod;
  final void Function(DateRange) callbackWhenDataTimePeriodChanged;

  Widget buildWeeklyBars(BuildContext context) {
    return SizedBox(
      height: 225,
      child: WeeklyExpenseBarChart(
        context,
        barGroups: bar_data,
        maxY: maxVal,
      ),
    );
  }

  Widget buildMonthlyBars(BuildContext context) {
    return SizedBox(
      height: 225,
      child: MonthlyExpenseBarChart(context, barGroups: bar_data),
    );
  }

  Widget buildYearlyBars(BuildContext context) {
    return SizedBox(
      height: 225,
      child: YearlyExpenseBarChart(context, barGroups: bar_data),
    );
  }

  //EVERYTHING IS: Ok
  Widget buildTitle(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Check your expense chart. It’s very helpful."),
      ],
    );
  }

  Widget buildChartInfo(BuildContext context) {
    const widthPctg = 80 / 2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: vw(context, widthPctg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  KBullet(10, color: KGraphColor.pastel_red.color),
                  dummyWidth(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kText(context, 'Total', KTStyle.title, KTSType.small,
                          fontWeight: FontWeight.w600),
                      kText(context, currencyFormat(total), KTStyle.label,
                          KTSType.small),
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
                            KTSType.small, fontColor_black,
                            fontWeight: FontWeight.w600),
                      ),
                      kText(context, currencyFormat(average), KTStyle.label,
                          KTSType.small),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          width: vw(context, widthPctg),
          child: Column(
            children: [
              Row(
                children: [
                  KBullet(10, color: KGraphColor.pastel_red.color),
                  dummyWidth(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kText(context, 'Highest', KTStyle.title, KTSType.small,
                          fontWeight: FontWeight.w600),
                      kText(context, currencyFormat(maxVal), KTStyle.label,
                          KTSType.small),
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
                            KTSType.small, fontColor_black,
                            fontWeight: FontWeight.w600),
                      ),
                      kText(context, currencyFormat(lowestVal), KTStyle.label,
                          KTSType.small),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildChart(BuildContext context) {
    if (bar_data.isEmpty) {
      return const EmptyData(
        iconData: Icons.analytics,
      );
    }
    switch (dataTimePeriod) {
      case DateRange.week:
        return buildWeeklyBars(context);
      case DateRange.month:
        return buildMonthlyBars(context);
      case DateRange.year:
        return buildYearlyBars(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KCard(
      context,
      title: 'Expense Chart',
      color: baseColor_dark_red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitle(context),
          dummyHeight(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: vw(context, 35),
                child: kDropdown(context,
                    items: DateRange.values,
                    itemsAsString: DateRange.month.labels,
                    value: dataTimePeriod, onChanged: (val) {
                  if (val != null && val != dataTimePeriod) {
                    callbackWhenDataTimePeriodChanged(val);
                  }
                }, label: 'Time Period'),
              ),
            ],
          ),
          dummyHeight(25),
          buildChart(context),
          dummyHeight(20),
          bar_data.isNotEmpty ? buildChartInfo(context) : const SizedBox()
        ],
      ),
    );
  }
}
