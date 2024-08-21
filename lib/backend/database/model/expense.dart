import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/helper/wallet.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/model.dart';

/// The [DBModelExpense] class represents an expense entry to be stored in the
/// application's database. This class extends the [DBModel] class.
class DBModelExpense extends DBModel {
  /// The unique ID of the expense (optional).
  int? id;

  /// The title or short description of the expense.
  String? title;

  /// The amount of money spent.
  double? amount;

  /// Additional description of the expense.
  String? description;

  /// The ID of the wallet associated with this expense.
  int? wallet_id;

  /// The ID of the expense category (optional).
  int? category_id;

  /// The exchange rate (if applicable, optional).
  int? rate;

  /// The date and time of the expense in string format.
  String? datetime;

  /// Creates a new instance of [DBModelExpense].
  ///
  /// Parameters:
  /// - [id]: The unique ID of the expense.
  /// - [title]: The title or short description of the expense.
  /// - [amount]: The amount of money spent.
  /// - [description]: Additional description of the expense.
  /// - [wallet_id]: The ID of the wallet associated with this expense.
  /// - [category_id]: The ID of the expense category.
  /// - [rate]: The exchange rate (if applicable).
  /// - [datetime]: The date and time of the expense in string format.
  DBModelExpense({
    this.id,
    this.title,
    this.amount,
    this.description,
    this.wallet_id,
    this.category_id,
    this.rate,
    this.datetime
  });

  /// Converts the [DBModelExpense] instance into a [Map<String, dynamic>] format
  /// for storing in the database.
  ///
  /// Returns:
  /// - A map representing the expense data.
  @override
  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'description': description,
      'wallet_id': wallet_id,
      'category_id': category_id,
      'rate': rate,
      'datetime': datetime,
    };
  }

  /// Creates a [DBModelExpense] instance from a JSON object.
  ///
  /// Parameters:
  /// - [json]: A [Map<String, dynamic>] containing the expense data.
  ///
  /// Returns:
  /// - A [DBModelExpense] instance with the populated data.
  @override
  DBModelExpense fromJson(Map<String, dynamic> json) {
    return DBModelExpense(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      description: json['description'],
      wallet_id: json['wallet_id'],
      category_id: json['category_id'],
      rate: json['rate'],
      datetime: json['datetime'],
    );
  }

  /// Calculates the total sum of expenses in a list.
  ///
  /// Parameters:
  /// - [list]: A list of [DBModelExpense] instances.
  ///
  /// Returns:
  /// - The total sum of the amounts in the list.
  double sum(List<DBModelExpense> list) {
    return list.fold(0.0, (previousValue, element) => previousValue + (element.amount ?? 0));
  }

  /// Inserts the expense into the database and updates the wallet's total
  /// expenses.
  ///
  /// This function will insert the expense and update the `wallet.total_expense`.
  ///
  /// Returns:
  /// - A [Future<void>] indicating the completion of the operation.
  Future<void> insert() async{
    final newId = await DBHelperExpense().insert(data: this);
    await DBHelperWallet().addExpense(walletId: wallet_id!, expense: amount!);
    id = newId;
  }
}




/// The [DBModelExpenseByCategory] class groups expenses by category.
///
/// This class is used to represent the total amount of expenses within a specific category.
class DBModelExpenseByCategory {
  /// The expense category.
  DBModelExpenseCategory category;

  /// The total amount of expenses in this category.
  double total;

  /// Creates a new instance of [DBModelExpenseByCategory].
  ///
  /// Parameters:
  /// - [category]: The expense category.
  /// - [total]: The total amount of expenses in this category.
  DBModelExpenseByCategory({
    required this.category,
    required this.total,
  });
}




/// The [DBModelExpenseByTime] class groups expenses by a specific time range.
///
/// This class is used to represent the expenses and their total within a specified date range.
class DBModelExpenseByTime {
  /// The date range in which the expenses occurred.
  DateTimeRange dateTimeRange;

  /// The list of expenses within the specified date range.
  List<DBModelExpense> expenses;

  /// The total amount of expenses within the date range.
  late double total;

  /// Creates a new instance of [DBModelExpenseByTime].
  ///
  /// Parameters:
  /// - [dateTimeRange]: The date range in which the expenses occurred.
  /// - [expenses]: The list of expenses within the specified date range.
  ///
  /// The total is automatically calculated by summing the amounts of the expenses in the list.
  DBModelExpenseByTime({
    required this.dateTimeRange,
    required this.expenses
  }) {
    total = expenses.map((val) => val.amount!).toList().fold(0, (sum, i) => sum + i);
  }
}