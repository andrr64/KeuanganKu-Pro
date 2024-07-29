import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:keuanganku/main.dart';

class HomepageData {
  final DateRange incomesDateRange;
  final double incomesAmount;

  HomepageData({
    this.incomesDateRange = DateRange.week,
    this.incomesAmount = 0,
  });

  HomepageData copyWith({
    DateRange? incomeCardDateRange,
    double? incomesAmount,
  }) {
    return HomepageData(
      incomesDateRange: incomeCardDateRange ?? incomesDateRange,
      incomesAmount: incomesAmount ?? this.incomesAmount,
    );
  }
}

class HomepageProvider extends Notifier<HomepageData> {
  @override
  HomepageData build() {
    return HomepageData();
  }

  void updateIncomes() async {
    double updatedTotalIncomes = await DBHelperIncome().readTotalIncome(db: db.database, date: state.incomesDateRange);
    state = state.copyWith(incomesAmount: updatedTotalIncomes);
    print(updatedTotalIncomes);
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