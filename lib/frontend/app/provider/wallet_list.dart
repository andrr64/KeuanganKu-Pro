import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/helper/wallet.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:sqflite/sqflite.dart';

final walletListProvider = NotifierProvider<WalletListController, List<DBModelWallet>>(WalletListController.new);

class WalletListController extends Notifier<List<DBModelWallet>>{
  bool _loading = false;
  bool init = false;

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