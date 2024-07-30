import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
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

  void initData() async{
    if (!_init){
      updateIncomes();
      _init = true;
    }
  }

  void updateIncomes() async => state = state.copyWith(incomesAmount: await DBHelperIncome().readTotalIncome(db: db.database, date: state.incomesDateRange));
  void updateExpense() async => state = state.copyWith(expenseAmount: await DBHelperExpense().readTotalExpense(dateRange: state.expenseDateRange));
  void updateAll() {
    updateIncomes();
    updateExpense();
  }

  void setIncomeCardDateRange(DateRange dateRange) async{
    if (dateRange != state.incomesDateRange) {
      state = state.copyWith(
        incomesAmount: await DBHelperIncome().readTotalIncome(db: db.database, date: state.incomesDateRange),
        incomeCardDateRange: dateRange
      );
    }
  }
  void setExpenseCardDateRange(DateRange dateRange) async{
    if (dateRange != state.expenseDateRange){
      state = state.copyWith(
          expenseAmount: await DBHelperExpense().readTotalExpense(dateRange: state.incomesDateRange),
          expenseDateRange: dateRange
      );
    }
  }
}

final homepageProvider = NotifierProvider<HomepageProvider, HomepageData>(HomepageProvider.new);