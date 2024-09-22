import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/enum/time_period.dart';

class HomepageData {
  final TimePeriod incomeCardTimePeriod;
  final TimePeriod expenseCardTimePeriod;
  final double incomeAmount;
  final double expenseAmount;

  HomepageData(
      {this.incomeCardTimePeriod = TimePeriod.week,
      this.expenseCardTimePeriod = TimePeriod.week,
      this.incomeAmount = 0,
      this.expenseAmount = 0});

  HomepageData copyWith(
      {TimePeriod? incomeCardDateRange,
      double? incomesAmount,
      TimePeriod? expenseDateRange,
      double? expenseAmount}) {
    return HomepageData(
      incomeCardTimePeriod: incomeCardDateRange ?? incomeCardTimePeriod,
      incomeAmount: incomesAmount ?? incomeAmount,
      expenseCardTimePeriod: expenseDateRange ?? expenseCardTimePeriod,
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

  Future<void> refreshData() async {
    await updateIncomes();
    await updateExpense();
  }

  Future<void> updateIncomes() async => state = state.copyWith(
      incomesAmount: await DBHelperIncome()
          .readTotalIncome(date: state.incomeCardTimePeriod));

  Future<void> updateExpense() async => state = state.copyWith(
      expenseAmount: await DBHelperExpense()
          .readTotalExpenseByPeriod(dateRange: state.expenseCardTimePeriod));

  Future<void> setIncomeCardDateRange(TimePeriod dateRange) async {
    if (dateRange != state.incomeCardTimePeriod) {
      state = state.copyWith(
          incomesAmount:
              await DBHelperIncome().readTotalIncome(date: dateRange),
          incomeCardDateRange: dateRange);
    }
  }

  Future<void> setExpenseCardDateRange(TimePeriod dateRange) async {
    if (dateRange != state.expenseCardTimePeriod) {
      state = state.copyWith(
          expenseAmount: await DBHelperExpense()
              .readTotalExpenseByPeriod(dateRange: dateRange),
          expenseDateRange: dateRange);
    }
  }
}

final homepageProvider =
    NotifierProvider<HomepageProvider, HomepageData>(HomepageProvider.new);
