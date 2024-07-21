abstract class DBModel {
  Map<String, dynamic> toJson();
  dynamic fromJson(Map<String, dynamic> json);
}