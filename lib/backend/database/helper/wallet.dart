import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';

class DBHelperWallet extends DBHelper {
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', required: true, constraint: 'PRIMARY KEY'),
    createSql3Column(name: 'name', dtype: 'TEXT', required: true),
    createSql3Column(name: 'type', dtype: 'INTEGER', required: true)
  ];

  @override
  String get tableName => 'wallets';
}