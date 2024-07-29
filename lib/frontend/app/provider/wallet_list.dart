import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/helper/wallet.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:sqflite/sqflite.dart';

final globalWalletListProvider = NotifierProvider<WalletListController, List<DBModelWallet>>(WalletListController.new);

class WalletListController extends Notifier<List<DBModelWallet>>{
  //TODO: setiap kali wallet bertambah, perbaharui amount = total_incomes - total_expense
  bool _loading = false;
  bool init = false;
  double amount = 0;
  
  @override
  List<DBModelWallet> build() {
    return [];
  }

  void initData(Database db) async => read(db);

  void read(Database db) async{
    _loading = true;
    state = await DBHelperWallet().readAll(db: db);
    _loading = false;
  }

  bool get isLoading => _loading;

  void add(DBModelWallet wallet) {
    state = [...state, wallet];
  }

  void addIncome({required DBModelWallet target, required DBModelIncome income}) {
    state = state.map((wallet) {
      if (wallet.id == target.id) {
        return wallet.copyFrom(
          wallet,
          income: wallet.total_income! + income.amount!,
        );
      }
      return wallet;
    }).toList();
  }

  double get totalIncome {
    return state.fold(0.0, (sum, wallet) => sum + (wallet.total_income ?? 0.0));
  }

  void edit(DBModelWallet target){
    state = [
      for(final wallet in state)
        if (wallet.id == target.id)
          target
        else
          wallet,
    ];
  }

  void remove(DBModelWallet target){
    state = state.where((wallet) => wallet.id != target.id).toList();
  }
}