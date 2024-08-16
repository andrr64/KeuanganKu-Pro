import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/enum/date_range.dart';

class APIExpenseData{
  static Future<List<DBModelExpenseByCategory>> getExpenseTotalByCategories({
    DateRange range = DateRange.month,
    required DBModelExpenseCategory Function(int) expenseCategoryGetter }) async
  {
    final data = await DBHelperExpense().readTotalExpenseByCategory(dateRange: range);
    return List.generate(data.length, (index){
      final _ = data[index];
      return DBModelExpenseByCategory(category: expenseCategoryGetter(_['category_id']), total: _['total']);
    });
  }
}