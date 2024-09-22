import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/database/helper/income_category.dart';
import 'package:keuanganku/backend/database/model/income_category.dart';

final globalIncomeCategoriesProvider = NotifierProvider<IncomesCategoryProvider, List<DBModelIncomeCategory>>(IncomesCategoryProvider.new);

class IncomesCategoryProvider extends Notifier<List<DBModelIncomeCategory>>{
  bool init = false;

  @override
  List<DBModelIncomeCategory> build() {
    return [];
  }

  Future<void> initData() async {
    if (!init){
      state = await DBHelperIncomeCategory().readAll();
      init = true;
    }
  }

  void updateFromDatabase() async {
    state = await DBHelperIncomeCategory().readAll();
  }

  void add(DBModelIncomeCategory incomeCategory){
    state = [...state, incomeCategory];
  }

  void remove(DBModelIncomeCategory target){
    state = [
      for (final category in state) if (category.id! != target.id!) category
    ];
  }
}