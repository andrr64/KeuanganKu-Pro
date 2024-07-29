import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/helper/wallet.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/main.dart';

final globalWalletsProvider = NotifierProvider<WalletListProvider, List<DBModelWallet>>(WalletListProvider.new);

class WalletListProvider extends Notifier<List<DBModelWallet>>{
  bool init = false;

  @override
  List<DBModelWallet> build() {
    return [];
  }

  void initData(){
    if (!init){
      updateFromDatabase();
    }
  }

  void updateFromDatabase() async{
    state = await DBHelperWallet().readAll(db: db.database);
  }

  void add(DBModelWallet wallet){
    state = [...state, wallet];
  }

  void addToDatabase(DBModelWallet wallet) async {
    wallet.insert();
    add(wallet);
  }

  void addIncome({required int walletTargetId, required DBModelIncome newIncome}) {
    state = state.map((wallet) {
      if (wallet.id == walletTargetId) {
        wallet.total_income = wallet.total_income! + newIncome.amount!;
      }
      return wallet;
    }).toList();
  }

  double get totalIncome {
    return state.fold(0.0, (sum, wallet) => sum + (wallet.total_income ?? 0.0));
  }

  void remove(DBModelWallet target){
    state = state.where((wallet) => wallet.id != target.id).toList();
  }
}