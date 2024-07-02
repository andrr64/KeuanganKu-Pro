import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/utility/color.dart';

class IncomeCard extends StatefulWidget {
  const IncomeCard({super.key});
  final bg_color = const Color(0xff489F7B);

  @override
  State<IncomeCard> createState() => _IncomeCardState();
}

class _IncomeCardState extends State<IncomeCard> {
  Widget content(BuildContext context) {
    List<Color> generated3color = generate3Color(widget.bg_color);

    return (Row(
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
    ));
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
