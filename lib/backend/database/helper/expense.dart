import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/expense_category.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';

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
  Future<bool> delete({required DBModelExpense data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<DBModelExpense>> readAll(
      {DateRange? date, bool oldToNew = true}) async {
    String? startDate = date?.startDateISO8601;
    String? endDate = date?.endDateISO8601;

    final whereClause = (startDate != null && endDate != null)
        ? 'datetime >= ? AND datetime <= ?'
        : null;
    final whereArgs =
        (startDate != null && endDate != null) ? [startDate, endDate] : null;
    final List<Map<String, dynamic>> data = await db.database.query(
      tableName,
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: 'datetime ${oldToNew ? 'ASC' : 'DESC'}', // Order by oldToNew
    );
    return data.map((item) => DBModelExpense().fromJson(item)).toList();
  }

  Future<List<DBModelExpense>> readWithWhereClause(
      {required String where, required List whereArgs}) async {
    final query_result =
        await db.database.query(tableName, where: where, whereArgs: whereArgs);
    return query_result.map((e) => DBModelExpense().fromJson(e)).toList();
  }

  @override
  Future<DBModelExpense> readById({required int id}) async {
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
  Future<bool> update({required DBModelExpense data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<int> insert({required DBModelExpense data}) async {
    return await db.database.insert(tableName, data.toJson());
  }

  Future<double> readTotalExpenseByPeriod(
      {required DateRange dateRange}) async {
    final listExpense = await readAll(date: dateRange);
    final result =
        listExpense.fold(0.0, (sum, expense) => sum + expense.amount!);
    return result;
  }

  Future<List<DBModelExpenseByTime>> readExpenseThenGroupByDate(
      {required DateRange period}) async {
    // Retrieve all expenses within the given date range
    final listExpense = await readAll(date: period);
    if (listExpense.isEmpty) {
      return [];
    }
    // Create a list to hold expenses grouped by date range
    List<DBModelExpenseByTime> groupedExpenses = [];

    // Initialize the start and end dates of the period
    DateTime startDate = period.startDate;
    DateTime endDate = period.endDate;

    if (period == DateRange.year) {
      // Group by month if the period is yearly
      for (int month = 1; month <= 12; month++) {
        DateTimeRange dateRangeForMonth;

        // Handle edge cases for December
        if (month == 12) {
          dateRangeForMonth = DateTimeRange(
            start: DateTime(startDate.year, month, 1, 0, 0, 0),
            end: DateTime(startDate.year, month + 1, 1, 0, 0, 0)
                .subtract(const Duration(seconds: 1)),
          );
        } else {
          dateRangeForMonth = DateTimeRange(
            start: DateTime(startDate.year, month, 1, 0, 0, 0),
            end: DateTime(startDate.year, month + 1, 1, 0, 0, 0)
                .subtract(const Duration(seconds: 1)),
          );
        }

        // Retrieve all expenses within this date range
        List<DBModelExpense> expensesForMonth = listExpense.where((expense) {
          DateTime expenseDate = DateTime.parse(expense.datetime!);
          return dateRangeForMonth.start.isBefore(expenseDate) &&
              dateRangeForMonth.end.isAfter(expenseDate);
        }).toList();

        groupedExpenses.add(
          DBModelExpenseByTime(
            dateTimeRange: dateRangeForMonth,
            expenses: expensesForMonth.isNotEmpty
                ? expensesForMonth
                : [
                    DBModelExpense(amount: 0)
                  ], // Add a dummy expense with total 0 if no expenses found
          ),
        );
      }
    } else {
      for (DateTime currentDate = startDate;
          currentDate.isBefore(endDate) ||
              currentDate.isAtSameMomentAs(endDate);
          currentDate = currentDate.add(const Duration(days: 1))) {
        DateTimeRange dateRangeForDay = DateTimeRange(
          start: DateTime(
              currentDate.year, currentDate.month, currentDate.day, 0, 0, 0),
          end: DateTime(
              currentDate.year, currentDate.month, currentDate.day, 23, 59, 59),
        );

        List<DBModelExpense> expensesForDay = listExpense.where((expense) {
          DateTime expenseDate = DateTime.parse(expense.datetime!);
          return dateRangeForDay.start.isBefore(expenseDate) &&
              dateRangeForDay.end.isAfter(expenseDate);
        }).toList();

        groupedExpenses.add(
          DBModelExpenseByTime(
            dateTimeRange: dateRangeForDay,
            expenses: expensesForDay.isNotEmpty
                ? expensesForDay
                : [
                    DBModelExpense(amount: 0)
                  ], // Add a dummy expense with total 0 if no expenses found
          ),
        );
      }
    }
    return groupedExpenses;
  }

  Future<List<DBModelExpenseByCategory>> readTotalExpenseByCategory(
      {required DateRange dateRange, bool lowToHigh = false}) async {
    String? startDate = dateRange.startDateISO8601;
    String? endDate = dateRange.endDateISO8601;

    List<Map<String, dynamic>> result = await db.database.rawQuery('''
    SELECT category_id, SUM(amount) as total
    FROM $tableName
    WHERE datetime >= ? AND datetime <= ?
    GROUP BY category_id
  ''', [startDate, endDate]);

    // Convert each item to a mutable map
    List<Map<String, dynamic>> mutableResult =
        result.map((item) => Map<String, dynamic>.from(item)).toList();
    mutableResult.sort((a, b) {
      if (lowToHigh) {
        return a['total'].compareTo(b['total']);
      }
      return b['total'].compareTo(a['total']);
    });
    List<DBModelExpenseByCategory> finalData = [];

    for (var _ in mutableResult) {
      final category =
          await DBHelperExpenseCategory().readById(id: _['category_id']);
      finalData
          .add(DBModelExpenseByCategory(category: category, total: _['total']));
    }
    return finalData;
  }
}
