import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';

class BalanceCard extends StatefulWidget {
  final String? name;
  final double? balance;

  const BalanceCard({super.key, this.name, this.balance});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  @override
  Widget build(BuildContext context) {
    return KCardPlus(
        context, content(context, name: widget.name, balance: widget.balance),
        color: const Color(0xff363658),
        title: 'Wallet',
        icon: const Icon(
          Icons.wallet,
          color: Colors.white,
        ));
  }

  Widget content(BuildContext context, {String? name, double? balance}) {
    name = name ?? 'John';
    balance = balance ?? 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kText(context, 'Hi', KTStyle.label, KTSType.medium, color: Colors.white),
            kText(context, name, KTStyle.display, KTSType.medium, color: Colors.white),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            kText(context, 'Balance', KTStyle.label, KTSType.medium, color: Colors.white),
            kText(context, currencyFormat(balance), KTStyle.display, KTSType.medium, color: Colors.white),
          ],
        ),
      ],
    );
  }
}