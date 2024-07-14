import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';

class DBHelperIncome extends DBHelper {
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', constraint: 'PRIMARY KEY AUTOINCREMENT'),
    createSql3Column(name: 'title', dtype: 'TEXT', required: true),
    createSql3Column(name: 'description', dtype: 'TEXT'),
    createSql3Column(name: 'wallet_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'category_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'rate', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'datetime', dtype: 'TEXT', required: true),
  ];

  @override
  String get tableName => 'incomes';
}