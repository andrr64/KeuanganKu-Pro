import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelperIncome extends DBHelper<DBModelIncome> {
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', constraint: 'PRIMARY KEY AUTOINCREMENT'),
    createSql3Column(name: 'title', dtype: 'TEXT', required: true),
    createSql3Column(name: 'amount', dtype: 'REAL', required: true),
    createSql3Column(name: 'description', dtype: 'TEXT'),
    createSql3Column(name: 'wallet_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'category_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'datetime', dtype: 'TEXT', required: true),
  ];

  @override
  String get tableName => 'incomes';

  @override
  List<DBModelIncome> get initData => [];

  @override
  Future<bool> delete({required Database db, required DBModelIncome data}) async {
    throw UnimplementedError();
  }

  Future<double> readTotalIncome({required Database db, DateRange? date}) async {
    List<DBModelIncome> data = await readAll(db: db, date: date);
    double result = data.fold(0, (sum, income) => sum + income.amount!);
    return result;
  }

  @override
  Future<List<DBModelIncome>> readAll({required Database db, DateRange? date}) async {
    final now = DateTime.now();
    String? startDate;
    String? endDate;

    if (date != null) {
      switch (date) {
        case DateRange.month:
          startDate = DateTime(now.year, now.month, 1).toIso8601String();
          endDate = DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1)).toIso8601String();
          break;
        case DateRange.week:
          final startOfWeek = now.subtract(Duration(days: now.weekday - 1)).copyWith(hour: 0, minute: 0, second: 0);
          final endOfWeek = startOfWeek.add(const Duration(days: DateTime.daysPerWeek - 1)).copyWith(hour: 23, minute: 59, second: 59);
          startDate = startOfWeek.toIso8601String();
          endDate = endOfWeek.toIso8601String();
          break;
        case DateRange.year:
          startDate = DateTime(now.year, 1, 1).toIso8601String();
          endDate = DateTime(now.year + 1, 1, 1).subtract(const Duration(days: 1)).toIso8601String();
          break;
      }

      final List<Map<String, dynamic>> data = await db.query(
        tableName,
        where: 'datetime >= ? AND datetime <= ?',
        whereArgs: [startDate, endDate],
      );
      return data.map((item) => DBModelIncome().fromJson(item)).toList();
    } else {
      final List<Map<String, dynamic>> data = await db.query(tableName);
      return data.map((item) => DBModelIncome().fromJson(item)).toList();
    }
  }

  @override
  Future<DBModelIncome> readById({required Database db, required int id}) async {
    // TODO: implement readById
    throw UnimplementedError();
  }

  Future<List<DBModelIncome>> readByWalletId({required Database db, required int wallet_id}) async {
    return await db.query(tableName, where: 'wallet_id = ?', whereArgs: [wallet_id]).then((incomes){
      return List<DBModelIncome>.generate(incomes.length, (index){
        return DBModelIncome().fromJson(incomes[index]);
      });
    });
  }

  @override
  Future<bool> save({required Database db, required DBModelIncome data}) async {
    try {
      await db.insert(tableName, data.toJson());
      return true;
    } catch (e){
      return false;
    }
  }

  @override
  Future<bool> update({required Database db, required DBModelIncome data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}