import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/forms/wallet_form.dart';
import 'package:keuanganku/frontend/app/home/home_provider.dart';
import 'package:keuanganku/frontend/app/provider/userdata.dart';
import 'package:keuanganku/frontend/app/provider/wallet_list.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/cards/wallet_card.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/currency_format.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class BalanceCard extends HookConsumerWidget {
  final bgColor = const Color(0xff363658);

  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userdataProvider = ref.watch(globalUserdataProvider.notifier);
    var walletsProvider = ref.watch(globalWalletListProvider);
    var walletsProviderNotifier = ref.read(globalWalletListProvider.notifier);

    void whenAddButtonPressed(BuildContext context) {
      openPage(context, WalletForm(
        callbackWhenDataSaved: (wallet) {
          walletsProviderNotifier.add(wallet);
          ref.read(homepageProvider.notifier).updateIncomes();
        },
      ));
    }

    Widget doGenerateWalletCards() {
      if (walletsProvider.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
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
                    fontSize:
                        Theme.of(context).textTheme.displaySmall!.fontSize,
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
                walletsProvider.length, (i) => WalletCard(wallet: walletsProvider[i]))
          ],
        );
      }
    }

    // Frontend
    Widget content() {
      var name = userdataProvider.name;
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
                  kText(context, currencyFormat(walletsProviderNotifier.totalIncome), KTStyle.display,
                      KTSType.medium,
                      color: Colors.white),
                ],
              ),
            ],
          ),
          dummyHeight(10),
          doGenerateWalletCards(),
          k_button(
            context,
            () {
              whenAddButtonPressed(context);
            },
            text: 'Add Wallet',
            icon: Icons.add_box,
            mainColor: Colors.white.withAlpha(50),
            withoutBg: true,
          )
        ],
      );
    }

    return KCardPlus(context, content(),
        color: bgColor,
        title: 'Balance',
        icon: const Icon(
          FluentIcons.text_bullet_list_square_20_filled,
          color: Colors.white,
        ));
  }
}
