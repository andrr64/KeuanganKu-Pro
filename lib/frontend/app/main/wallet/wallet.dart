import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/model/expense_limiter.dart';
import 'package:keuanganku/frontend/app/main/page_padding.dart';
import 'package:keuanganku/frontend/app/providers/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/providers/expense_limiter.dart';
import 'package:keuanganku/frontend/app/providers/wallet_provider.dart';
import 'package:keuanganku/frontend/colors/font_color.dart';
import 'package:keuanganku/frontend/components/cards/expense_limiter_card.dart';
import 'package:keuanganku/frontend/components/spacer/v_space.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';

INITDATA_WalletPage(BuildContext context, WidgetRef ref) async {}

class WalletPage extends HookConsumerWidget {
  const WalletPage({super.key});

  void callbackWhenDataSaved(
      WidgetRef ref, DBModelExpenseLimiter newExpenseLimiter) {
    ref
        .read(globalExpenseLimiterNotifierProvider.notifier)
        .add(newExpenseLimiter);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletsProvider = ref.watch(globalWalletsProvider);
    final expenseCategoryProvider = ref.watch(globalExpenseCategoriesProvider);
    final expenseLimiterProvider =
        ref.watch(globalExpenseLimiterNotifierProvider);

    return SingleChildScrollView(
      child: PagePadding(
        context,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            vspace_25,
            vspace_10,
              const Text(
                'Wallets',
                style: TextStyle(
                    color: fontColor_black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
            dummyHeight(10),
            ExpenseLimiterCard(
              callbackWhenNewLimiterSaved: (newExpenseLimiter) {
                callbackWhenDataSaved(ref, newExpenseLimiter);
              },
              limiter_data: expenseLimiterProvider,
              expenseCategories: expenseCategoryProvider,
              wallets: walletsProvider,
            ),
          ],
        ),
      ),
    );
  }
}
