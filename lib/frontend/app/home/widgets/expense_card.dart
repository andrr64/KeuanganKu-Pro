import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/frontend/app/home/pages/input_expense_data_form.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/dropdown/k_dropdown.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/color.dart';

class ExpenseCardData {
  DateRange dateRangeValue;
  List<DBModelExpense> expense = [];
  double incomeCache = 0;

  set setDateRange(DateRange val) {
    dateRangeValue = val;
  }

  ExpenseCardData({required this.dateRangeValue});
}

class ExpenseCard extends StatefulWidget {
  const ExpenseCard(this.data, {super.key});
  final Color bg_color = const Color(0xffa64646);
  final ExpenseCardData data;

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  void updateState() {
    setState(() {});
  }

  void whenDropdownDateRangeChange(DateRange? val) {
    if (val != widget.data.dateRangeValue) {
      setState(() {
        if (val != null) {
          widget.data.setDateRange = val;
        }
      });
    }
  }
  void whenAddButtonPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                InputExpenseDataForm(callbackWhenDataSaved: updateState)));
  }

  Widget content(BuildContext context) {
    List<Color> generated3color = generate3Color(widget.bg_color);
    final KDropdown<DateRange> data_range =
        KDropdown(KDropdownItem(DateRange.weekly.getDateRangeMap()));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        data_range.dropdownButton(
          widget.data.dateRangeValue,
          whenDropdownDateRangeChange,
          icon_theme: Theme.of(context).iconTheme,
          dropdown_bg_color: generated3color[1],
          text_style: const TextStyle(
              fontFamily: 'Quicksand', fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kText(context, 'Expense this month', KTStyle.label,
                    KTSType.medium,
                    color: Colors.white),
                kText(context, currencyFormat(1200000), KTStyle.display,
                    KTSType.medium,
                    color: Colors.white),
              ],
            ),
            k_button(context, whenAddButtonPressed,
                icon: Icons.add,
                text: 'Add',
                mainColor: generated3color[1],
                iconColor: Colors.white),
          ],
        ),
        dummyHeight(5),
        Center(
          child: k_button(context, whenAddButtonPressed,
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
      color: widget.bg_color,
      icon: const Icon(Icons.arrow_downward, color: Colors.white),
    );
  }
}
