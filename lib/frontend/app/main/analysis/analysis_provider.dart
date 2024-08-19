import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/api/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/piecart.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

class AnalysisPageExpenseBarChartData {
  final DateRange dataTimePeriod;
  AnalysisPageExpenseBarChartData({this.dataTimePeriod = DateRange.week});

  AnalysisPageExpenseBarChartData copyWith({DateRange? dataPeriod}){
    return AnalysisPageExpenseBarChartData(dataTimePeriod: dataPeriod?? this.dataTimePeriod);
  }
}
class AnalysisPageExpenseBarChartProvider extends Notifier<AnalysisPageExpenseBarChartData>{
  @override
  AnalysisPageExpenseBarChartData build() => AnalysisPageExpenseBarChartData();
  void setBarChartDataPeriod(DateRange period) => state = state.copyWith(dataPeriod: period);
  Future<void> updateData(DBModelExpenseCategory Function(int) expenseCategoryGetter) async{
    //TODO: updateData_anlphExpenseBarChart
    [];
  }
}
final anlpgExpenseBarChart =
NotifierProvider<AnalysisPageExpenseBarChartProvider, AnalysisPageExpenseBarChartData>
  (AnalysisPageExpenseBarChartProvider.new);

class AnalysisPageExpensePieChartByCategoryData {
  final List<KPieSectionData> pieChart;
  final List<Color> sectionColors;
  final List<Widget> textLegends;
  final DateRange dateRange;
  final bool loading;
  final double total;

  AnalysisPageExpensePieChartByCategoryData({
    this.pieChart = const [],
    this.total = 0,
    this.textLegends = const [],
    this.dateRange = DateRange.month,
    this.loading = false,
    this.sectionColors = const [],
  });

  AnalysisPageExpensePieChartByCategoryData copyWith({
    List<KPieSectionData>? pieChart,
    List<Widget>? legends,
    DateRange? dateRange,
    bool? loading,
    double? total,
    List<Color>? sectionColors,
  }) {
    return AnalysisPageExpensePieChartByCategoryData(
      pieChart: pieChart ?? this.pieChart,

      total: total?? this.total,
      sectionColors: sectionColors?? this.sectionColors,
      textLegends: legends ?? textLegends,
      dateRange: dateRange ?? this.dateRange,
      loading: loading ?? this.loading,
    );
  }
}
class AnalysisPageExpensePieChartByCategoryProvider extends Notifier<AnalysisPageExpensePieChartByCategoryData>{
  bool _init = false;

  @override
  AnalysisPageExpensePieChartByCategoryData build() => AnalysisPageExpensePieChartByCategoryData();

  void setTimePeriod(DateRange newPeriod){
    state = state.copyWith(dateRange: newPeriod);
  }
  Future<void> initData(BuildContext context, {required DBModelExpenseCategory Function(int) expenseCategoryGetter}) async {
    if (!_init){
      await updateData(expenseCategoryGetter, context);
      _init = true;
    }
  }
  Future<void> updateData(DBModelExpenseCategory Function(int) expenseCategoryGetter, BuildContext context) async {
    state.copyWith(loading: true);
    final newData = await APIExpenseData.getExpenseTotalByCategories(range: state.dateRange, expenseCategoryGetter: expenseCategoryGetter);
    if (newData.isEmpty){
      state.copyWith(
        loading: false,
        legends: [],
        sectionColors: [],
        total: 0,
        pieChart: []
      );
      return;
    }
    final colors = generateSoftPalette(newData.length);
    final double totalExpense = newData.fold(0, (sum, item) => sum + item.total);
    final sections = newData.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      final percentage = (item.total / totalExpense) * 100;
      return KPieSectionData(
        value: item.total,
        index: i,
        title: "${percentage.toStringAsFixed(1)}%",
        color: colors[i],
        isTouched: true,
        radius: 30,
        whenTouched: () => (),
      );
    }).toList();
    final legends = newData.asMap().entries.map((entry) {
      final item = entry.value;
      final percentage = (item.total / totalExpense) * 100;
      return  Text(
        '${item.category.name!} (${percentage.toStringAsFixed(1)}%)',
        overflow: TextOverflow.clip,
        style: getTextStyle(context, KTStyle.label, KTSType.medium, FontColor.black.color),);
    }).toList();
    state = state.copyWith(
      pieChart: sections,
      legends: legends,
      sectionColors: colors,
      total: totalExpense,
      loading: false
    );
  }
}
final anlpgExpensePieChartByCategoryProvider =
NotifierProvider<AnalysisPageExpensePieChartByCategoryProvider, AnalysisPageExpensePieChartByCategoryData>
  (AnalysisPageExpensePieChartByCategoryProvider.new);