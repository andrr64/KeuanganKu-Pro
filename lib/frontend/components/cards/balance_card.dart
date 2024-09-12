import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/forms/wallet_form.dart';
import 'package:keuanganku/frontend/app/main/home/home_provider.dart';
import 'package:keuanganku/frontend/app/providers/wallet_provider.dart';
import 'package:keuanganku/frontend/components/buttons/k_outlined_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/cards/wallet_card.dart';
import 'package:keuanganku/frontend/components/empty_data.dart';
import 'package:keuanganku/frontend/components/spacer/v_space.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class BalanceCard extends HookConsumerWidget {
  const BalanceCard({super.key, this.without_title, this.without_name});
  final bool? without_title;
  final bool? without_name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var walletsProvider = ref.watch(globalWalletsProvider);
    var walletsProviderNotifier = ref.read(globalWalletsProvider.notifier);

    void whenAddButtonPressed() {
      openPage(context, WalletForm(
        callbackWhenDataSaved: (wallet) {
          walletsProviderNotifier.add(wallet);
          ref.read(homepageProvider.notifier).updateIncomes();
        },
      ));
    }

    Widget buildWallets() {
      if (walletsProvider.isEmpty) {
        return const EmptyData(iconColor: Colors.white);
      }
      return Column(
        children: [
          dummyHeight(10),
          ...List<Widget>.generate(walletsProvider.length,
              (i) => WalletCard(wallet: walletsProvider[i]))
        ],
      );
    }

    Widget buildContent() {
      return Padding(
        padding: const EdgeInsets.all(22.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...kContainerHeading(context,
                        const ['Wallets', 'All your wallet information.']),
                  ],
                )),
              ],
            ),
            vspace_10,
            Center(
              child: Column(
                children: [
                  buildWallets(),
                  KOutlinedButton(
                      onPressed: () {
                        whenAddButtonPressed();
                      },
                      text: 'Add Wallet',
                      color: Colors.white12,
                      icon: const Icon(FluentIcons.add_12_filled),
                      textColor: Colors.white,
                      withOutline: false),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return KContainer(
      context,
      child: buildContent(),
      backgroundColor: const Color(0xff222831),
    );
  }
}
