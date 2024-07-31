import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/forms/wallet_form.dart';
import 'package:keuanganku/frontend/app/home/home_provider.dart';
import 'package:keuanganku/frontend/app/userdata_provider.dart';
import 'package:keuanganku/frontend/app/wallet_provider.dart';
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
    var walletsProvider = ref.watch(globalWalletsProvider);
    var walletsProviderNotifier = ref.read(globalWalletsProvider.notifier);

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
                FluentIcons.wallet_20_filled,
                size: 30,
              ),
              kText(context, 'Empty Wallet', KTStyle.body, KTSType.medium, color: Colors.white),
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
                  kText(context, 'Hi', KTStyle.title, KTSType.small,
                      color: Colors.white),
                  kText(context, name, KTStyle.title, KTSType.large,
                      color: Colors.white),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  kText(context, 'Balance', KTStyle.title, KTSType.small,
                      color: Colors.white),
                  kText(context, currencyFormat(walletsProviderNotifier.totalBalance), KTStyle.title,
                      KTSType.large,
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
