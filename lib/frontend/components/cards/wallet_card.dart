import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key, required this.wallet});

  final DBModelWallet wallet;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: KCardPlus(
            context,
            title: wallet.typeString,
            icon: Icon(wallet.icon),
            color: const Color(0xff55557a),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kText(context, wallet.name!, KTStyle.display, KTSType.small,
                        color: Colors.white),
                    kText(context, currencyFormat(wallet.total_income! - wallet.total_expense!),
                        KTStyle.label, KTSType.large,
                        color: Colors.white),
                  ],
                ),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.white.withAlpha(50),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(100)))),
                  child: const Icon(
                    FluentIcons.arrow_right_20_regular,
                    color: Colors.white,
                  ),
                )
              ],
            )));
  }
}
