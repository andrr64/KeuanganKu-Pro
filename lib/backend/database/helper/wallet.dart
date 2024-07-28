import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperWallet extends DBHelper<DBModelWallet> {
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', required: true, constraint: 'PRIMARY KEY'),
    createSql3Column(name: 'name', dtype: 'TEXT', required: true),
    createSql3Column(name: 'type', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'total_income', dtype: 'REAL', required: true),
    createSql3Column(name: 'total_expense', dtype: 'REAL', required: true),
  ];

  @override
  String get tableName => 'wallets';

  @override
  List<DBModelWallet> get initData => [];

  @override
  Future<bool> delete({required Database db, required DBModelWallet data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<DBModelWallet>> readAll({required Database db}) async {
    return await db.query(tableName).then((val){
      return List.generate(val.length, (index){
        return DBModelWallet().fromJson(val[index]);
      });
    });
  }

  @override
  Future<DBModelWallet> readById({required Database db, required int id}) async {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  Future<bool> save({required Database db, required DBModelWallet data}) async {
    await db.insert(tableName, data.toJson());
    return true;
  }

  Future<DBModelWallet> insert({required Database db, required DBModelWallet data}) async {
    int id = await db.insert(tableName, data.toJson());
    return DBModelWallet().copyFrom(data, id: id);
  }

  @override
  Future<bool> update({required Database db, required DBModelWallet data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}