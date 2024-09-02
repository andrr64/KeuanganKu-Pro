import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/expense_limiter.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/main.dart';

class DBHelperExpenseLimiter extends DBHelper<DBModelExpenseLimiter> {
  @override
  Future<bool> delete({required DBModelExpenseLimiter data}) {
    throw UnimplementedError();
  }

  @override
  List<DBModelExpenseLimiter> get initData => [];

  @override
  Future<int> insert({required DBModelExpenseLimiter data}) async{
    return await db.database.insert(tableName, data.toJson());
  }

  @override
  Future<List<DBModelExpenseLimiter>> readAll() async{
    final query_result = await db.database.query(tableName);
    if (query_result.isEmpty){
      return [];
    }
    final modelGenerator = DBModelExpenseLimiter();
    List<DBModelExpenseLimiter> result = [];
    for (final e in query_result){
      DBModelExpenseLimiter x = modelGenerator.fromJson(e);
      final expenses_amount = await DBHelperExpense().readWithWhereClause(
        where: 'datetime >= ? AND datetime <= ? AND category_id = ?', 
        whereArgs: [x.period.startDateISO8601, x.period.endDateISO8601, x.category_id]
      );
      x.current_amount = expenses_amount.fold(0.0, (sum, i) => sum + i.amount!);
      result.add(x);
    }
    return result;
  }

  @override
  Future<DBModelExpenseLimiter> readById({required int id}) async {
    final query_result = await db.database.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (query_result.isEmpty){
      throw Exception('Empty data');
    }
    DBModelExpenseLimiter data = DBModelExpenseLimiter().fromJson(query_result.first);
    if (query_result.isEmpty) throw Exception('No data found for the given ID.');
    final expense_amount = await DBHelperExpense().readWithWhereClause(
      where: 'datetime >= ? AND datetime <= ? AND category_id = ?', 
      whereArgs: [data.period.startDateISO8601, data.period.endDateISO8601, data.category_id]
    );
    data.current_amount = expense_amount.fold(0.0, (sum, i) => sum + i.amount!);
    return data;
  }
  
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', primary: true, required: true),
    createSql3Column(name: 'category_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'limit_amount', dtype: 'DOUBLE', required: true),
    createSql3Column(name: 'period_id', dtype: 'INTEGER', required: true)
  ];


  @override
  String get tableName => 'expense_limiter';

  @override
  Future<bool> update({required DBModelExpenseLimiter data}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}