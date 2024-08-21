import 'package:keuanganku/backend/database/model/model.dart';

/// The [DBModelIncomeCategory] class represents a category of income that can
/// be stored in the application's database. This class extends the [DBModel] class.
class DBModelIncomeCategory extends DBModel {
  /// The unique ID of the income category (optional).
  final int? id;

  /// The name or title of the income category.
  final String? name;

  /// Creates a new instance of [DBModelIncomeCategory].
  ///
  /// Parameters:
  /// - [id]: The unique ID of the income category.
  /// - [name]: The name or title of the income category.
  DBModelIncomeCategory({this.name, this.id});

  /// Converts the [DBModelIncomeCategory] instance into a [Map<String, dynamic>] format
  /// for storing in the database.
  ///
  /// Returns:
  /// - A map representing the income category data.
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name
    };
  }

  /// Creates a [DBModelIncomeCategory] instance from a JSON object.
  ///
  /// Parameters:
  /// - [json]: A [Map<String, dynamic>] containing the income category data.
  ///
  /// Returns:
  /// - A [DBModelIncomeCategory] instance with the populated data.
  @override
  DBModelIncomeCategory fromJson(Map<String, dynamic> json) {
    return DBModelIncomeCategory(
        id: json['id'],
        name: json['name']
    );
  }
}
