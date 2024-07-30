import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/helper/wallet.dart';
import 'package:keuanganku/backend/database/model/model.dart';

class DBModelExpense extends DBModel {
  int? id;
  String? title;
  double? amount;
  String? description;
  int? wallet_id;
  int? category_id;
  int? rate;
  String? datetime;

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

  double sum(List<DBModelExpense> list) {
    return list.fold(0.0, (previousValue, element) => previousValue + (element.amount ?? 0));
  }

  /// This function will insert expense and update wallet.total_expense
  Future<void> insert() async{
    final newId = await DBHelperExpense().insert(data: this);
    await DBHelperWallet().addExpense(walletId: wallet_id!, expense: amount!);
    id = newId;
  }
}