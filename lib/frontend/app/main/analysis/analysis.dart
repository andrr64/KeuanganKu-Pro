import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/frontend/app/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/analysis/analysis_provider.dart';
import 'package:keuanganku/frontend/app/main/analysis/widgets/expense_barchart.dart';
import 'package:keuanganku/frontend/app/main/analysis/widgets/expense_donut_chart.dart';
import 'package:keuanganku/frontend/app/main/page_padding.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';

bool _initPage = false;
late WidgetRef _ref;
final _expenseBarChartProvider = NotifierProvider<AnalysisPageExpenseBarChartProvider, AnalysisPageExpenseBarChartData>(AnalysisPageExpenseBarChartProvider.new);
final _expenseDonutChartProvider = NotifierProvider<AnalysisPageExpensePieChartByCategoryProvider, AnalysisPageExpensePieChartByCategoryData>(
    AnalysisPageExpensePieChartByCategoryProvider.new);

Future<void> REFRESH_AnalysisPage() async{
  if (_initPage){
    await _ref.watch(_expenseDonutChartProvider.notifier).updateData();
    await _ref.watch(_expenseBarChartProvider.notifier).updateData();
  }
}
void INITDATA_AnalysisPage(BuildContext context, WidgetRef ref) async{
  if (!_initPage){
    _ref = ref;
    DBModelExpenseCategory Function(int) expenseCategoryGetter = _ref.watch(globalExpenseCategoriesProvider.notifier).getById;
    await _ref.watch(_expenseDonutChartProvider.notifier).initData(context, expenseCategoryGetter: expenseCategoryGetter);
    await _ref.watch(_expenseBarChartProvider.notifier).initData(context, expenseCategoryGetter: expenseCategoryGetter);
    _initPage = true;
  }
}

class AnalysisPage extends HookConsumerWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final donutChartProvider = ref.watch(_expenseDonutChartProvider);
    final donutChartNotifier = ref.watch(_expenseDonutChartProvider.notifier);

    final barChartProvider = ref.watch(_expenseBarChartProvider);
    final barChartNotifier = ref.watch(_expenseBarChartProvider.notifier);

    Widget content() {
      return PagePadding(
        context,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpenseBarChart(
                bar_data: barChartProvider.bar_data,
                dataTimePeriod: barChartProvider.dataTimePeriod,
                maxVal: 0,
                lowestVal: 0,
                total: 0,
                average: 0,
                callbackWhenDataTimePeriodChanged: (val) async {
                  await barChartNotifier.setBarChartDataTimePeriod(val);
                  barChartNotifier.updateData();
                },
            ),
            dummyHeight(15),
            KExpenseDonutChart(
                sections: donutChartProvider.pieChart,
                legends: donutChartProvider.textLegends,
                sectionColors: donutChartProvider.sectionColors,
                dateRange: donutChartProvider.dateRange,
                total: donutChartProvider.total,
                callbackWhenTimePeriodChanged: (val){
                  donutChartNotifier.setTimePeriod(val);
                  donutChartNotifier.updateData();
                },
            ),
            ElevatedButton(onPressed: (){
              REFRESH_AnalysisPage();
            }, child: Text('Hola'))
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: content(),
    );
  }
}