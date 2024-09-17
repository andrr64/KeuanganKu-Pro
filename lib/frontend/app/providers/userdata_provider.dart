import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/helper/userdata.dart';
import 'package:keuanganku/backend/database/model/userdata.dart';

final globalUserdataProvider = NotifierProvider<UserdataProvider, DBModelUserdata>(UserdataProvider.new);

class UserdataProvider extends Notifier<DBModelUserdata> {
  String name = 'Wait...';

  bool init = false;

  @override
  DBModelUserdata build() {
    return DBModelUserdata();
  }

  Future<void> initData() async {
    final data = await DBHelperUserdata().readUserdata();
    state = data;
  }

  Future<bool> updateData(DBModelUserdata userdata) async {
    bool updated = await DBHelperUserdata().update(data: userdata);
    if (updated){
      state = userdata;
    }
    return updated;
  }

  Future<bool> justUpdateData(DBModelUserdata userdata) async {
    bool updated = await DBHelperUserdata().update(data: userdata);
    return updated;
  }

  void setData(DBModelUserdata userdata){
    state = userdata;
  }
}