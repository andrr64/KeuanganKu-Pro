import 'package:keuanganku/backend/database/model/model.dart';

class DBModelUserdata extends DBModel {
  int? id;
  String? name;
  String? locale;

  DBModelUserdata({this.id, this.name, this.locale});
  bool get invalid => name == null || locale == null;

  @override
  fromJson(Map<String, dynamic> json) {
    return DBModelUserdata(
      id: json['id'],
      name: json['name'],
      locale: json['locale']
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'locale': locale
    };
  }
}