import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/model/income_category.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/app/forms/income_form.dart';
import 'package:keuanganku/frontend/components/buttons/k_outlined_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/enum/time_period.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/spacer/v_space.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/colors/base_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class IncomeCard extends StatelessWidget {
  final TimePeriod dateRange;
  final double incomesAmount;
  final List<DBModelWallet> wallets;
  final List<DBModelIncomeCategory> incomeCategories;

  final void Function(TimePeriod val) callbackWhenDateChange;
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

  List<Widget> buildTitle(BuildContext context) {
    const TEXT = ['Income', 'Lorem ipsum.'];
    return [
      kText(context, TEXT[0], KTStyle.title, KTSType.large,
          fontWeight: FontWeight.w500, color: Colors.white),
      kText(context, TEXT[1], KTStyle.label, KTSType.medium,
          color: Colors.white),
    ];
  }

  Widget buildContent(BuildContext context) {
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
                Expanded(
                  flex: 11,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          kContainerHeading(context, ['Income', 'lorem ipsum']),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: kDropdown(
                        context,
                        items: TimePeriod.values,
                        itemsAsString: TimePeriod.values
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
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
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
                ),
                Expanded(
                  child: KOutlinedButton(
                      onPressed: () => whenAddButtonPressed(context),
                      text: 'Add',
                      color: Colors.white12,
                      textColor: Colors.white,
                      icon: const Icon(
                        FluentIcons.add_12_filled,
                        size: 16,
                      ),
                      withOutline: false),
                ),
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
            vspace_10,
          ],
        ));
  }

  void whenDropdownDateRangeChange(TimePeriod? val) {
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
    return KContainer(
      context,
      child: buildContent(context),
      backgroundColor: backgroundColor,
    );
  }
}
