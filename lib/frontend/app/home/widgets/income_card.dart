import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/dropdown/k_dropdown.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/app/home/pages/input_income_data_form.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/color.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';
import 'package:keuanganku/main.dart';

class IncomeCardData {
  DateRange dateRangeValue;
  List<DBModelIncome> incomes = [];
  double incomeCache = 0;

  set setDateRange(DateRange val) {
    dateRangeValue = val;
  }

  IncomeCardData({required this.dateRangeValue});
}

class IncomeCard extends StatefulWidget {
  const IncomeCard(this.data, {super.key});

  final IncomeCardData data;

  @override
  State<IncomeCard> createState() => _IncomeCardState();
}

class _IncomeCardState extends State<IncomeCard> {
  // Events
  void updateState() {
    setState(() {});
  }

  void whenDropdownDateRangeChange(DateRange? val) {
    if (val != widget.data.dateRangeValue){
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
                InputIncomeDataForm(callbackWhenDataSaved: updateState)));
  }

  // Frontend
  Widget content(BuildContext context, {required String income}) {
    final KDropdown<DateRange> data_range =
        KDropdown(KDropdownItem(DateRange.weekly.getDateRangeMap()));
    final List<Color> generated3color =
        generate3Color(BaseColor.old_green.color);
    return (Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kText(
                    context, 'Income this ${widget.data.dateRangeValue.value}', KTStyle.label, KTSType.medium,
                    color: Colors.white),
                kText(context, income, KTStyle.display, KTSType.medium,
                    color: Colors.white)
              ],
            ),
            k_button(context, whenAddButtonPressed,
                icon: Icons.add,
                text: 'Add',
                mainColor: generated3color[1],
                iconColor: Colors.white)
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
    ));
  }

  // Backend
  Future getData() async {
    widget.data.incomes = await DBHelperIncome()
        .readAll(db: db.database, date: widget.data.dateRangeValue);
    widget.data.incomeCache = DBModelIncome().sum(widget.data.incomes);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // TODO: implement when waiting/skeleton
            return KCardPlus(
                context,
                content(context,
                    income: currencyFormat(widget.data.incomeCache)),
                title: 'Income',
                color: BaseColor.old_green.color,
                icon: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ));
          } else if (snapshot.hasError) {
            return KCardPlus(
                context,
                content(context,
                    income: 'Something Wrong'),
                title: 'Income',
                color: BaseColor.old_green.color,
                icon: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ));
          } else {
            return KCardPlus(
                context,
                content(context,
                    income: currencyFormat(widget.data.incomeCache)),
                title: 'Income',
                color: BaseColor.old_green.color,
                icon: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                ));
          }
        });
  }
}
