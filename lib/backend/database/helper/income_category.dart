import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';

class DBHelperIncomeCategory extends DBHelper {
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', primary: true, constraint: 'AUTOINCREMENT'),
    createSql3Column(name: 'name', dtype: 'TEXT', required: true)
  ];

  @override
  String get tableName => 'income_categories';
}