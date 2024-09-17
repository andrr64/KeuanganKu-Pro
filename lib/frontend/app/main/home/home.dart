import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/frontend/app/main/home/widgets/greeting.dart';
import 'package:keuanganku/frontend/app/main/home/widgets/total_balance.dart';
import 'package:keuanganku/frontend/app/providers/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/home/home_provider.dart';
import 'package:keuanganku/frontend/app/providers/income_category_provider.dart';
import 'package:keuanganku/frontend/app/main/page_padding.dart';
import 'package:keuanganku/frontend/app/providers/userdata_provider.dart';
import 'package:keuanganku/frontend/app/providers/wallet_provider.dart';
import 'package:keuanganku/frontend/components/cards/balance_card.dart';
import 'package:keuanganku/frontend/components/cards/expense_card.dart';
import 'package:keuanganku/frontend/components/cards/income_card.dart';
import 'package:keuanganku/enum/time_period.dart';
import 'package:keuanganku/frontend/components/spacer/v_space.dart';

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // Dark text for status bar
    ));

    return SingleChildScrollView(
        child: PagePadding(context, child: buildContent(context, ref)));
  }

  Widget buildContent(BuildContext context, WidgetRef ref) {
    var walletsProviderNotifier = ref.read(globalWalletsProvider.notifier);
    final userdata = ref.watch(globalUserdataProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        vspace_25,
        vspace_10,
        Greeting(userName: userdata.name!),
        vspace_25,
        TotalBalance(totalBalance: walletsProviderNotifier.totalBalance),
        vspace_25,
        const BalanceCard(),
        vspace_12_5,
        buildIncomeCard(context, ref),
        vspace_12_5,
        buildExpenseCard(context, ref),
      ],
    );
  }

  void callbackWhenIncomeCardTimePeriodChanged(TimePeriod val, WidgetRef ref) {
    ref.read(homepageProvider.notifier).setIncomeCardDateRange(val);
  }

  void callbackWhenExpenseCardTimePeriodChanged(TimePeriod? val, WidgetRef ref) {
    ref.read(homepageProvider.notifier).setExpenseCardDateRange(val!);
  }

  Widget buildIncomeCard(BuildContext context, WidgetRef ref) {
    return IncomeCard(
      dateRange: ref.watch(homepageProvider).incomeCardTimePeriod,
      incomesAmount: ref.watch(homepageProvider).incomeAmount,
      callbackWhenDateChange: (val) =>
          callbackWhenIncomeCardTimePeriodChanged(val, ref),
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

  Widget buildExpenseCard(BuildContext context, WidgetRef ref) {
    void callbackWhenSubmitNewExpense(DBModelExpense expense) {
      ref
          .read(globalWalletsProvider.notifier)
          .addExpense(walletTargetId: expense.wallet_id!, newExpense: expense);
      ref.read(homepageProvider.notifier).updateExpense();
    }

    void callbackWhenSubmitNewExpenseCategory(DBModelExpenseCategory category) {
      ref.read(globalExpenseCategoriesProvider.notifier).add(category);
    }

    return ExpenseCard(
        dateRange: ref.watch(homepageProvider).expenseCardTimePeriod,
        expenseAmount: ref.watch(homepageProvider).expenseAmount,
        wallets: ref.watch(globalWalletsProvider),
        expenseCategories: ref.watch(globalExpenseCategoriesProvider),
        callbackWhenDateChange: (val) =>
            callbackWhenExpenseCardTimePeriodChanged(val, ref),
        callbackWhenSubmitNewExpense: callbackWhenSubmitNewExpense,
        callbackWhenSubmitNewExpenseCategory:
            callbackWhenSubmitNewExpenseCategory);
  }
}
