import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/backend/database/helper/wallet.dart';
import 'package:keuanganku/backend/database/model/model.dart';

class DBModelIncome extends DBModel {
  int? id;
  String? title;
  double? amount;
  String? description;
  int? wallet_id;
  int? category_id;
  String? datetime;

  DBModelIncome({
    this.id,
    this.title,
    this.amount,
    this.description,
    this.wallet_id,
    this.category_id,
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
      datetime: json['datetime'],
    );
  }

  Future<void> insert() async {
    int id = await DBHelperIncome().insert(data: this);
    id = id;
  }

  Future<void> insertAndUpdateWalletIncome() async {
    await insert();
    await DBHelperWallet().addIncome(walletId: wallet_id!, income: amount!);
  }
}

extension ModelIncomeUtility on DBModelIncome {
  double sum(List<DBModelIncome> list) {
    return list.fold(0.0, (previousValue, element) => previousValue + (element.amount ?? 0));
  }
}