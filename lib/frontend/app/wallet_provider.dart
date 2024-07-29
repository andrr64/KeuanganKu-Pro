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
      read();
    }
  }

  void read() async{
    state = await DBHelperWallet().readAll(db: db.database);
  }

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