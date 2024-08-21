import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

/// The [DBHelperWallet] class is a concrete implementation of [DBHelper]
/// for managing wallet records in the database. It provides methods for CRUD operations
/// specific to wallet data and additional methods for updating wallet balances.
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

  /// Deletes a specific wallet record from the table.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [data]: The [DBModelWallet] instance to be deleted.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the delete operation was successful.
  @override
  Future<bool> delete({required Database db, required DBModelWallet data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  /// Reads all wallet records from the table.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  ///
  /// Returns:
  /// - A [Future<List<DBModelWallet>>] containing all wallet records.
  @override
  Future<List<DBModelWallet>> readAll({required Database db}) async {
    return await db.query(tableName).then((val){
      return List.generate(val.length, (index){
        return DBModelWallet().fromJson(val[index]);
      });
    });
  }

  /// Reads a specific wallet record by its ID.
  /// This method assumes that the record exists and may throw an error if the record is not found.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [id]: The unique ID of the wallet record.
  ///
  /// Returns:
  /// - A [Future<DBModelWallet>] representing the wallet record.
  @override
  Future<DBModelWallet> readById({required Database db, required int id}) async {
    // TODO: not safe code
    return DBModelWallet().fromJson(
        (await db.query(tableName, where: 'id = ?', whereArgs: [id]))[0]
    );
  }

  /// Inserts a new wallet record into the table.
  ///
  /// Parameters:
  /// - [data]: The [DBModelWallet] instance to be inserted.
  ///
  /// Returns:
  /// - A [Future<int>] representing the ID of the newly inserted wallet record.
  @override
  Future<int> insert({required DBModelWallet data}) async {
    return await db.database.insert(tableName, data.toJson());
  }

  /// Updates an existing wallet record in the table.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [data]: The [DBModelWallet] instance with updated data.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the update operation was successful.
  @override
  Future<bool> update({required Database db, required DBModelWallet data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  /// Adds income to the total income of a specific wallet.
  ///
  /// Parameters:
  /// - [walletId]: The unique ID of the wallet to which income is being added.
  /// - [income]: The amount of income to be added.
  ///
  /// Returns:
  /// - A [Future<void>] indicating that the income has been added.
  Future<void> addIncome({required int walletId, required double income}) async {
    final DBModelWallet wallet = await readById(db: db.database, id: walletId);
    await db.database.update(
      tableName,
      {'total_income': wallet.total_income! + income},
      where: 'id = ?',
      whereArgs: [walletId],
    );
  }

  /// Adds expense to the total expense of a specific wallet.
  ///
  /// Parameters:
  /// - [walletId]: The unique ID of the wallet to which expense is being added.
  /// - [expense]: The amount of expense to be added.
  ///
  /// Returns:
  /// - A [Future<void>] indicating that the expense has been added.
  Future<void> addExpense({required int walletId, required double expense}) async {
    final DBModelWallet wallet = await readById(db: db.database, id: walletId);
    await db.database.update(
      tableName,
      {'total_expense': wallet.total_expense! + expense},
      where: 'id = ?',
      whereArgs: [walletId],
    );
  }
}
