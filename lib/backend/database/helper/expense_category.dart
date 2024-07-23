import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperExpenseCategory extends DBHelper<DBModelExpenseCategory> {
  @override
  String get tableName => 'expense_categories';

  @override
  List<Map<String, String>> get tableColumns {
    return [
      createSql3Column(name: 'id', dtype: 'INTEGER', primary: true, constraint: 'AUTOINCREMENT' ),
      createSql3Column(name: 'name', dtype: 'TEXT', required: true)
    ];
  }

  @override
  List<DBModelExpenseCategory> get initData => [
    DBModelExpenseCategory(name: 'Food'),
    DBModelExpenseCategory(name: 'Transporation'),
    DBModelExpenseCategory(name: 'Household'),
    DBModelExpenseCategory(name: 'Health'),
    DBModelExpenseCategory(name: 'Shopping'),
    DBModelExpenseCategory(name: 'Debt Payments')
  ];

  @override
  Future<bool> delete({required Database db, required DBModelExpenseCategory data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<DBModelExpenseCategory>> readAll({required Database db}) async {
    List<Map<String, dynamic>> data = await db.query(tableName);
    return List.generate(data.length, (index) => DBModelExpenseCategory().fromJson(data[index]));
  }

  @override
  Future<DBModelExpenseCategory> readById({required Database db, required int id}) async {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<bool> save({required Database db, required DBModelExpenseCategory data}) async {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<bool> update({required Database db, required DBModelExpenseCategory data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

}