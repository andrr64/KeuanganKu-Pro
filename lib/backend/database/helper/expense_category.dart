import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';

class DBHelperExpenseCategory extends DBHelper {
  @override
  String get tableName => 'expense_categories';

  @override
  List<Map<String, String>> get tableColumns {
    return [
      createSql3Column(name: 'id', dtype: 'INTEGER', primary: true, constraint: 'AUTOINCREMENT' ),
      createSql3Column(name: 'name', dtype: 'TEXT', required: true)
    ];
  }
}