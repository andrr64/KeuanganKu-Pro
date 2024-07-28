import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/frontend/app/forms/expense_form.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/dropdown/k_dropdown.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/color.dart';
import 'package:keuanganku/frontend/utility/future.dart';
import 'package:keuanganku/main.dart';

class ExpenseCardData {
  DateRange dateRangeValue;
  List<DBModelExpense> expenses = [];
  double expenseAmountCache = 0;

  set setDateRange(DateRange val) {
    dateRangeValue = val;
  }

  ExpenseCardData({required this.dateRangeValue});
}

class ExpenseCard extends StatefulWidget {
  const ExpenseCard(this.data, {super.key});
  final Color bgColor = const Color(0xffa64646);
  final ExpenseCardData data;

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {
  // Events
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
        builder: (context) => InputExpenseDataForm(callbackWhenDataSaved: updateState),
      ),
    );
  }

  // Frontend
  Widget content(BuildContext context, {required String expense}) {
    List<Color> generated3color = generate3Color(widget.bgColor);
    final KDropdown<DateRange> dataRange =
    KDropdown(KDropdownItem(DateRange.week.getDateRangeMap()));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        dataRange.dropdownButton(
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
                kText(context, 'Expense this ${widget.data.dateRangeValue.value}', KTStyle.label,
                    KTSType.medium,
                    color: Colors.white),
                kText(context, expense, KTStyle.display, KTSType.medium,
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

  // Backend
  Future getData() async {
    try {
      widget.data.expenses = await DBHelperExpense().readAll(db: db.database, date: widget.data.dateRangeValue);
      widget.data.expenseAmountCache = DBModelExpense().sum(widget.data.expenses);
    } catch (e) {
      throw Exception('Failed to load expenses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return kFutureBuilder(
      futureFunction: getData(),
      wxWhenError: (error) {
        return KCardPlus(
          context,
          content(context, expense: "$error"),
          title: 'Expense',
          color: widget.bgColor,
          icon: const Icon(Icons.arrow_downward, color: Colors.white),
        );
      },
      wxWhenSuccess: (_) {
        return KCardPlus(
          context,
          content(context,
              expense: currencyFormat(widget.data.expenseAmountCache)),
          title: 'Expense',
          color: widget.bgColor,
          icon: const Icon(Icons.arrow_downward, color: Colors.white),
        );
      },
      wxWhenWaiting: KCardPlus(
        context,
        content(context,
            expense: currencyFormat(widget.data.expenseAmountCache)),
        title: 'Expense',
        color: widget.bgColor,
        icon: const Icon(Icons.arrow_downward, color: Colors.white),
      ),
    );
  }
}
