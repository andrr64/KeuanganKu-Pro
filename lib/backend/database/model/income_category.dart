import 'package:keuanganku/backend/database/model/model.dart';

class DBModelIncomeCategory extends DBModel {
  String name;
  int? id;

  DBModelIncomeCategory({required this.name, this.id});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}