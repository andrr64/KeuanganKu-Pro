import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/dropdown/k_dropdown.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/utility/color.dart';

class IncomeCardData {
  DateRange dateRangeValue;

  set dateRange(DateRange val) {
    dateRangeValue = val;
  }

  IncomeCardData({required this.dateRangeValue});
}

class IncomeCard extends StatefulWidget {
  const IncomeCard(this.income_card_data, {super.key});

  final bg_color = const Color(0xff3EAA70);
  final IncomeCardData income_card_data;

  @override
  State<IncomeCard> createState() => _IncomeCardState();
}

class _IncomeCardState extends State<IncomeCard> {
  void onDropdownDateRangeChange(DateRange? val) {
    setState(() {
      if (val != null) {
        widget.income_card_data.dateRange = val;
      }
    });
  }

  Widget content(BuildContext context) {
    final KDropdown<DateRange> data_range =
        KDropdown(KDropdownItem(DateRange.weekly.getDateRangeMap()));
    final List<Color> generated3color = generate3Color(widget.bg_color);

    return (
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          data_range.dropdownButton(
            widget.income_card_data.dateRangeValue,
            onDropdownDateRangeChange,
            icon_theme: Theme.of(context).iconTheme,
            dropdown_bg_color: generated3color[1],
            text_style: Theme.of(context).textTheme.labelMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Income this month',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    currencyFormat(1200000),
                    style: Theme.of(context).textTheme.displayMedium,
                  )
                ],
              ),
              k_button(context, () {},
                  icon: Icons.add,
                  text: 'Add',
                  mainColor: generated3color[1],
                  iconColor: Colors.white)
            ],
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return KCardPlus(context, content(context),
        title: 'Income',
        color: widget.bg_color,
        icon: const Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ));
  }
}
