import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/expense_limiter.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/app/providers/wallet_provider.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/empty_data.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/math_operation.dart';

class ExpenseLimiterCard extends HookConsumerWidget {
  const ExpenseLimiterCard(
      {super.key,
      required this.limiter_data,
      required this.expenseCategories,
      required this.wallets,
      required this.callbackWhenNewLimiterSaved});
  final void Function(DBModelExpenseLimiter) callbackWhenNewLimiterSaved;
  final List<DBModelExpenseLimiter> limiter_data;
  final List<DBModelExpenseCategory> expenseCategories;
  final List<DBModelWallet> wallets;
  final bgColor = const Color(0xff222831);

  Color percentageToColor(double percentage) {
    assert(percentage >= 0 && percentage <= 1,
        'Persentase harus di antara 0 dan 1');

    int red =
        (percentage * 255).round(); // Nilai merah meningkat seiring persentase
    int green = ((1 - percentage) * 255)
        .round(); // Nilai hijau menurun seiring persentase

    return Color.fromARGB(255, red, green, 0);
  }

  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: const EdgeInsets.all(22.5),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Expense Limiter',
                      style: getTextStyle(
                          context, KTStyle.title, KTSType.large, Colors.white),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      child: Text(
                        'Excess is not good, limit your spending.',
                        style: getTextStyle(context, KTStyle.label,
                            KTSType.medium, Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            dummyHeight(10),
            ...buildLimiter(context, ref),
            dummyHeight(10),
            ///TODO: add button
            // k_button(context, () {
            //   openPage(
            //       context,
            //       ExpenseLimiterForm(
            //           expenseCategories: expenseCategories,
            //           wallets: wallets,
            //           callbackWhenDataSaved: callbackWhenNewLimiterSaved));
            // },
                // mainColor: Colors.white24,
                // withoutBg: true,
                // iconColor: Colors.white,
                // text: 'Add Limiter')
          ],
        ));
  }

  List<Widget> buildLimiter(BuildContext context, WidgetRef ref) {
    final walletNotifier = ref.read(globalWalletsProvider.notifier);
    if (limiter_data.isEmpty) {
      return [
        const EmptyData(
          iconColor: Colors.white,
        )
      ];
    }
    List<Widget> limiterWidget = [];
    for (var e in limiter_data) {
      final wallet = e.wallet_id == 0
          ? DBModelWallet(name: 'General')
          : walletNotifier.getById(e.wallet_id);
      if (e.category != null) {
        limiterWidget.add(buildLimiterInfoWidget(context,
            limiter: e, category: e.category!, wallet: wallet));
      }
    }
    return limiterWidget;
  }

  Widget buildBar(BuildContext context, double percentage) {
    final bar_width = MediaQuery.sizeOf(context).width * 0.75;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: bar_width,
          height: 5,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        ),
        Container(
          width: bar_width * percentage,
          height: 5,
          decoration: BoxDecoration(
              color: percentageToColor(percentage),
              borderRadius: BorderRadius.circular(5)),
        )
      ],
    );
  }

  Widget buildLimiterInfoWidget(
    BuildContext context, {
    required DBModelExpenseLimiter limiter,
    required DBModelExpenseCategory category,
    required DBModelWallet wallet,
  }) {
    final width = MediaQuery.sizeOf(context).width * 0.8;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            color: Colors.white12, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name!,
                        style: getTextStyle(
                            context, KTStyle.title, KTSType.small, Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        limiter.period.dropdownString,
                        style: getTextStyle(context, KTStyle.label,
                            KTSType.medium, Colors.white),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currencyFormat(limiter.current_amount),
                        style: getTextStyle(
                            context, KTStyle.title, KTSType.small, Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'of ${currencyFormat(limiter.limit_amount)}',
                        style: getTextStyle(context, KTStyle.label,
                            KTSType.medium, Colors.white),
                      ),
                    ],
                  )
                ],
              ),
              dummyHeight(10),
              buildBar(context,
                  getPercentage(limiter.current_amount, limiter.limit_amount)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return KContainer(
      context,
      child: buildContent(context, ref),
      backgroundColor: bgColor,
    );
  }
}
