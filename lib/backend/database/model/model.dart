/// An abstract class that represents a database model.
/// 
/// This class provides methods to convert between the model and its JSON representation.
/// Subclasses should implement these methods to handle the specifics of their own data structures.
abstract class DBModel {
  /// Converts the model instance to a JSON map.
  /// 
  /// This method should be implemented by subclasses to return a map where the keys are
  /// the field names and the values are the corresponding data values.
  /// 
  /// Returns:
  /// - A `Map<String, dynamic>` representing the model in JSON format.
  Map<String, dynamic> toJson();

  /// Creates an instance of the model from a JSON map.
  /// 
  /// This method should be implemented by subclasses to parse the JSON map and initialize
  /// the model's fields with the values from the map.
  /// 
  /// Parameters:
  /// - `json`: A `Map<String, dynamic>` containing the JSON representation of the model.
  /// 
  /// Returns:
  /// - An instance of the model with its fields populated from the JSON map.
  dynamic fromJson(Map<String, dynamic> json);
}
