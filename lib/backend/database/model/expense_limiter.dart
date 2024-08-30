import 'package:flutter/foundation.dart';
import 'package:keuanganku/backend/database/model/model.dart';
import 'package:keuanganku/enum/date_range.dart';

class DBModelExpenseLimiter extends DBModel {
  int id;
  int category_id;
  double limit_amount;
  int period_id;

  DBModelExpenseLimiter({
    this.id = -1,
    this.category_id = -1,
    this.limit_amount = -1,
    this.period_id = -1,
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
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}