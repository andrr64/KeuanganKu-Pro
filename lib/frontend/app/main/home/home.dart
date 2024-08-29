import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/providers/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/home/home_provider.dart';
import 'package:keuanganku/frontend/app/providers/income_category_provider.dart';
import 'package:keuanganku/frontend/app/main/page_padding.dart';
import 'package:keuanganku/frontend/app/providers/wallet_provider.dart';
import 'package:keuanganku/frontend/components/cards/balance_card.dart';
import 'package:keuanganku/frontend/components/cards/expense_card.dart';
import 'package:keuanganku/frontend/components/cards/income_card.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
bool _initPage = false;
late WidgetRef _ref;

Future<void> REFRESH_HomePage() async {
  if (_initPage){
    await _ref.watch(homepageProvider.notifier).initData();
  }
}
void INITDATA_HomePage(BuildContext context, WidgetRef ref) async {
  if (!_initPage){
    _ref = ref;
    await _ref.watch(homepageProvider.notifier).initData();
    _initPage = true;
  }
}

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
        child: PagePadding(
      context,
      child: buildContent(context, ref)));
  }

  Widget buildContent(BuildContext context, WidgetRef ref){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dummyHeight(10),
        const BalanceCard(),
        dummyHeight(25),
        _buildIncomeCard(context, ref),
        dummyHeight(25),
        _buildExpenseCard(context, ref),
      ],
    );
  }

  void callbackWhenIncomeCardDateChange(DateRange val, WidgetRef ref) {
    ref.read(homepageProvider.notifier).setIncomeCardDateRange(val);
  }

  void callbackWhenExpenseCardDateChange(DateRange? val, WidgetRef ref) {
    ref.read(homepageProvider.notifier).setExpenseCardDateRange(val!);
  }

  Widget _buildIncomeCard(BuildContext context, WidgetRef ref) {
    return IncomeCard(
      dateRange: ref.watch(homepageProvider).incomesDateRange,
      incomesAmount: ref.watch(homepageProvider).incomesAmount,
      callbackWhenDateChange: (val) =>
          callbackWhenIncomeCardDateChange(val, ref),
      wallets: ref.watch(globalWalletsProvider),
      incomeCategories: ref.watch(globalIncomeCategoriesProvider),
      callbackWhenNewIncomeSaved: (newIncome) async {
        ref.read(globalWalletsProvider.notifier).addIncome(
              walletTargetId: newIncome.wallet_id!,
              newIncome: newIncome,
            );
        await ref.read(homepageProvider.notifier).updateIncomes();
      },
    );
  }

  Widget _buildExpenseCard(BuildContext context, WidgetRef ref) {
    return ExpenseCard(
      dateRange: ref.watch(homepageProvider).expenseDateRange,
      expenseAmount: ref.watch(homepageProvider).expenseAmount,
      wallets: ref.watch(globalWalletsProvider),
      expenseCategories: ref.watch(globalExpenseCategoriesProvider),
      callbackWhenDataChange: (val) =>
          callbackWhenExpenseCardDateChange(val, ref),
      callbackWhenNewExpenseSaved: (newExpense) async {
        ref.read(globalWalletsProvider.notifier).addExpense(
            walletTargetId: newExpense.wallet_id!, newExpense: newExpense);
        await ref.read(homepageProvider.notifier).updateExpense();
      },
    );
  }
}
