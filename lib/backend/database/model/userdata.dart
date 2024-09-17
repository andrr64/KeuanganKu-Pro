import 'package:keuanganku/backend/database/model/model.dart';

class DBModelUserdata extends DBModel {
  String? name;
  String? locale;

  DBModelUserdata({this.name, this.locale});
  bool get invalid => name == null || locale == null;

  @override
  fromJson(Map<String, dynamic> json) {
    return DBModelUserdata(
      name: json['user'],
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