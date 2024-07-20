import 'package:keuanganku/backend/database/model/model.dart';
import 'package:sqflite/sqflite.dart';

abstract class DBHelper<T> {
  String get tableName;

  List<Map<String, String>> get tableColumns;

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

  List<T> get initData;

  Future<bool> save({required Database db, required T data});
  Future<bool> update ({required Database db, required T data});
  Future<bool> delete({required Database db, required T data});
  Future<T> readById({required Database db, required int id});
  Future<List<T>> readAll({required Database db});

  Future<void> createTable(Database db) async {
    await db.execute(createTableQuery);
    if (initData.length != 0){
      for (var item in initData) {
        DBModel _data = item as DBModel;
        await db.insert(tableName, (_data).toJson());
      }
    }
  }

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

  Future<void> checkIfNotExistThenCreate(Database db) async {
    if (!(await checkTable(db))){
      await createTable(db);
    }
  }
}