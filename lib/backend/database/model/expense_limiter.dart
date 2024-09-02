import 'package:flutter/foundation.dart';
import 'package:keuanganku/backend/database/model/model.dart';
import 'package:keuanganku/enum/date_range.dart';

class DBModelExpenseLimiter extends DBModel {
  int id;
  int category_id;
  double limit_amount;
  int period_id;
  double current_amount;

  DBModelExpenseLimiter({
    this.id = 0,
    this.category_id = 0,
    this.limit_amount = 0,
    this.period_id = 0,
    this.current_amount = 0,
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
      category_id: json['category_id'],
      limit_amount: json['limit_amount'],
      period_id: json['period_id'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'category_id': category_id,
      'limit_amount': limit_amount,
      'period_id': period_id,
    };
  }
}