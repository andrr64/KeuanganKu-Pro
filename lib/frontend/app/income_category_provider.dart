import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/database/helper/income_category.dart';
import 'package:keuanganku/backend/database/model/income_category.dart';
import 'package:keuanganku/main.dart';

final globalIncomeCategoriesProvider = NotifierProvider<IncomesCategoryProvider, List<DBModelIncomeCategory>>(IncomesCategoryProvider.new);

class IncomesCategoryProvider extends Notifier<List<DBModelIncomeCategory>>{
  bool init = false;

  @override
  List<DBModelIncomeCategory> build() {
    return [];
  }

  void initData() async {
    if (!init){
      state = await DBHelperIncomeCategory().readAll(db: db.database);
      init = true;
    }
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