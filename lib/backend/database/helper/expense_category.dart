import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/main.dart';
import 'package:sqflite/sqflite.dart';

/// The [DBHelperExpenseCategory] class is a concrete implementation of [DBHelper]
/// for managing expense categories in the database. It provides methods for CRUD operations
/// specific to expense categories.
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
    DBModelExpenseCategory(name: 'Transportation'),
    DBModelExpenseCategory(name: 'Household'),
    DBModelExpenseCategory(name: 'Health'),
    DBModelExpenseCategory(name: 'Shopping'),
    DBModelExpenseCategory(name: 'Debt Payments')
  ];

  /// Deletes a specific expense category from the table.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [data]: The [DBModelExpenseCategory] instance to be deleted.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the delete operation was successful.
  @override
  Future<bool> delete({required Database db, required DBModelExpenseCategory data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  /// Reads all expense categories from the table.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  ///
  /// Returns:
  /// - A [Future<List<DBModelExpenseCategory>>] containing all expense categories.
  @override
  Future<List<DBModelExpenseCategory>> readAll({required Database db}) async {
    List<Map<String, dynamic>> data = await db.query(tableName);
    return List.generate(data.length, (index) => DBModelExpenseCategory().fromJson(data[index]));
  }

  /// Reads a specific expense category by its ID.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [id]: The unique ID of the expense category.
  ///
  /// Returns:
  /// - A [Future<DBModelExpenseCategory>] representing the expense category.
  @override
  Future<DBModelExpenseCategory> readById({
    required Database db,
    required int id
  }) async {
    // Menjalankan query untuk mengambil satu baris berdasarkan id
    final List<Map<String, dynamic>> result = await db.database.query(
      tableName,
      where: 'id = ?', // Filter berdasarkan id
      whereArgs: [id], // Nilai dari id yang akan dicari
      limit: 1, // Hanya mengambil satu baris
    );

    // Jika tidak ada data yang ditemukan, lempar exception atau kembalikan nilai null
    if (result.isEmpty) {
      throw Exception('No data found for id $id');
    }

    // Mengembalikan instance DBModelExpenseCategory dari hasil query
    return DBModelExpenseCategory().fromJson(result.first);
  }


  /// Updates an existing expense category in the table.
  /// This method is not yet implemented.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [data]: The [DBModelExpenseCategory] instance with updated data.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the update operation was successful.
  @override
  Future<bool> update({required Database db, required DBModelExpenseCategory data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  /// Inserts a new expense category into the table.
  ///
  /// Parameters:
  /// - [data]: The [DBModelExpenseCategory] instance to be inserted.
  ///
  /// Returns:
  /// - A [Future<int>] representing the ID of the newly inserted expense category.
  @override
  Future<int> insert({required DBModelExpenseCategory data}) async{
    final newId = await db.database.insert(tableName, data.toJson());
    return newId;
  }
}
