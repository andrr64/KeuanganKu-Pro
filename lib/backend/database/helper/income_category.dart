import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/income_category.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:sqflite/sqflite.dart';

/// The [DBHelperIncomeCategory] class is a concrete implementation of [DBHelper]
/// for managing income category records in the database. It provides methods for CRUD operations
/// specific to income category data.
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

  /// Deletes a specific income category record from the table.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [data]: The [DBModelIncomeCategory] instance to be deleted.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the delete operation was successful.
  @override
  Future<bool> delete({required Database db, required DBModelIncomeCategory data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  /// Reads all income category records from the table.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  ///
  /// Returns:
  /// - A [Future<List<DBModelIncomeCategory>>] containing all income category records.
  @override
  Future<List<DBModelIncomeCategory>> readAll({required Database db}) async {
    // Retrieve query results from the 'income_categories' table
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    // Convert query results into List<DBModelIncomeCategory>
    return List.generate(maps.length, (i) {
      return DBModelIncomeCategory(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  /// Reads a specific income category record by its ID.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [id]: The unique ID of the income category record.
  ///
  /// Returns:
  /// - A [Future<DBModelIncomeCategory>] representing the income category record.
  @override
  Future<DBModelIncomeCategory> readById({required Database db, required int id}) async {
    // TODO: implement readById
    throw UnimplementedError();
  }

  /// Updates an existing income category record in the table.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [data]: The [DBModelIncomeCategory] instance with updated data.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the update operation was successful.
  @override
  Future<bool> update({required Database db, required DBModelIncomeCategory data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  /// Inserts a new income category record into the table.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [data]: The [DBModelIncomeCategory] instance to be inserted.
  ///
  /// Returns:
  /// - A [Future<int>] representing the ID of the newly inserted income category record.
  @override
  Future<int> insert({required DBModelIncomeCategory data}) {
    throw UnimplementedError();
  }
}
