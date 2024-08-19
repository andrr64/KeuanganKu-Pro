import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/app/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/analysis/analysis_provider.dart';
import 'package:keuanganku/frontend/components/cards/k_card.dart';
import 'package:keuanganku/frontend/components/empty_data.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/piecart.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

class ExpenseDonutChart extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _provider = ref.watch(anlpgExpensePieChartByCategoryProvider);
    final _notifier =
        ref.watch(anlpgExpensePieChartByCategoryProvider.notifier);
    Widget buildLegends() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(_provider.textLegends.length, (index) {
          return Row(
            children: [
              Container(
                color: _provider.sectionColors[index],
                height: 10,
                width: 10,
              ),
              dummyWidth(5),
              SizedBox(
                width: vw(context, 27.5), // Atur lebar sesuai kebutuhan
                child: _provider.textLegends[index],
              ),
            ],
          );
        }),
      );
    }
    Widget buildDonutChart() {
      if (_provider.pieChart.isEmpty) {
        return EmptyData(
          iconData: Icons.donut_large,
        );
      }
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Lorem ipsum dolor sit amet'),
              SizedBox(
                width: vw(context, 30),
                child: kDropdown(context,
                    items: DateRange.values,
                    itemsAsString: DateRange.month.labels,
                    value: _provider.dateRange, onChanged: (val) {
                  if (val != null && val != _provider.dateRange) {
                    _notifier.setTimePeriod(val);
                    _notifier.updateData(
                        ref
                            .watch(globalExpenseCategoriesProvider.notifier)
                            .getById,
                        context);
                  }
                }, label: 'Time Period'),
              ),
            ],
          ),
          dummyHeight(25),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: vh(context, 22.5),
                width: vw(context, 40),
                child: _provider.loading
                    ? Center(child: CircularProgressIndicator())
                    : KPieChart(sections: _provider.pieChart),
              ),
              const SizedBox(
                  width: 25), // Menambahkan jarak antara grafik dan legenda
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
                    kText(context, currencyFormat(_provider.total),
                        KTStyle.title, KTSType.medium),
                    dummyHeight(10),
                    buildLegends(),
                    dummyHeight(10),
                    OutlinedButton(
                        onPressed: () {}, child: const Text('Detail'))
                  ],
                ),
              ),
            ],
          )
        ],
      );
    }
    return KCard(
      context,
      title: 'Expense by Category',
      color: BaseColor.old_red.color,
      child: buildDonutChart()
    );
  }
}