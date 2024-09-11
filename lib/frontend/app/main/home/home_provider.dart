import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/enum/time_period.dart';

class HomepageData {
  final TimePeriod incomesDateRange;
  final TimePeriod expenseDateRange;
  final double incomesAmount;
  final double expenseAmount;

  HomepageData(
      {this.incomesDateRange = TimePeriod.week,
      this.expenseDateRange = TimePeriod.week,
      this.incomesAmount = 0,
      this.expenseAmount = 0});

  HomepageData copyWith(
      {TimePeriod? incomeCardDateRange,
      double? incomesAmount,
      TimePeriod? expenseDateRange,
      double? expenseAmount}) {
    return HomepageData(
      incomesDateRange: incomeCardDateRange ?? incomesDateRange,
      incomesAmount: incomesAmount ?? this.incomesAmount,
      expenseDateRange: expenseDateRange ?? this.expenseDateRange,
      expenseAmount: expenseAmount ?? this.expenseAmount,
    );
  }
}

class HomepageProvider extends Notifier<HomepageData> {
  bool _init = false;

  @override
  HomepageData build() {
    return HomepageData();
  }

  Future<void> initData() async {
    if (!_init) {
      await updateIncomes();
      await updateExpense();
      _init = true;
    }
  }

  Future<void> updateIncomes() async => state = state.copyWith(
      incomesAmount:
          await DBHelperIncome().readTotalIncome(date: state.incomesDateRange));
  Future<void> updateExpense() async => state = state.copyWith(
      expenseAmount: await DBHelperExpense()
          .readTotalExpenseByPeriod(dateRange: state.expenseDateRange));
  Future<void> setIncomeCardDateRange(TimePeriod dateRange) async {
    if (dateRange != state.incomesDateRange) {
      state = state.copyWith(
          incomesAmount:
              await DBHelperIncome().readTotalIncome(date: dateRange),
          incomeCardDateRange: dateRange);
    }
  }

  Future<void> setExpenseCardDateRange(TimePeriod dateRange) async {
    if (dateRange != state.expenseDateRange) {
      state = state.copyWith(
          expenseAmount: await DBHelperExpense()
              .readTotalExpenseByPeriod(dateRange: dateRange),
          expenseDateRange: dateRange);
    }
  }
}

final homepageProvider =
    NotifierProvider<HomepageProvider, HomepageData>(HomepageProvider.new);
