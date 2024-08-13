import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/expense.dart'; // Pastikan sesuaikan dengan nama dan lokasi model yang sebenarnya
import 'package:keuanganku/backend/database/utility/table_column_generator.dart'; // Pastikan sesuaikan dengan nama dan lokasi utility yang sebenarnya

class DBHelperExpense extends DBHelper<DBModelExpense> {
  @override
  String get tableName => 'expenses';

  @override
  List<Map<String, String>> get tableColumns => [
        createSql3Column(
            name: 'id',
            dtype: 'INTEGER',
            constraint: 'PRIMARY KEY AUTOINCREMENT'),
        createSql3Column(name: 'title', dtype: 'TEXT', required: true),
        createSql3Column(name: 'amount', dtype: 'REAL', required: true),
        createSql3Column(name: 'description', dtype: 'TEXT'),
        createSql3Column(name: 'wallet_id', dtype: 'INTEGER', required: true),
        createSql3Column(name: 'category_id', dtype: 'INTEGER', required: true),
        createSql3Column(name: 'rate', dtype: 'INTEGER', required: true),
        createSql3Column(name: 'datetime', dtype: 'TEXT', required: true),
      ];

  @override
  List<DBModelExpense> get initData => [];

  @override
  Future<bool> delete(
      {required Database db, required DBModelExpense data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<DBModelExpense>> readAll({required Database db, DateRange? date}) async {
    String? startDate = date?.startDateISO8601;
    String? endDate = date?.endDateISO8601;

    final whereClause = (startDate != null && endDate != null)
        ? 'datetime >= ? AND datetime <= ?'
        : null;
    final whereArgs = (startDate != null && endDate != null)
        ? [startDate, endDate]
        : null;
    final List<Map<String, dynamic>> data = await db.query(
      tableName,
      where: whereClause,
      whereArgs: whereArgs,
    );
    return data.map((item) => DBModelExpense().fromJson(item)).toList();
  }

  @override
  Future<DBModelExpense> readById(
      {required Database db, required int id}) async {
    // TODO: implement readById
    throw UnimplementedError();
  }

  Future<List<DBModelExpense>> readByWalletId(
      {required Database db, required int wallet_id}) async {
    return await db.query(tableName,
        where: 'wallet_id = ?', whereArgs: [wallet_id]).then((expenses) {
      return List<DBModelExpense>.generate(expenses.length,
          (index) => DBModelExpense().fromJson(expenses[index]));
    });
  }

  @override
  Future<bool> update(
      {required Database db, required DBModelExpense data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<int> insert({required DBModelExpense data}) async{
    return await db.database.insert(tableName, data.toJson());
  }

  Future<double> readTotalExpense({required DateRange dateRange}) async {
    final listExpense = await readAll(db: db.database, date: dateRange);
    final result =
        listExpense.fold(0.0, (sum, expense) => sum + expense.amount!);
    return result;
  }

  Future<List<Map<String, dynamic>>> readTotalExpenseByCategory({
    required DateRange dateRange,
  }) async {
    String? startDate = dateRange.startDateISO8601;
    String? endDate = dateRange.endDateISO8601;

    final List<Map<String, dynamic>> result = await db.database.rawQuery('''
    SELECT category_id, SUM(amount) as total
    FROM $tableName
    WHERE datetime >= ? AND datetime <= ?
    GROUP BY category_id
  ''', [startDate, endDate]);
    return result;
  }

}