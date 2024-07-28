import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
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
            title: wallet.type_str,
            icon: Icon(wallet.icon),
            color: const Color(0xff55557a),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kText(
                        context, wallet.name!, KTStyle.display, KTSType.small,
                        color: Colors.white),
                    kText(context, currencyFormat(wallet.total_income!), KTStyle.label,
                        KTSType.large,
                        color: Colors.white),
                  ],
                ),
                k_button(context, () {},
                    text: 'Detail',
                    mainColor: Colors.white.withAlpha(50),
                    withoutBg: true)
              ],
            )));
  }
}
