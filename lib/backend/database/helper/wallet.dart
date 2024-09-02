import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/main.dart';

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
  Future<bool> delete({required DBModelWallet data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<DBModelWallet>> readAll() async {
    return await db.database.query(tableName).then((val){
      return List.generate(val.length, (index){
        return DBModelWallet().fromJson(val[index]);
      });
    });
  }

  @override
  Future<DBModelWallet> readById({required int id}) async {
    return DBModelWallet().fromJson((await db.database.query(tableName, where: 'id = ?', whereArgs: [id])).first);
  }

  @override
  Future<int> insert({required DBModelWallet data}) async {
    return await db.database.insert(tableName, data.toJson());
  }

  @override
  Future<bool> update({required DBModelWallet data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<void> addIncome({required int walletId, required double income}) async {
    final DBModelWallet wallet = await readById(id: walletId);
    await db.database.update(
      tableName,
      {'total_income': wallet.total_income! + income},
      where: 'id = ?',
      whereArgs: [walletId],
    );
  }

  Future<void> addExpense({required int walletId, required double expense}) async {
    final DBModelWallet wallet = await readById(id: walletId);
    await db.database.update(
      tableName,
      {'total_expense': wallet.total_expense! + expense},
      where: 'id = ?',
      whereArgs: [walletId],
    );
  }
}
