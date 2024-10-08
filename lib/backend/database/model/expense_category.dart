import 'package:keuanganku/backend/database/helper/expense_category.dart';
import 'package:keuanganku/backend/database/model/model.dart';

/// The [DBModelExpenseCategory] class represents an expense category in the
/// application's database. This class extends the [DBModel] class.
class DBModelExpenseCategory extends DBModel {
  /// The name of the expense category.
  String? name;

  /// The unique ID of the expense category (optional).
  int? id;

  /// Creates a new instance of [DBModelExpenseCategory].
  ///
  /// Parameters:
  /// - [name]: The name of the expense category.
  /// - [id]: The unique ID of the expense category.
  DBModelExpenseCategory({this.name, this.id});

  /// Converts the [DBModelExpenseCategory] instance into a [Map<String, dynamic>] format
  /// for storing in the database.
  ///
  /// Returns:
  /// - A map representing the expense category data.
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }

  /// Creates a [DBModelExpenseCategory] instance from a JSON object.
  ///
  /// Parameters:
  /// - [json]: A [Map<String, dynamic>] containing the expense category data.
  ///
  /// Returns:
  /// - A [DBModelExpenseCategory] instance with the populated data.
  @override
  DBModelExpenseCategory fromJson(Map<String, dynamic> json) {
    return DBModelExpenseCategory(
      id: json['id'],
      name: json['name'],
    );
  }

  /// Inserts the expense category into the database.
  ///
  /// This function will insert the expense category into the database and set
  /// the `id` property with the new ID generated by the database.
  ///
  /// Returns:
  /// - A [Future<void>] indicating the completion of the operation.
  Future<void> insert() async {
    try {
      final newId = await DBHelperExpenseCategory().insert(data: this);
      id = newId;
    } catch (e){
      throw Exception('backend.database.model.expense_category.insert');
    }
  }
}
