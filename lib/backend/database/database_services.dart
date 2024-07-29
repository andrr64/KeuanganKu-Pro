import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/helper/expense_category.dart';
import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/backend/database/helper/income_category.dart';
import 'package:keuanganku/backend/database/helper/wallet.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  final String _dbName = 'keuanganku_pro.db';
  final int _dbVer = 0x100;
  Database? _database;

  createTable(Database db, int version){
    DBHelperWallet().checkIfNotExistThenCreate(db);

    DBHelperExpense().checkIfNotExistThenCreate(db);
    DBHelperExpenseCategory().checkIfNotExistThenCreate(db);

    DBHelperIncome().checkIfNotExistThenCreate(db);
    DBHelperIncomeCategory().checkIfNotExistThenCreate(db);
  }

  Future<void> openDb() async {
    try{
      final db_path = join(await getDatabasesPath(), _dbName);
      _database = await openDatabase(
        db_path,
        version: _dbVer,
        onCreate: createTable
      );
    } catch(e){
      throw Exception(e);
    }
  }

  Database get database => _database!;
}