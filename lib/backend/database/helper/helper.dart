import 'package:sqflite/sqflite.dart';

abstract class DBHelper {
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

  Future<void> createTable(Database db) async {
    await db.execute(createTableQuery);
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