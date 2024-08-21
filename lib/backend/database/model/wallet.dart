import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/backend/database/helper/wallet.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

/**
 * Enum representing different types of wallets or accounts.
 */
enum WalletType {
  /**
   * Represents a general wallet.
   */
  wallet('Wallet', 1),

  /**
   * Represents a bank account.
   */
  bank('Bank Account', 2);

  const WalletType(this.name, this.type);
  final String name;
  final int type;
}

/**
 * Extension methods for `WalletType` enum.
 */
extension Get on WalletType {
  /**
   * Returns the string representation of a wallet type given its integer value.
   *
   * @param type The integer representing the wallet type.
   * @return A `String` representing the wallet type name.
   */
  String type_str(int type) {
    for (var walletType in WalletType.values) {
      if (walletType.type == type) {
        return walletType.name;
      }
    }
    return 'Unknown';
  }

  /**
   * Returns a list of wallet type names as strings.
   *
   * @return A `List<String>` containing the names of all wallet types.
   */
  List<String> walletTypeValueAsString() {
    return List<String>.generate(WalletType.values.length, (i) => type_str(WalletType.values[i].type));
  }
}

/// The [DBModelWallet] class represents a wallet or bank account entry to be
/// stored in the application's database. This class extends the [DBModel] class.
class DBModelWallet extends DBModel {
  /// The unique ID of the wallet (optional).
  int? id;

  /// The name or title of the wallet.
  String? name;

  /// The type of the wallet, indicating whether it's a physical wallet or a
  /// bank account.
  int? type;

  /// The total amount of income associated with the wallet.
  double? total_income;

  /// The total amount of expense associated with the wallet.
  double? total_expense;

  /// Creates a new instance of [DBModelWallet].
  ///
  /// Parameters:
  /// - [id]: The unique ID of the wallet.
  /// - [name]: The name or title of the wallet.
  /// - [type]: The type of the wallet.
  /// - [total_income]: The total amount of income associated with the wallet.
  /// - [total_expense]: The total amount of expense associated with the wallet.
  DBModelWallet({
    this.id,
    this.name,
    this.type,
    this.total_income = 0,
    this.total_expense = 0
  });

  /// Converts the [DBModelWallet] instance into a [Map<String, dynamic>] format
  /// for storing in the database.
  ///
  /// Returns:
  /// - A map representing the wallet data.
  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'total_income': total_income,
    'total_expense': total_expense
  };

  /// Creates a [DBModelWallet] instance from a JSON object.
  ///
  /// Parameters:
  /// - [json]: A [Map<String, dynamic>] containing the wallet data.
  ///
  /// Returns:
  /// - A [DBModelWallet] instance with the populated data.
  @override
  DBModelWallet fromJson(Map<String, dynamic> json) {
    return DBModelWallet(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      total_income: json['total_income'],
      total_expense: json['total_expense'],
    );
  }

  /// Retrieves a list of incomes associated with the wallet.
  ///
  /// Parameters:
  /// - [db]: The [Database] instance to use for querying.
  /// - [startDate]: The start date for filtering incomes (optional).
  /// - [endDate]: The end date for filtering incomes (optional).
  ///
  /// Returns:
  /// - A [Future<List<DBModelIncome>>] containing the list of incomes.
  Future<List<DBModelIncome>> getIncomes({
    required Database db,
    String? startDate,
    String? endDate
  }) async {
    if (id != null) {
      return await DBHelperIncome().readByWalletId(db: db, wallet_id: id!);
    }
    throw ('Invalid Wallet');
  }

  /// Retrieves a string representation of the wallet type.
  ///
  /// Returns:
  /// - A string representing the wallet type.
  String get typeString {
    if (type == null) {
      return 'null';
    }
    return WalletType.wallet.type_str(type!);
  }

  /// Retrieves the icon associated with the wallet type.
  ///
  /// Returns:
  /// - An [IconData] representing the icon for the wallet.
  IconData get icon {
    if (type == WalletType.wallet.type) {
      return Icons.wallet;
    }
    return Icons.account_balance_sharp;
  }

  /// Inserts the wallet into the database and updates the wallet's ID.
  ///
  /// This function will insert the wallet and set its ID upon completion.
  ///
  /// Returns:
  /// - A [Future<void>] indicating the completion of the operation.
  Future<void> insert() async {
    int newId = await DBHelperWallet().insert(data: this);
    id = newId;
  }

  /// Retrieves a list of expenses associated with the wallet.
  ///
  /// Parameters:
  /// - [db]: The [Database] instance to use for querying.
  /// - [startDate]: The start date for filtering expenses (optional).
  /// - [endDate]: The end date for filtering expenses (optional).
  ///
  /// Returns:
  /// - A [Future<List<DBModelExpense>>] containing the list of expenses.
  Future<List<DBModelExpense>> readExpenses({
    required Database db,
    String? startDate,
    String? endDate
  }) async {
    if (id != null) {
      return await DBHelperExpense().readByWalletId(db: db, wallet_id: id!);
    }
    throw ('Invalid Wallet');
  }
}
