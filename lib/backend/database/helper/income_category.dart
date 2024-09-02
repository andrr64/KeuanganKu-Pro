import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/income_category.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/main.dart';

class DBHelperIncomeCategory extends DBHelper<DBModelIncomeCategory> {
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', primary: true, constraint: 'AUTOINCREMENT'),
    createSql3Column(name: 'name', dtype: 'TEXT', required: true)
  ];

  @override
  String get tableName => 'income_categories';

  @override
  List<DBModelIncomeCategory> get initData => [
    DBModelIncomeCategory(name: 'Salary'),
    DBModelIncomeCategory(name: 'Business Income')
  ];

  @override
  Future<bool> delete({required DBModelIncomeCategory data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<DBModelIncomeCategory>> readAll() async {
    final List<Map<String, dynamic>> maps = await db.database.query(tableName);
    return List.generate(maps.length, (i) {
      return DBModelIncomeCategory(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  @override
  Future<DBModelIncomeCategory> readById({required int id}) async {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<bool> update({required DBModelIncomeCategory data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<int> insert({required DBModelIncomeCategory data}) {
    throw UnimplementedError();
  }
}
