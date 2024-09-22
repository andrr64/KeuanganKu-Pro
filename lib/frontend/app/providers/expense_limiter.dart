
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/database/helper/expense_limiter.dart';
import 'package:keuanganku/backend/database/model/expense_limiter.dart';

final globalExpenseLimiterNotifierProvider = NotifierProvider<ExpenseLimiterProvider, List<DBModelExpenseLimiter>>(ExpenseLimiterProvider.new);

class ExpenseLimiterProvider extends Notifier<List<DBModelExpenseLimiter>>{
  bool init = false;
  
  @override
  List<DBModelExpenseLimiter> build() => [];

  Future<void> initData() async {
    if (!init){
      state = await DBHelperExpenseLimiter().readAll(); 
      init = true;
    }
  }

  void add(DBModelExpenseLimiter limiter){
    state = [...state, limiter];
  }
}