import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperIncome extends DBHelper<DBModelIncome> {
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', constraint: 'PRIMARY KEY AUTOINCREMENT'),
    createSql3Column(name: 'title', dtype: 'TEXT', required: true),
    createSql3Column(name: 'description', dtype: 'TEXT'),
    createSql3Column(name: 'wallet_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'category_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'rate', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'datetime', dtype: 'TEXT', required: true),
  ];

  @override
  String get tableName => 'incomes';

  @override
  List<DBModelIncome> get initData => [];

  @override
  Future<bool> delete({required Database db, required DBModelIncome data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<DBModelIncome>> readAll({required Database db}) async {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  @override
  Future<DBModelIncome> readById({required Database db, required int id}) async {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<bool> save({required Database db, required DBModelIncome data}) async {
    try {
      await db.insert(tableName, data.toJson());
      return true;
    } catch (e){
      return false;
    }
  }

  @override
  Future<bool> update({required Database db, required DBModelIncome data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

}