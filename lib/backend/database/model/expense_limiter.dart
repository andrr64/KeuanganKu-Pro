import 'package:flutter/foundation.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/model.dart';
import 'package:keuanganku/enum/date_range.dart';

class DBModelExpenseLimiter extends DBModel {
  int id;
  int wallet_id;
  double limit_amount;
  int period_id;
  double current_amount;
  DBModelExpenseCategory? category;

  DBModelExpenseLimiter({
    this.id = 0,
    this.limit_amount = 0,
    this.period_id = 0,
    this.current_amount = 0,
    this.wallet_id = 0,
    this.category
  });

  DateRange get period {
    switch (period_id) {
      case 1:
        return DateRange.week;
      case 2:
        return DateRange.month;
      case 3:
        return DateRange.year;
    }
    throw ErrorDescription('period_id is invalid: $period_id');
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return DBModelExpenseLimiter(
      id: json['id'],
      wallet_id: json['wallet_id'],
      limit_amount: json['limit_amount'],
      period_id: json['period_id'],
      category: json['category']
    );
  }
  
  Future<void> updateCurrentAmount() async {
    var expenses_amount = [];
    if (wallet_id == 0){
      String where = 'datetime >= ? AND datetime <= ? AND category_id = ?'; 
      expenses_amount = await DBHelperExpense().readWithWhereClause(
        where: where, whereArgs: [period.startDateISO8601, period.endDateISO8601, category!.id]);
    } else {
      String where = 'datetime >= ? AND datetime <= ? AND category_id = ? AND wallet_id = ?'; 
      List whereArgs = [period.startDateISO8601, period.endDateISO8601, category!.id, wallet_id];
      expenses_amount = await DBHelperExpense().readWithWhereClause(
          where: where, 
          whereArgs: whereArgs
      );
    }
    current_amount = expenses_amount.fold(0.0, (sum, e) => sum + e.amount!);
  }

  void addCurrentAmount(double amount) => current_amount += amount;

  Future<bool> updateData(){
    //TODO: model.expenseLimiter.updateData
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'category_id': category == null? -1 : category!.id,
      'wallet_id': wallet_id,
      'limit_amount': limit_amount,
      'period_id': period_id,
    };
  }
}