import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/main.dart';

class HomepageData {
  final DateRange incomesDateRange;
  final DateRange expenseDateRange;
  final double incomesAmount;
  final double expenseAmount;

  HomepageData({
    this.incomesDateRange = DateRange.week,
    this.expenseDateRange = DateRange.week,
    this.incomesAmount = 0,
    this.expenseAmount = 0
  });

  HomepageData copyWith({
    DateRange? incomeCardDateRange,
    double? incomesAmount,
    DateRange? expenseDateRange,
    double? expenseAmount
  }) {
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

  Future<void> initData() async{
    if (!_init){
      await updateIncomes();
      await updateExpense();
      _init = true;
    }
  }

  Future<void> updateIncomes() async => state = state.copyWith(incomesAmount: await DBHelperIncome().readTotalIncome(db: db.database, date: state.incomesDateRange));
  Future<void> updateExpense() async => state = state.copyWith(expenseAmount: await DBHelperExpense().readTotalExpense(dateRange: state.expenseDateRange));
  Future<void> setIncomeCardDateRange(DateRange dateRange) async{
    if (dateRange != state.incomesDateRange) {
      state = state.copyWith(
        incomesAmount: await DBHelperIncome().readTotalIncome(db: db.database, date: dateRange),
        incomeCardDateRange: dateRange
      );
    }
  }
  Future<void> setExpenseCardDateRange(DateRange dateRange) async{
    if (dateRange != state.expenseDateRange){
      state = state.copyWith(
          expenseAmount: await DBHelperExpense().readTotalExpense(dateRange: dateRange),
          expenseDateRange: dateRange
      );
    }
  }
}

final homepageProvider = NotifierProvider<HomepageProvider, HomepageData>(HomepageProvider.new);