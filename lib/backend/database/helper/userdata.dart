import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/userdata.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/main.dart';

class DBHelperUserdata extends DBHelper {
  @override
  Future<bool> delete({required data}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  // TODO: implement initData
  List get initData => [
    DBModelUserdata(name: null, locale: null)
  ];

  @override
  Future<int> insert({required data}) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<List> readAll() {
    // TODO: implement readAll
    throw UnimplementedError();
  }

  Future<DBModelUserdata> readUserdata() async{
    try {
      final data = await db.database.query(tableName);
      if (data.isEmpty){
        return DBModelUserdata(name: null, locale: null);
      }
      return DBModelUserdata().fromJson(data.first);
    } catch (e){
      throw Exception('backend.database.helper.userdata.readUserData: $e');
    }
  }

  @override
  Future readById({required int id}) {
    // TODO: implement readById
    throw UnimplementedError();
  }

  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'name', dtype: 'TEXT'),
    createSql3Column(name: 'locale', dtype: 'TEXT')
  ];

  @override
  String get tableName => 'userdata';

  @override
  Future<bool> update({required data}) {
    // TODO: implement update
    throw UnimplementedError();
  }

}