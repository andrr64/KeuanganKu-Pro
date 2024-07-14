import 'package:keuanganku/backend/database/model/model.dart';

class DBModelExpense extends DBModel {
  int id;
  String title;
  double amount;
  String? description;
  int wallet_id;
  int category_id;
  int rate;
  String datetime;

  DBModelExpense({
    required this.id,
    required this.title,
    required this.amount,
    this.description,
    required this.wallet_id,
    required this.category_id,
    required this.rate,
    required this.datetime
  });

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
}