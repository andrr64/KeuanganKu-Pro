import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/frontend/app/providers/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/home/home_provider.dart';
import 'package:keuanganku/frontend/app/providers/income_category_provider.dart';
import 'package:keuanganku/frontend/app/main/page_padding.dart';
import 'package:keuanganku/frontend/app/providers/wallet_provider.dart';
import 'package:keuanganku/frontend/colors/font_color.dart';
import 'package:keuanganku/frontend/components/cards/balance_card.dart';
import 'package:keuanganku/frontend/components/cards/expense_card.dart';
import 'package:keuanganku/frontend/components/cards/income_card.dart';
import 'package:keuanganku/enum/time_period.dart';
import 'package:keuanganku/frontend/components/spacer/v_space.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';

bool _initPage = false;
late WidgetRef _ref;

Future<void> REFRESH_HomePage() async {
  if (_initPage) {
    await _ref.watch(homepageProvider.notifier).initData();
  }
}

void INITDATA_HomePage(BuildContext context, WidgetRef ref) async {
  if (!_initPage) {
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
        child: PagePadding(context, child: buildContent(context, ref)));
  }

  Widget buildContent(BuildContext context, WidgetRef ref) {
    var walletsProviderNotifier = ref.read(globalWalletsProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        vspace_25,
        vspace_10,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(),
            dummyWidth(22.5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hi, Andreas',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: fontColor_black),
                ),
                kText(context, 'Welcome back!', KTStyle.title, KTSType.small,
                    fontWeight: FontWeight.normal, color: fontColor_grey),
              ],
            ),
          ],
        ),
        vspace_25,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kText(context, 'Total Balance', KTStyle.title, KTSType.small,
                    fontWeight: FontWeight.w500, color: fontColor_grey),
                SizedBox(
                  width: vw(context, 70),
                  child: Text(
                    currencyFormat(walletsProviderNotifier.totalBalance),
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: fontColor_black),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            const CircleAvatar(
              backgroundColor: Colors.redAccent,
            )
          ],
        ),
        vspace_25,
        const BalanceCard(),
        vspace_12_5,
        buildIncomeCard(context, ref),
        vspace_12_5,
        buildExpenseCard(context, ref),
      ],
    );
  }

  void callbackWhenIncomeCardDateChange(TimePeriod val, WidgetRef ref) {
    ref.read(homepageProvider.notifier).setIncomeCardDateRange(val);
  }

  void callbackWhenExpenseCardDateChange(TimePeriod? val, WidgetRef ref) {
    ref.read(homepageProvider.notifier).setExpenseCardDateRange(val!);
  }

  Widget buildIncomeCard(BuildContext context, WidgetRef ref) {
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
        dateRange: ref.watch(homepageProvider).expenseDateRange,
        expenseAmount: ref.watch(homepageProvider).expenseAmount,
        wallets: ref.watch(globalWalletsProvider),
        expenseCategories: ref.watch(globalExpenseCategoriesProvider),
        callbackWhenDateChange: (val) =>
            callbackWhenExpenseCardDateChange(val, ref),
        callbackWhenSubmitNewExpense: callbackWhenSubmitNewExpense,
        callbackWhenSubmitNewExpenseCategory:
            callbackWhenSubmitNewExpenseCategory);
  }
}
