import 'package:keuanganku/backend/database/model/model.dart';

class DBModelExpenseCategory extends DBModel {
  final String? name;
  final int? id;

  DBModelExpenseCategory({this.name, this.id});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }

  @override
  DBModelExpenseCategory fromJson(Map<String, dynamic> json) {
    return DBModelExpenseCategory(
        id: json['id'],
        name: json['name']
    );
  }
}