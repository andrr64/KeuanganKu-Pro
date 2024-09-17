import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/userdata.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/main.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperUserdata extends DBHelper<DBModelUserdata> {
  @override
  Future<bool> delete({required DBModelUserdata data}) async {
    try {
      final id = data.id; // Pastikan DBModelUserdata memiliki atribut ID
      if (id == null) {
        throw Exception('ID cannot be null for delete operation');
      }

      final deleteCount = await db.database.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );

      return deleteCount > 0;
    } catch (e) {
      throw Exception('backend.database.helper.userdata.delete: $e');
    }
  }

  @override
  List<DBModelUserdata> get initData => [
    DBModelUserdata(name: null, locale: null)
  ];

  @override
  Future<int> insert({required DBModelUserdata data}) async {
    try {
      final id = await db.database.insert(
        tableName,
        data.toJson(), // Konversi data ke format map yang sesuai
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return id;
    } catch (e) {
      throw Exception('backend.database.helper.userdata.insert: $e');
    }
  }

  @override
  Future<List<DBModelUserdata>> readAll() async {
    ///TODO: implement readAlls
    throw UnimplementedError();
  }

  Future<DBModelUserdata> readUserdata() async {
    try {
      final data = await db.database.query(tableName);
      if (data.isEmpty) {
        return DBModelUserdata(name: null, locale: null);
      }
      return DBModelUserdata().fromJson(data.first);
    } catch (e) {
      throw Exception('backend.database.helper.userdata.readUserdata: $e');
    }
  }

  @override
  Future<DBModelUserdata> readById({required int id}) async {
    try {
      final data = await db.database.query(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
      if (data.isEmpty) {
        throw Exception('No data found with id: $id');
      }
      return DBModelUserdata().fromJson(data.first);
    } catch (e) {
      throw Exception('backend.database.helper.userdata.readById: $e');
    }
  }

  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', primary: true),
    createSql3Column(name: 'name', dtype: 'TEXT'),
    createSql3Column(name: 'locale', dtype: 'TEXT')
  ];

  @override
  String get tableName => 'userdata';

  @override
  Future<bool> update({required DBModelUserdata data}) async {
    try {
      final updateCount = await db.database.update(
        tableName,
        data.toJson(), // Konversi data ke format map yang sesuai
        where: 'id = ?',
        whereArgs: [data.id!], // Parameter untuk kondisi
      );

      return updateCount > 0;
    } catch (e) {
      throw Exception('backend.database.helper.userdata.update: $e');
    }
  }
}
