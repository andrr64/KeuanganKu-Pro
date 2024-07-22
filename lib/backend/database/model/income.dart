import 'package:keuanganku/backend/database/model/model.dart';

class DBModelIncome extends DBModel {
  final int? id;
  final String? title;
  final double? amount;
  final String? description;
  final int? wallet_id;
  final int? category_id;
  final int? rate;
  final String? datetime;

  DBModelIncome({
    this.id,
    this.title,
    this.amount,
    this.description,
    this.wallet_id,
    this.category_id,
    this.rate,
    this.datetime
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

  @override
  DBModelIncome fromJson(Map<String, dynamic> json) {
    return DBModelIncome(
      id: json['id'],
      title: json['title'],
      amount: json['amount'],
      wallet_id: json['wallet_id'],
      category_id: json['category_id'],
      rate: json['rate'],
      datetime: json['datetime'],
    );
  }
}