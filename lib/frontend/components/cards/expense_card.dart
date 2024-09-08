import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/app/forms/expense_form.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/dropdown/k_dropdown.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/colors/k_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class ExpenseCard extends StatelessWidget {
  final Color bgColor = const Color(0xffa64646);

  final DateRange dateRange;
  final double expenseAmount;
  final List<DBModelExpenseCategory> expenseCategories;
  final List<DBModelWallet> wallets;

  final void Function(DateRange?) callbackWhenDataChange;
  final void Function(DBModelExpense) callbackWhenNewExpenseSaved;

  const ExpenseCard(
      {super.key,
      required this.expenseCategories,
      required this.wallets,
      required this.callbackWhenDataChange,
      required this.dateRange,
      required this.callbackWhenNewExpenseSaved,
      required this.expenseAmount});

  // Frontend
  Widget content(BuildContext context) {
    List<Color> generated3color = generate3Color(BaseColor.old_red.color);
    final KDropdown<DateRange> dataRange = KDropdown(KDropdownItem(DateRange.week.getDateRangeMap()));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dataRange.dropdownButton(
          dateRange,
          callbackWhenDataChange,
          icon_theme: Theme.of(context).iconTheme,
          dropdown_bg_color: generated3color[1],
          text_style: getTextStyle(context, KTStyle.label, KTSType.medium, Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kText(context, 'Expense this ${dateRange.value}', KTStyle.label,
                    KTSType.medium,
                    color: Colors.white),
                kText(context, currencyFormat(expenseAmount), KTStyle.title,
                    KTSType.large,
                    color: Colors.white),
              ],
            ),
            k_button(context , withoutBg: true, () {
              openPage(
                  context,
                  ExpenseForm(
                      callbackWhenDataSaved: callbackWhenNewExpenseSaved,
                      expenseCategories: expenseCategories,
                      wallets: wallets), );
            },
                icon: Icons.add,
                text: 'Add',
                mainColor: generated3color[1],
                iconColor: Colors.white),
          ],
        ),
        dummyHeight(5),
        Center(
          child: k_button(context, () {},
              text: 'Detail',
              withoutBg: true,
              mainColor: generated3color[1],
              iconColor: Colors.white),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KCardPlus(
      context,
      content(context),
      title: 'Expense',
      color: BaseColor.old_red.color,
      icon: const Icon(Icons.arrow_downward, color: Colors.white),
    );
  }
}
