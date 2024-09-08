import 'package:keuanganku/backend/database/helper/expense_category.dart';
import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/expense_limiter.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
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
    try {
      return await db.database.insert(tableName, data.toJson());
    } catch (e){
      throw Exception(e);
    }
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
      DBModelExpenseCategory category = await DBHelperExpenseCategory().readById(id: int.parse(e['category_id'].toString()));
      x.category = category;
      await x.updateCurrentAmount();
      result.add(x);
    }
    return result;
  }

  @override
  Future<DBModelExpenseLimiter> readById({required int id}) async {
    ///TODO: implement db.helper.expenselimiter.readById
    throw UnimplementedError();
  }
  
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', primary: true, required: true),
    createSql3Column(name: 'category_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'wallet_id', dtype: 'INTEGER', required: true),
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