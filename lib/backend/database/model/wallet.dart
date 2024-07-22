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
  final int? id;
  final String? name;
  final int? type;

  DBModelWallet({
    this.id,
    this.name,
    this.type
  });

  String get type_str {
    if (type == null){
      return 'null';
    }
    return WalletType.wallet.type_str(type!);
  }

  @override
  Map<String, dynamic> toJson() => {
    'id' : id,
    'name': name,
    'type': type
  };

  @override
  DBModelWallet fromJson(Map<String, dynamic> json) {
    return DBModelWallet(id: json['id'], name: json['name'], type: json['type']);
  }
}