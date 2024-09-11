import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/model/income_category.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/app/forms/income_form.dart';
import 'package:keuanganku/frontend/components/buttons/k_outlined_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/colors/base_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class IncomeCard extends StatelessWidget {
  final DateRange dateRange;
  final double incomesAmount;
  final List<DBModelWallet> wallets;
  final List<DBModelIncomeCategory> incomeCategories;

  final void Function(DateRange val) callbackWhenDateChange;
  final void Function(DBModelIncome) callbackWhenNewIncomeSaved;

  const IncomeCard({
    super.key,
    required this.dateRange,
    required this.incomesAmount,
    required this.callbackWhenDateChange,
    required this.callbackWhenNewIncomeSaved,
    required this.wallets,
    required this.incomeCategories,
  });

  final Color backgroundColor = const Color(0xff1B4242);

  Widget buildContent(BuildContext context) {
    List<Widget> buildTitle() {
      const TEXT = ['Income', 'Lorem ipsum.'];
      return [
        kText(context, TEXT[0], KTStyle.title, KTSType.large,
            fontWeight: FontWeight.w500, color: Colors.white),
        kText(context, TEXT[1], KTStyle.label, KTSType.medium,
            color: Colors.white),
      ];
    }

    final List<Color> generated3color = generate3Color(backgroundColor);

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
                      items: DateRange.values,
                      itemsAsString: DateRange.values
                          .map((e) => e.dropdownString)
                          .toList(),
                      value: dateRange,
                      borderColor: Colors.white60,
                      foregroundColor: Colors.white,
                      borderWidth: 0.25,
                      backgroundColor: generated3color[1],
                      dropdownTextColor: Colors.white,
                      onChanged: whenDropdownDateRangeChange,
                      label: 'Period',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      currencyFormat(incomesAmount),
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
        ));
  }

  void whenDropdownDateRangeChange(DateRange? val) {
    if (val != null && val != dateRange) {
      callbackWhenDateChange(val);
    }
  }

  void whenAddButtonPressed(BuildContext context) {
    openPage(
        context,
        IncomeForm(
            wallets: wallets,
            incomeCategories: incomeCategories,
            callbackWhenDataSaved: callbackWhenNewIncomeSaved));
  }

  @override
  Widget build(BuildContext context) {
    return KCardPlus(
      context,
      buildContent(context),
      title: 'Income',
      withoutTitle: true,
      color: backgroundColor,
    );
  }
}
