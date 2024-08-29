import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/database/helper/expense_category.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/income_category.dart';
import 'package:keuanganku/main.dart';

final globalExpenseCategoriesProvider = NotifierProvider<ExpenseCategoryProvider, List<DBModelExpenseCategory>>(ExpenseCategoryProvider.new);

class ExpenseCategoryProvider extends Notifier<List<DBModelExpenseCategory>>{
  bool init = false;

  @override
  List<DBModelExpenseCategory> build() {
    return [];
  }

  void initData() async {
    if (!init){
      state = await DBHelperExpenseCategory().readAll(db: db.database);
      init = true;
    }
  }

  void updateFromDatabase() async {
    state = await DBHelperExpenseCategory().readAll(db: db.database);
  }

  void add(DBModelExpenseCategory newExpenseCategory) async{
    await newExpenseCategory.insert();
    state = [...state, newExpenseCategory];
  }

  void remove(DBModelIncomeCategory target){
    state = [
      for (final category in state) if (category.id! != target.id!) category
    ];
  }

  DBModelExpenseCategory getById(int target_id){
    for (int i = 0; i < state.length; i++){
      if (state[i].id == target_id) {
        return  state[i];
      }
    }
    return DBModelExpenseCategory(name: 'Unknown');
  }
}