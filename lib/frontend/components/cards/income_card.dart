import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/model/income_category.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/app/forms/income_form.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/dropdown/k_dropdown.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';
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

  @override
  Widget build(BuildContext context) {
    final KDropdown<DateRange> dataRangeDropdown =
        KDropdown(KDropdownItem(DateRange.week.getDateRangeMap()));
    final List<Color> generated3color =
        generate3Color(BaseColor.old_green.color);

    void whenDropdownDateRangeChange(DateRange? val) {
      if (val != null && val != dateRange) {
        callbackWhenDateChange(val);
      }
    }

    void whenAddButtonPressed() {
      openPage(
          context,
          IncomeForm(
              wallets: wallets,
              incomeCategories: incomeCategories,
              callbackWhenDataSaved: callbackWhenNewIncomeSaved));
    }

    return KCardPlus(
      title: 'Income',
      icon: const Icon(FluentIcons.arrow_up_20_filled),
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dataRangeDropdown.dropdownButton(
            dateRange,
            whenDropdownDateRangeChange,
            icon_theme: Theme.of(context).iconTheme,
            dropdown_bg_color: generated3color[1],
            text_style: getTextStyle(context, KTStyle.label, KTSType.medium, Colors.white),
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
                    'Income this ${dateRange.value}',
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
              k_button(
                context,
                whenAddButtonPressed,
                icon: Icons.add,
                text: 'Add',
                mainColor: generated3color[1],
                iconColor: Colors.white,
              ),
            ],
          ),
          dummyHeight(5),
          Center(
            child: k_button(
              context,
              whenAddButtonPressed,
              text: 'Detail',
              withoutBg: true,
              mainColor: generated3color[1],
              iconColor: Colors.white,
            ),
          ),
        ],
      ),
      color: BaseColor.old_green.color,
    );
  }
}
