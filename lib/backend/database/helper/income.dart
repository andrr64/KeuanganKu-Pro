import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperIncome extends DBHelper<DBModelIncome> {
  @override
  List<Map<String, String>> get tableColumns => [
    createSql3Column(name: 'id', dtype: 'INTEGER', constraint: 'PRIMARY KEY AUTOINCREMENT'),
    createSql3Column(name: 'title', dtype: 'TEXT', required: true),
    createSql3Column(name: 'amount', dtype: 'REAL', required: true),
    createSql3Column(name: 'description', dtype: 'TEXT'),
    createSql3Column(name: 'wallet_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'category_id', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'rate', dtype: 'INTEGER', required: true),
    createSql3Column(name: 'datetime', dtype: 'TEXT', required: true),
  ];

  @override
  String get tableName => 'incomes';

  @override
  List<DBModelIncome> get initData => [];

  @override
  Future<bool> delete({required Database db, required DBModelIncome data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<DBModelIncome>> readAll({required Database db, DateRange? date}) async {
    String? startDate;
    String? endDate;

    if (date != null) {
      final now = DateTime.now();
      if (date == DateRange.monthly) {
        startDate = DateTime(now.year, now.month, 1).toIso8601String();
        endDate = DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1)).toIso8601String();
      } else if (date == DateRange.weekly) {
        final weekDay = now.weekday;
        startDate = now.subtract(Duration(days: weekDay - 1)).toIso8601String();
        endDate = now.add(Duration(days: DateTime.daysPerWeek - weekDay)).toIso8601String();
      } else if (date == DateRange.yearly) {
        startDate = DateTime(now.year, 1, 1).toIso8601String();
        endDate = DateTime(now.year + 1, 1, 1).subtract(const Duration(days: 1)).toIso8601String();
      }

      final List<Map<String, dynamic>> data = await db.query(
        tableName,
        where: 'datetime >= ? AND datetime <= ?',
        whereArgs: [startDate, endDate],
      );
      return List.generate(data.length, (i) {
        return DBModelIncome().fromJson(data[i]);
      });
    } else {
      final List<Map<String, dynamic>> data = await db.query(tableName);
      return List.generate(data.length, (i) {
        return DBModelIncome().fromJson(data[i]);
      });
    }
  }

  @override
  Future<DBModelIncome> readById({required Database db, required int id}) async {
    // TODO: implement readById
    throw UnimplementedError();
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