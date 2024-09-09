import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key, required this.wallet});

  final DBModelWallet wallet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.5),
      child: GestureDetector(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(wallet.icon),
                      dummyWidth(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kText(context, wallet.name!, KTStyle.label, KTSType.large,
                              color: Colors.white),
                          kText(
                              context,
                              currencyFormat(
                                  wallet.total_income! - wallet.total_expense!),
                              KTStyle.label,
                              KTSType.medium,
                              color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    FluentIcons.arrow_right_20_regular,
                    color: Colors.white,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
