import 'package:keuanganku/backend/database/helper/expense_category.dart';
import 'package:keuanganku/backend/database/model/model.dart';

class DBModelExpenseCategory extends DBModel {
  String? name;
  int? id;

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

  Future insert() async {
    final newId = await DBHelperExpenseCategory().insert(data: this);
    id = newId;
  }
}