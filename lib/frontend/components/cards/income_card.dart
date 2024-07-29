import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/forms/income_form.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/dropdown/k_dropdown.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/color.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class IncomeCard extends HookConsumerWidget {
  final DateRange dateRange;
  final double incomesAmount;
  final void Function(DateRange val) callbackWhenDateChange;

  const IncomeCard(
      {super.key,
        required this.dateRange,
        required this.incomesAmount,
        required this.callbackWhenDateChange});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final KDropdown<DateRange> data_range =
    KDropdown(KDropdownItem(DateRange.week.getDateRangeMap()));
    final List<Color> generated3color =
    generate3Color(BaseColor.old_green.color);

    void whenDropdownDateRangeChange(DateRange? val) {
      if (val != null && val != dateRange) {
        callbackWhenDateChange(val);
      }
    }

    void whenAddButtonPressed() {
      // TODO: implement callbackWhenDataSaved
      openPage(context, IncomeForm(callbackWhenDataSaved: (income) {}));
    }

    Widget content() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data_range.dropdownButton(
            dateRange,
            whenDropdownDateRangeChange,
            icon_theme: Theme.of(context).iconTheme,
            dropdown_bg_color: generated3color[1],
            text_style: const TextStyle(
                fontFamily: 'Quicksand', fontWeight: FontWeight.w500),
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
                    KTStyle.display,
                    KTSType.medium,
                    color: Colors.white,
                  )
                ],
              ),
              k_button(
                context,
                whenAddButtonPressed,
                icon: Icons.add,
                text: 'Add',
                mainColor: generated3color[1],
                iconColor: Colors.white,
              )
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
          )
        ],
      );
    }

    return  KCardPlus(
        title: 'Income',
        icon: const Icon(FluentIcons.arrow_up_20_filled),
        context,
        content(),
        color: BaseColor.old_green.color
    );
  }
}