import 'package:keuanganku/backend/database/model/model.dart';

enum WalletType {
  wallet('Wallet', 1),
  bank('Bank', 2);

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
}

class DBModelWallet extends DBModel {
  int id;
  String name;
  int type;

  DBModelWallet({
    required this.id,
    required this.name,
    required this.type
  });

  String get type_str => WalletType.wallet.type_str(type);

  @override
  Map<String, dynamic> toJson() => {
    'id' : id,
    'name': name,
    'type': type
  };
}