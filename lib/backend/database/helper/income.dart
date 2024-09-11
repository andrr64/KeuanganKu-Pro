import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/enum/time_period.dart';
import 'package:keuanganku/main.dart';

class DBHelperIncome extends DBHelper<DBModelIncome> {
  @override
  List<Map<String, String>> get tableColumns => [
        createSql3Column(
            name: 'id',
            dtype: 'INTEGER',
            constraint: 'PRIMARY KEY AUTOINCREMENT'),
        createSql3Column(name: 'title', dtype: 'TEXT', required: true),
        createSql3Column(name: 'amount', dtype: 'REAL', required: true),
        createSql3Column(name: 'description', dtype: 'TEXT'),
        createSql3Column(name: 'wallet_id', dtype: 'INTEGER', required: true),
        createSql3Column(name: 'category_id', dtype: 'INTEGER', required: true),
        createSql3Column(name: 'datetime', dtype: 'TEXT', required: true),
      ];

  @override
  String get tableName => 'incomes';

  @override
  List<DBModelIncome> get initData => [];

  @override
  Future<bool> delete({required DBModelIncome data}) async {
    throw UnimplementedError();
  }

  Future<double> readTotalIncome({TimePeriod? date}) async {
    List<DBModelIncome> data = await readAll(date: date);
    double result = data.fold(0, (sum, income) => sum + income.amount!);
    return result;
  }

  @override
  Future<List<DBModelIncome>> readAll({TimePeriod? date}) async {
    String? startDate = date?.startDateISO8601;
    String? endDate = date?.endDateISO8601;

    final whereClause = (startDate != null && endDate != null)
        ? 'datetime >= ? AND datetime <= ?'
        : null;
    final whereArgs =
        (startDate != null && endDate != null) ? [startDate, endDate] : null;

    final List<Map<String, dynamic>> data = await db.database.query(
      tableName,
      where: whereClause,
      whereArgs: whereArgs,
    );
    return data.map((item) => DBModelIncome().fromJson(item)).toList();
  }

  @override
  Future<DBModelIncome> readById({required int id}) async {
    // TODO: implement readById
    throw UnimplementedError();
  }

  Future<List<DBModelIncome>> readByWalletId({required int wallet_id}) async {
    return await db.database.query(tableName,
        where: 'wallet_id = ?', whereArgs: [wallet_id]).then((incomes) {
      return List<DBModelIncome>.generate(incomes.length, (index) {
        return DBModelIncome().fromJson(incomes[index]);
      });
    });
  }

  @override
  Future<bool> update({required DBModelIncome data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<int> insert({required DBModelIncome data}) async {
    return await db.database.insert(tableName, data.toJson());
  }
}
