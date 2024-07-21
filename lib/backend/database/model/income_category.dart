import 'package:keuanganku/backend/database/model/model.dart';

class DBModelIncomeCategory extends DBModel {
  final String? name;
  final int? id;

  DBModelIncomeCategory({this.name, this.id});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }

  @override
  DBModelIncomeCategory fromJson(Map<String, dynamic> json) {
    return DBModelIncomeCategory(
      id: json['id'],
      name: json['name']
    );
  }
}