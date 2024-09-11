import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/app/forms/expense_form.dart';
import 'package:keuanganku/frontend/components/buttons/k_outlined_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/enum/time_period.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/colors/base_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class ExpenseCard extends StatelessWidget {
  final Color bgColor = const Color(0xffa64646);

  final TimePeriod dateRange;
  final double expenseAmount;
  final List<DBModelExpenseCategory> expenseCategories;
  final List<DBModelWallet> wallets;

  final void Function(TimePeriod?) callbackWhenDateChange;
  final void Function(DBModelExpense) callbackWhenSubmitNewExpense;
  final void Function(DBModelExpenseCategory)
      callbackWhenSubmitNewExpenseCategory;

  const ExpenseCard(
      {super.key,
      required this.expenseCategories,
      required this.wallets,
      required this.callbackWhenDateChange,
      required this.dateRange,
      required this.callbackWhenSubmitNewExpense,
      required this.callbackWhenSubmitNewExpenseCategory,
      required this.expenseAmount});

  void whenDateRangeChanged(TimePeriod val) {
    callbackWhenDateChange(val);
  }

  void whenAddButtonPressed(BuildContext context) {
    openPage(
      context,
      ExpenseForm(
        callbackWhenSubmitNewExpense: callbackWhenSubmitNewExpense,
        callbackWhenSubmitNewExpenseCategory:
            callbackWhenSubmitNewExpenseCategory,
        expenseCategories: expenseCategories,
        wallets: wallets,
      ),
    );
  }

  // Frontend
  Widget buildContent(BuildContext context) {
    List<Color> generated3color = generate3Color(baseColor_dark_red);

    List<Widget> buildTitle() {
      const TEXT = ['Expense', 'Lorem ipsum'];
      return [
        kText(context, TEXT[0], KTStyle.title, KTSType.large,
            fontWeight: FontWeight.w500, color: Colors.white),
        kText(context, TEXT[1], KTStyle.label, KTSType.medium,
            color: Colors.white),
      ];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: vw(context, 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...buildTitle()],
                ),
              ),
              SizedBox(
                width: vw(context, 30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: kDropdown(
                    context,
                    items: TimePeriod.values,
                    itemsAsString:
                        TimePeriod.values.map((e) => e.dropdownString).toList(),
                    value: dateRange,
                    borderColor: Colors.white60,
                    foregroundColor: Colors.white,
                    borderWidth: 0.25,
                    backgroundColor: generated3color[1],
                    dropdownTextColor: Colors.white,
                    onChanged: callbackWhenDateChange,
                    label: 'Period',
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  kText(
                    context,
                    dateRange.label,
                    KTStyle.label,
                    KTSType.medium,
                    color: Colors.white,
                  ),
                  kText(
                    context,
                    currencyFormat(expenseAmount),
                    KTStyle.title,
                    KTSType.large,
                    color: Colors.white,
                  ),
                ],
              ),
              KOutlinedButton(
                  onPressed: () => whenAddButtonPressed(context),
                  text: 'Add',
                  color: Colors.white12,
                  textColor: Colors.white,
                  icon: const Icon(FluentIcons.add_12_filled),
                  withOutline: false),
            ],
          ),
          dummyHeight(5),
          Center(
            child: KOutlinedButton(
                onPressed: () {
                  ///TODO: income_card.buildContent.KOutlinedButton(Detail Page)
                },
                paddingHorizontal: vw(context, 10),
                text: 'Detail',
                color: Colors.white12,
                withOutline: false,
                textColor: Colors.white),
          ),
          dummyHeight(10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return KCardPlus(
      context,
      buildContent(context),
      title: 'Expense',
      withoutTitle: true,
      color: baseColor_dark_red,
    );
  }
}
