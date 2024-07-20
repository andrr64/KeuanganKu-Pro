import 'package:keuanganku/backend/database/model/model.dart';

class DBModelExpenseCategory extends DBModel {
  String name;
  int? id;

  DBModelExpenseCategory({required this.name, this.id});

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }
}