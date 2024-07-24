import 'package:keuanganku/frontend/components/enum/date_range.dart';
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
  Future<List<DBModelExpense>> readAll(
      {required Database db, DateRange? date}) async {
    String? startDate;
    String? endDate;

    if (date != null) {
      final now = DateTime.now();
      if (date == DateRange.monthly) {
        startDate = DateTime(now.year, now.month, 1).toIso8601String();
        endDate = DateTime(now.year, now.month + 1, 1)
            .subtract(const Duration(days: 1))
            .toIso8601String();
      } else if (date == DateRange.weekly) {
        final weekDay = now.weekday;
        startDate = now.subtract(Duration(days: weekDay - 1)).toIso8601String();
        endDate = now
            .add(Duration(days: DateTime.daysPerWeek - weekDay))
            .toIso8601String();
      } else if (date == DateRange.yearly) {
        startDate = DateTime(now.year, 1, 1).toIso8601String();
        endDate = DateTime(now.year + 1, 1, 1)
            .subtract(const Duration(days: 1))
            .toIso8601String();
      }

      return await db.query(
        tableName,
        where: 'datetime >= ? AND datetime <= ?',
        whereArgs: [startDate, endDate],
      ).then((data) {
        return List.generate(data.length, (i) {
          return DBModelExpense().fromJson(data[i]);
        });
      });
    } else {
      return await db.query(tableName).then((data) {
        return List.generate(data.length, (i) {
          return DBModelExpense().fromJson(data[i]);
        });
      });
    }
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
  Future<bool> save(
      {required Database db, required DBModelExpense data}) async {
    try {
      await db.insert(tableName, data.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> update(
      {required Database db, required DBModelExpense data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
