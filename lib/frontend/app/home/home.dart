import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/home/home_provider.dart';
import 'package:keuanganku/frontend/app/income_category_provider.dart';
import 'package:keuanganku/frontend/app/wallet_provider.dart';
import 'package:keuanganku/frontend/components/cards/balance_card.dart';
import 'package:keuanganku/frontend/components/cards/income_card.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void callbackWhenIncomeCardDateChange(DateRange val) {
      ref.read(homepageProvider.notifier).setIncomeCardDateRange(val);
    }
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: vh(context, 2.5),
          horizontal: vw(context, 5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dummyHeight(10),
            const BalanceCard(),
            dummyHeight(25),
            IncomeCard(
              dateRange: ref.watch(homepageProvider).incomesDateRange,
              incomesAmount: ref.watch(homepageProvider).incomesAmount,
              callbackWhenDateChange: callbackWhenIncomeCardDateChange,
              wallets: ref.watch(globalWalletsProvider),
              incomeCategories: ref.watch(globalIncomeCategoriesProvider),
              callbackWhenNewIncomeSaved: (newIncome){
                ref.read(homepageProvider.notifier).updateIncomes();
                ref.read(globalWalletsProvider.notifier).addIncome(walletTargetId: newIncome.wallet_id!, newIncome: newIncome);
              },
            ),
          ],
        ),
      ),
    );
  }
}