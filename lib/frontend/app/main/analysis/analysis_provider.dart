import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/api/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/piecart.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

class AnalysisPageData {
  final List<KPieSectionData> expensePieChartByCategory;
  final List<Widget>? expensePieChartLegends;
  final DateRange expensePieChartByCategoryDateRange;
  final DateRange expenseBarChartDataRange;

  AnalysisPageData({
    this.expensePieChartByCategoryDateRange = DateRange.month,
    this.expenseBarChartDataRange = DateRange.week,
    this.expensePieChartLegends,
    required this.expensePieChartByCategory,
  });

  AnalysisPageData copyWith({
    List<KPieSectionData>? pieSectionsData,
    DateRange? pieChartDateRange,
    List<Widget>? pieLegendsData,
    DateRange? barChartDataRange,
  }) {
    return AnalysisPageData(
      expensePieChartLegends: pieLegendsData ?? expensePieChartLegends,
      expensePieChartByCategory: pieSectionsData ?? expensePieChartByCategory,
      expensePieChartByCategoryDateRange: pieChartDateRange?? expensePieChartByCategoryDateRange,
      expenseBarChartDataRange: barChartDataRange?? expenseBarChartDataRange,
    );
  }
}
class AnalysisPageProvider extends Notifier<AnalysisPageData> {
  bool _init = false;

  @override
  AnalysisPageData build() => AnalysisPageData(expensePieChartByCategory: []);

  Future<void> initData(DBModelExpenseCategory Function(int) expenseCategoryGetter) async {
    if (!_init) {
      await updateExpensePieChartByCategoryData(expenseCategoryGetter);
      _init = true;
    }
  }

  Future<void> updateExpensePieChartByCategoryData(DBModelExpenseCategory Function(int) expenseCategoryGetter) async {
    final newData = await APIExpenseData.getExpenseTotalByCategories(expenseCategoryGetter: expenseCategoryGetter);
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
        radius: 27.5,
        whenTouched: () => (),
      );
    }).toList();

    final legends = newData.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      final percentage = (item.total / totalExpense) * 100;
      return Row(
        children: [
          Container(color: colors[i], width: 10, height: 10,),
          dummyWidth(5),
          Text('${item.category.name!} ${percentage.toStringAsFixed(1)}%'),
        ],
      );
    }).toList();
    state = state.copyWith(
      pieSectionsData: sections,
      pieLegendsData: legends,
    );
  }
}
final analysisPageProvider = NotifierProvider<AnalysisPageProvider, AnalysisPageData>(AnalysisPageProvider.new);

class AnalysisPageExpenseByCategoryData {
  final List<KPieSectionData> pieChart;
  final List<Color> sectionColors;
  final List<Widget> textLegends;
  final DateRange dateRange;
  final bool loading;
  final double total;

  AnalysisPageExpenseByCategoryData({
    this.pieChart = const [],
    this.total = 0,
    this.textLegends = const [],
    this.dateRange = DateRange.month,
    this.loading = false,
    this.sectionColors = const []
  });

  AnalysisPageExpenseByCategoryData copyWith({
    List<KPieSectionData>? pieChart,
    List<Widget>? legends,
    DateRange? dateRange,
    bool? loading,
    double? total,
    List<Color>? sectionColors
  }) {
    return AnalysisPageExpenseByCategoryData(
      pieChart: pieChart ?? this.pieChart,
      total: total?? this.total,
      sectionColors: sectionColors?? this.sectionColors,
      textLegends: legends ?? textLegends,
      dateRange: dateRange ?? this.dateRange,
      loading: loading ?? this.loading,
    );
  }
}
class AnalysisPageExpenseByCategoryProvider extends Notifier<AnalysisPageExpenseByCategoryData>{
  bool _init = false;

  @override
  AnalysisPageExpenseByCategoryData build() => AnalysisPageExpenseByCategoryData();
  Future<void> initData(BuildContext context, {required DBModelExpenseCategory Function(int) expenseCategoryGetter}) async {
    if (!_init){
      await updateData(expenseCategoryGetter, context);
      _init = true;
    }
  }

  Future<void> updateData(DBModelExpenseCategory Function(int) expenseCategoryGetter, BuildContext context) async {
    state.copyWith(loading: true);

    final newData = await APIExpenseData.getExpenseTotalByCategories(expenseCategoryGetter: expenseCategoryGetter);
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
      final i = entry.key;
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
final analysisPageExpenseByCategoryProvider =
NotifierProvider<AnalysisPageExpenseByCategoryProvider, AnalysisPageExpenseByCategoryData>
  (AnalysisPageExpenseByCategoryProvider.new);