import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/expense_barchart.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/graph_color.dart';
import 'package:keuanganku/frontend/components/flchart_graphs/piecart.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/colors/k_color.dart';

class AnalysisPageExpenseBarChartData {
  final DateRange dataTimePeriod;
  final List<BarChartGroupData> weekly_bar;
  final List<BarChartGroupData> monthly_bar;
  final List<BarChartGroupData> yearly_bar;

  AnalysisPageExpenseBarChartData({
    this.weekly_bar = const[],
    this.monthly_bar = const[],
    this.yearly_bar = const[],
    this.dataTimePeriod = DateRange.week,
  });
  List<BarChartGroupData> get bar_data {
    switch(dataTimePeriod){
      case DateRange.week: return weekly_bar;
      case DateRange.month: return monthly_bar;
      case DateRange.year: return yearly_bar;
    }
  }
  AnalysisPageExpenseBarChartData copyWith({
    List<BarChartGroupData>? weekly_bar,
    List<BarChartGroupData>? monthly_bar,
    List<BarChartGroupData>? yearly_bar,
    DateRange? dataPeriod,
  }) {
    return AnalysisPageExpenseBarChartData(
        dataTimePeriod: dataPeriod ?? dataTimePeriod,
        weekly_bar: weekly_bar?? this.weekly_bar,
        monthly_bar: monthly_bar?? this.monthly_bar,
        yearly_bar: yearly_bar?? this.yearly_bar,
    );
  }
}
class AnalysisPageExpenseBarChartProvider extends Notifier<AnalysisPageExpenseBarChartData> {
  bool _init = false;
  late DBModelExpenseCategory Function(int) expenseCategoryGetter;
  late BuildContext context;

  @override
  AnalysisPageExpenseBarChartData build() => AnalysisPageExpenseBarChartData();
  Future<void> initData(BuildContext context,{required DBModelExpenseCategory Function(int) expenseCategoryGetter}) async {
    if (!_init) {
      this.expenseCategoryGetter = expenseCategoryGetter;
      await updateData();
      _init = true;
    }
  }
  Future<void> setBarChartDataTimePeriod(DateRange period) async{
    switch(period){
      case DateRange.week:
        state = state.copyWith(
            dataPeriod: period,
        );
      case DateRange.month:
        state = state.copyWith(
            dataPeriod: period,
        );
      case DateRange.year:
        state = state.copyWith(
            dataPeriod: period,
        );
    }
  }
  Future<void> updateData() async {
    final data_weekly = await DBHelperExpense().readExpenseThenGroupByDate(period: DateRange.week);
    final data_monthly = await DBHelperExpense().readExpenseThenGroupByDate(period: DateRange.month);
    final data_yearly = await DBHelperExpense().readExpenseThenGroupByDate(period: DateRange.year);

    final result_weekly = List.generate(data_weekly.length, (i) => weeklyBarData(i, data_weekly[i].total, barColor: KGraphColor.pastel_red.color));
    final result_monthly = List.generate(data_monthly.length, (i) => monthlyBarData(i, data_monthly[i].total, barColor: KGraphColor.pastel_red.color));
    final result_yearly = List.generate(data_yearly.length, (i) => yearlyBarData(i, data_yearly[i].total, barColor: KGraphColor.pastel_red.color));

    state = state.copyWith(
      weekly_bar: result_weekly,
      monthly_bar: result_monthly,
      yearly_bar: result_yearly
    );
  }
}

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
      total: total ?? this.total,
      sectionColors: sectionColors ?? this.sectionColors,
      textLegends: legends ?? textLegends,
      dateRange: dateRange ?? this.dateRange,
      loading: loading ?? this.loading,
    );
  }
}
class AnalysisPageExpensePieChartByCategoryProvider extends Notifier<AnalysisPageExpensePieChartByCategoryData> {
  bool _init = false;
  late DBModelExpenseCategory Function(int) expenseCategoryGetter;
  late BuildContext context;

  @override
  AnalysisPageExpensePieChartByCategoryData build() => AnalysisPageExpensePieChartByCategoryData();
  Future<void> initData(BuildContext context, {required DBModelExpenseCategory Function(int) expenseCategoryGetter}) async {
    if (!_init) {
      this.expenseCategoryGetter = expenseCategoryGetter;
      this.context = context;
      await updateData();
      _init = true;
    }
  }

  Future<void> updateData() async {
    state.copyWith(loading: true);
    final newData = await DBHelperExpense().readTotalExpenseByCategory(dateRange: state.dateRange);
    if (newData.isEmpty) {
      state = state.copyWith(
          loading: false,
          legends: [],
          sectionColors: [],
          total: 0,
          pieChart: []);
      return;
    }
    final colors = generateSoftPalette(newData.length);
    final double totalExpense =
        newData.fold(0, (sum, item) => sum + item.total);
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
      return Text(
        '${item.category.name!} (${percentage.toStringAsFixed(1)}%)',
        overflow: TextOverflow.clip,
        style: getTextStyle(
            context, KTStyle.label, KTSType.medium, FontColor.black.color),
      );
    }).toList();
    state = state.copyWith(
        pieChart: sections,
        legends: legends,
        sectionColors: colors,
        total: totalExpense,
        loading: false);
  }

  void setTimePeriod(DateRange newPeriod) {
    state = state.copyWith(dateRange: newPeriod);
  }
}
