import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

/// The [DBHelperIncome] class is a concrete implementation of [DBHelper]
/// for managing income records in the database. It provides methods for CRUD operations
/// specific to income data.
class DBHelperIncome extends DBHelper<DBModelIncome> {
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', constraint: 'PRIMARY KEY AUTOINCREMENT'),
    createSql3Column(name: 'title', dtype: 'TEXT', required: true),
    createSql3Column(name: 'amount', dtype: 'REAL', required: true),
    createSql3Column(name: 'description', dtype: 'TEXT'),
    createSql3Column(name: 'wallet_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'category_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'datetime', dtype: 'TEXT', required: true),
  ];

  @override
  String get tableName => 'incomes';

  @override
  List<DBModelIncome> get initData => [];

  /// Deletes a specific income record from the table.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [data]: The [DBModelIncome] instance to be deleted.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the delete operation was successful.
  @override
  Future<bool> delete({required Database db, required DBModelIncome data}) async {
    throw UnimplementedError();
  }

  /// Calculates the total income within a given date range.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [date]: An optional [DateRange] for filtering the results.
  ///
  /// Returns:
  /// - A [Future<double>] representing the total income.
  Future<double> readTotalIncome({required Database db, DateRange? date}) async {
    List<DBModelIncome> data = await readAll(db: db, date: date);
    double result = data.fold(0, (sum, income) => sum + income.amount!);
    return result;
  }

  /// Reads all income records from the table within a given date range.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [date]: An optional [DateRange] for filtering the results.
  ///
  /// Returns:
  /// - A [Future<List<DBModelIncome>>] containing all income records.
  @override
  Future<List<DBModelIncome>> readAll({required Database db, DateRange? date}) async {
    String? startDate = date?.startDateISO8601;
    String? endDate = date?.endDateISO8601;

    final whereClause = (startDate != null && endDate != null)
        ? 'datetime >= ? AND datetime <= ?'
        : null;
    final whereArgs = (startDate != null && endDate != null)
        ? [startDate, endDate]
        : null;

    final List<Map<String, dynamic>> data = await db.query(
      tableName,
      where: whereClause,
      whereArgs: whereArgs,
    );
    return data.map((item) => DBModelIncome().fromJson(item)).toList();
  }

  /// Reads a specific income record by its ID.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [id]: The unique ID of the income record.
  ///
  /// Returns:
  /// - A [Future<DBModelIncome>] representing the income record.
  @override
  Future<DBModelIncome> readById({required Database db, required int id}) async {
    // TODO: implement readById
    throw UnimplementedError();
  }

  /// Reads all income records associated with a specific wallet ID.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [wallet_id]: The ID of the wallet.
  ///
  /// Returns:
  /// - A [Future<List<DBModelIncome>>] containing all income records for the specified wallet.
  Future<List<DBModelIncome>> readByWalletId({required Database db, required int wallet_id}) async {
    return await db.query(tableName, where: 'wallet_id = ?', whereArgs: [wallet_id]).then((incomes) {
      return List<DBModelIncome>.generate(incomes.length, (index) {
        return DBModelIncome().fromJson(incomes[index]);
      });
    });
  }

  /// Updates an existing income record in the table.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [data]: The [DBModelIncome] instance with updated data.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the update operation was successful.
  @override
  Future<bool> update({required Database db, required DBModelIncome data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  /// Inserts a new income record into the table.
  ///
  /// Parameters:
  /// - [data]: The [DBModelIncome] instance to be inserted.
  ///
  /// Returns:
  /// - A [Future<int>] representing the ID of the newly inserted income record.
  @override
  Future<int> insert({required DBModelIncome data}) async {
    return await db.database.insert(tableName, data.toJson());
  }
}
