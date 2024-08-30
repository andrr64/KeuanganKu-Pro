import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperExpenseLimiter extends DBHelper {
  @override
  Future<bool> delete({required Database db, required data}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  List get initData => [

  ];

  @override
  Future<int> insert({required data}) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<List> readAll({required Database db}) {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future readById({required Database db, required int id}) {
    // TODO: implement readById
    throw UnimplementedError();
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
  Future<bool> update({required Database db, required data}) {
    // TODO: implement update
    throw UnimplementedError();
  }

}