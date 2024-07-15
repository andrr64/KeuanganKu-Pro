import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/utility/color.dart';

class ExpenseCard extends StatefulWidget {
  const ExpenseCard({super.key});
  final Color bg_color = const Color(0xffa64646);

  @override
  State<ExpenseCard> createState() => _ExpenseCardState();
}

class _ExpenseCardState extends State<ExpenseCard> {

  Widget content(BuildContext context) {
    List<Color> generated3Color = generate3Color(widget.bg_color);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kText(context, 'Expense this month', KTStyle.label, KTSType.medium, color: Colors.white),
            kText(context, currencyFormat(1200000), KTStyle.display, KTSType.medium, color: Colors.white),
          ],
        ),
        k_button(context, () {},
            icon: Icons.add,
            text: 'Add',
            mainColor: generated3Color[1],
            iconColor: Colors.white),
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