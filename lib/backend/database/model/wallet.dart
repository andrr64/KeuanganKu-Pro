import 'dart:math';

import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

enum WalletType {
  wallet('Wallet', 1),
  bank('Bank Account', 2);

  const WalletType(this.name, this.type);
  final String name;
  final int type;
}

extension Get on WalletType {
  String type_str(int type) {
    for (var walletType in WalletType.values) {
      if (walletType.type == type) {
        return walletType.name;
      }
    }
    return 'Unknown';
  }
  List<String> walletTypeValueAsString(){
    return List<String>.generate(WalletType.values.length, (i) => type_str(WalletType.values[i].type));
  }
}

class DBModelWallet extends DBModel {
  final int? id;
  final String? name;
  final int? type;
  final double? total_income;
  final double? total_expense;

  DBModelWallet({this.id, this.name, this.type, this.total_expense, this.total_income});
  
  @override
  Map<String, dynamic> toJson() => {
    'id' : id,
    'name': name,
    'type': type,
    'total_income': total_income,
    'total_expense': total_expense
  };

  @override
  DBModelWallet fromJson(Map<String, dynamic> json) {
    return DBModelWallet(id: json['id'], name: json['name'], type: json['type']);
  }

  Future<List<DBModelIncome>> getIncomes({required Database db, String? startDate, String? endDate}) async {
    if (id != null){
      return await DBHelperIncome().readByWalletId(db: db, wallet_id: id!);
    }
    throw ('Invalid Wallet');
  }

  String get type_str {
    if (type == null){
      return 'null';
    }
    return WalletType.wallet.type_str(type!);
  }

  IconData get icon{
    if (type == WalletType.wallet.type){
      return Icons.wallet;
    }
    return Icons.account_balance_sharp;
  }

  DBModelWallet copyFrom(DBModelWallet target, {int? id, String? name, int? type, double? income, double? expense}){
    return DBModelWallet(
      id: id?? target.id,
      name: name?? target.name,
      type: type?? target.type,
      total_income: income?? target.total_income,
      total_expense: expense?? target.total_expense
    );
  }

  Future<List<DBModelExpense>> readExpenses({required Database db, String? startDate, String? endDate}) async{
    if (id != null){
      return await DBHelperExpense().readByWalletId(db: db, wallet_id: id!);
    }
    throw ('Invalid Wallet');
  }
}