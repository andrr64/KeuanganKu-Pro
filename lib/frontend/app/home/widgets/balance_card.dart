import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/wallet.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/app/forms/form_wallet.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/future.dart';
import 'package:keuanganku/frontend/utility/page.dart';
import 'package:keuanganku/main.dart';

class BalanceCardData {
  double balanceAmount = 0;
  List<DBModelWallet> wallets = [];
}

class BalanceCard extends StatefulWidget {
  final String? name;
  final double? balance;
  final BalanceCardData data;
  final bgColor = const Color(0xff363658);

  const BalanceCard({super.key, this.name, this.balance, required this.data});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  void updateState() {
    setState(() {});
  }

  Widget walletCard(DBModelWallet wallet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withAlpha(50)),
        ),
      ),
    );
  }

  Widget generateWalletCards(List<DBModelWallet> wallets) {
    if (wallets.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FluentIcons.wallet_24_regular,
              size: 40,
            ),
            Text(
              'Empty Wallet',
              style: TextStyle(
                  fontWeight:
                      Theme.of(context).textTheme.displaySmall!.fontWeight,
                  fontStyle:
                      Theme.of(context).textTheme.displaySmall!.fontStyle,
                  fontSize: Theme.of(context).textTheme.displaySmall!.fontSize,
                  fontFamily:
                      Theme.of(context).textTheme.displaySmall!.fontFamily,
                  color: Colors.white),
            )
          ],
        ),
      );
    } else {
      return Column(
        children: [
          ...List<Widget>.generate(
              wallets.length, (i) => walletCard(wallets[i]))
        ],
      );
    }
  }

  Widget content(BuildContext context, {String? name, double? balance}) {
    name = name ?? 'John';
    balance = balance ?? 0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kText(context, 'Hi', KTStyle.label, KTSType.medium,
                    color: Colors.white),
                kText(context, name, KTStyle.display, KTSType.medium,
                    color: Colors.white),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                kText(context, 'Balance', KTStyle.label, KTSType.medium,
                    color: Colors.white),
                kText(context, currencyFormat(balance), KTStyle.display,
                    KTSType.medium,
                    color: Colors.white),
              ],
            ),
          ],
        ),
        dummyHeight(10),
        generateWalletCards(widget.data.wallets),
        k_button(
          context,
          () => openPage(
              context,
              FormWallet(
                callbackWhenDataSaved: updateState,
              )),
          text: 'Add Wallet',
          icon: Icons.add_box,
          mainColor: Colors.white.withAlpha(50),
          withoutBg: true,
        )
      ],
    );
  }

  Future getData() async {
    widget.data.wallets = await DBHelperWallet().readAll(db: db.database);
    widget.data.balanceAmount = 500;
  }

  @override
  Widget build(BuildContext context) {
    return kFutureBuilder(
        futureFunction: getData(),
        wxWhenError: (err) {
          return KCardPlus(context, content(context, name: 'Error', balance: 0),
              color: widget.bgColor,
              title: 'Wallet',
              icon: const Icon(
                Icons.wallet,
                color: Colors.white,
              ));
        },
        wxWhenSuccess: (_) {
          return KCardPlus(
              context,
              content(context,
                  name: widget.name, balance: widget.data.balanceAmount),
              color: widget.bgColor,
              title: 'Wallet',
              icon: const Icon(
                Icons.wallet,
                color: Colors.white,
              ));
        },
        wxWhenWaiting: KCardPlus(
            context,
            content(context,
                name: widget.name, balance: widget.data.balanceAmount),
            color: widget.bgColor,
            title: 'Wallet',
            icon: const Icon(
              Icons.wallet,
              color: Colors.white,
            )));
  }
}
