import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/colors/font_color.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';

class TotalBalance extends StatelessWidget {
  const TotalBalance({super.key, required this.totalBalance});
  
  final double totalBalance;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: kText(
                    context, 'Total Balance', KTStyle.title, KTSType.small,
                    color: fontColor_grey, fontWeight: FontWeight.normal),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  currencyFormat(totalBalance),
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: fontColor_black),
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
        const Expanded(
          flex: 1,
          child: CircleAvatar(
            backgroundColor: Colors.redAccent,
          ),
        )
      ],
    );
  }
}
