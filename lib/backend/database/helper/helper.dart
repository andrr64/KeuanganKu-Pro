import 'package:keuanganku/backend/database/model/model.dart';
import 'package:sqflite/sqflite.dart';

/// The [DBHelper] class provides an abstract interface for database operations.
/// It defines common methods and properties for managing a database table of type [T].
///
/// [T] represents the type of the model that this helper will manage.
abstract class DBHelper<T> {
  /// The name of the table in the database.
  String get tableName;

  /// Defines the columns of the table in the form of a list of maps, where each map
  /// specifies the column name, data type, and constraints.
  List<Map<String, String>> get tableColumns;

  /// Returns the SQL query to create the table if it does not exist.
  /// The query is constructed based on [tableColumns].
  String get createTableQuery  {
    final columns = tableColumns.map((column) {
      return '${column['name']} ${column['dtype']} ${column['constraint']}';
    }).join(', ');
    return """
    CREATE TABLE IF NOT EXISTS $tableName (
      $columns
    );
    """;
  }

  /// Initial data to populate the table. Returns a list of [T] objects.
  List<T> get initData;

  /// Inserts a new record into the table.
  ///
  /// Parameters:
  /// - [data]: The [T] instance to be inserted.
  ///
  /// Returns:
  /// - A [Future<int>] representing the ID of the newly inserted record.
  Future<int> insert({required T data});

  /// Updates an existing record in the table.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [data]: The [T] instance with updated data.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the update operation was successful.
  Future<bool> update ({required T data});

  /// Deletes a record from the table.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [data]: The [T] instance to be deleted.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the delete operation was successful.
  Future<bool> delete({required T data});

  /// Reads a specific record by its ID.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  /// - [id]: The unique ID of the record.
  ///
  /// Returns:
  /// - A [Future<T>] representing the record.
  Future<T> readById({required int id});

  /// Reads all records from the table.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  ///
  /// Returns:
  /// - A [Future<List<T>>] containing all records.
  Future<List<T>> readAll();

  /// Creates the table in the database and populates it with initial data if available.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  ///
  /// Returns:
  /// - A [Future<void>] that completes when the table creation and initial data insertion are finished.
  Future<void> createTable(Database db) async {
    await db.execute(createTableQuery);
    if (initData.isNotEmpty){
      for (var item in initData) {
        DBModel data = item as DBModel;
        await db.database.insert(tableName, (data).toJson());
      }
    }
  }

  /// Checks if the table exists in the database.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  ///
  /// Returns:
  /// - A [Future<bool>] indicating whether the table exists.
  Future<bool> checkTable(Database db) async {
    final result = await db.rawQuery(
        '''
    SELECT name
    FROM sqlite_master
    WHERE type='table' AND name=?
    ''', [tableName]
    );
    return result.isNotEmpty;
  }

  /// Checks if the table does not exist and creates it if necessary.
  ///
  /// Parameters:
  /// - [db]: The database instance.
  ///
  /// Returns:
  /// - A [Future<void>] that completes when the check and possible table creation are finished.
  Future<void> checkIfNotExistThenCreate(Database db) async {
    if (!(await checkTable(db))){
      await createTable(db);
    }
  }
}