import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void updateIncomes() async {
    double updatedTotalIncomes = await DBHelperIncome().readTotalIncome(db: db.database, date: state.incomesDateRange);
    state = state.copyWith(incomesAmount: updatedTotalIncomes);
  }

  void setIncomeCardDateRange(DateRange dateRange) async{
    double? updatedTotalIncomes;
    if (dateRange != state.incomesDateRange){
      updatedTotalIncomes = await DBHelperIncome().readTotalIncome(db: db.database, date: dateRange);
    }
    state = state.copyWith(incomeCardDateRange: dateRange, incomesAmount: updatedTotalIncomes);
  }
}

final homepageProvider = NotifierProvider<HomepageProvider, HomepageData>(HomepageProvider.new);