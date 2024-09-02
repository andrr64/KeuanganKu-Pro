import 'package:keuanganku/backend/database/helper/helper.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/utility/table_column_generator.dart';
import 'package:keuanganku/main.dart';

class DBHelperExpenseCategory extends DBHelper<DBModelExpenseCategory> {
  @override
  String get tableName => 'expense_categories';

  @override
  List<Map<String, String>> get tableColumns {
    return [
      createSql3Column(name: 'id', dtype: 'INTEGER', primary: true, constraint: 'AUTOINCREMENT' ),
      createSql3Column(name: 'name', dtype: 'TEXT', required: true)
    ];
  }

  @override
  List<DBModelExpenseCategory> get initData => [
    DBModelExpenseCategory(name: 'Food'),
    DBModelExpenseCategory(name: 'Transportation'),
    DBModelExpenseCategory(name: 'Household'),
    DBModelExpenseCategory(name: 'Health'),
    DBModelExpenseCategory(name: 'Shopping'),
    DBModelExpenseCategory(name: 'Debt Payments')
  ];

  @override
  Future<bool> delete({required DBModelExpenseCategory data}) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<DBModelExpenseCategory>> readAll() async {
    List<Map<String, dynamic>> data = await db.database.query(tableName);
    return List.generate(data.length, (index) => DBModelExpenseCategory().fromJson(data[index]));
  }

  @override
  Future<DBModelExpenseCategory> readById({required int id}) async {
    // Menjalankan query untuk mengambil satu baris berdasarkan id
    final List<Map<String, dynamic>> result = await db.database.query(
      tableName,
      where: 'id = ?', // Filter berdasarkan id
      whereArgs: [id], // Nilai dari id yang akan dicari
      limit: 1, // Hanya mengambil satu baris
    );

    // Jika tidak ada data yang ditemukan, lempar exception atau kembalikan nilai null
    if (result.isEmpty) {
      throw Exception('No data found for id $id');
    }

    // Mengembalikan instance DBModelExpenseCategory dari hasil query
    return DBModelExpenseCategory().fromJson(result.first);
  }


  @override
  Future<bool> update({required DBModelExpenseCategory data}) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<int> insert({required DBModelExpenseCategory data}) async{
    final newId = await db.database.insert(tableName, data.toJson());
    return newId;
  }
}
