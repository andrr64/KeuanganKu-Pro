import 'package:flutter/material.dart';
import 'package:keuanganku/enum/time_period.dart';
import 'package:keuanganku/frontend/components/cards/k_card.dart';
import 'package:keuanganku/frontend/components/empty_data.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/piecart.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/colors/base_color.dart';

class KExpenseDonutChart extends StatelessWidget {
  final List<KPieSectionData> sections;
  final List<Widget> legends;
  final List<Color> sectionColors;
  final TimePeriod dateRange;
  final double total;
  final void Function(TimePeriod) callbackWhenTimePeriodChanged;

  const KExpenseDonutChart(
      {super.key,
      required this.sections,
      required this.legends,
      required this.sectionColors,
      required this.dateRange,
      required this.total,
      required this.callbackWhenTimePeriodChanged});

  Widget buildLegends(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(legends.length, (index) {
        return Row(
          children: [
            Container(
              color: sectionColors[index],
              height: 10,
              width: 10,
            ),
            dummyWidth(5),
            SizedBox(
              width: vw(context, 27.5), // Atur lebar sesuai kebutuhan
              child: legends[index],
            ),
          ],
        );
      }),
    );
  }

  List<Widget> getDonutChart(BuildContext context) {
    if (sections.isEmpty) {
      return const [
        EmptyData(
          iconData: Icons.donut_large,
        )
      ];
    }
    return [
      SizedBox(
        height: vh(context, 22.5),
        width: vw(context, 40),
        child: KPieChart(sections: sections),
      ),
      const SizedBox(width: 25),
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
                context, currencyFormat(total), KTStyle.title, KTSType.medium),
            dummyHeight(10),
            buildLegends(context),
            dummyHeight(10),
            OutlinedButton(onPressed: () {}, child: const Text('Detail'))
          ],
        ),
      ),
    ];
  }

  Widget buildDonutChart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: vw(context, 80),
              child: const Text(
                'Which category is the most excessive?',
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
        dummyHeight(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: vw(context, 30),
              child: kDropdown(context,
                  items: TimePeriod.values,
                  itemsAsString: TimePeriod.month.labels,
                  value: dateRange, onChanged: (val) {
                if (val != null && val != dateRange) {
                  callbackWhenTimePeriodChanged(val);
                }
              }, label: 'Time Period'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...getDonutChart(context),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KCard(context,
        title: 'Expense by Category',
        color: baseColor_dark_red,
        child: buildDonutChart(context));
  }
}
