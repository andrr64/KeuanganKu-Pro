import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/forms/wallet_form.dart';
import 'package:keuanganku/frontend/app/main/home/home_provider.dart';
import 'package:keuanganku/frontend/app/providers/wallet_provider.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/cards/k_card_plus.dart';
import 'package:keuanganku/frontend/components/cards/wallet_card.dart';
import 'package:keuanganku/frontend/components/empty_data.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/colors/k_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class BalanceCard extends HookConsumerWidget {
  const BalanceCard({super.key, this.without_title, this.without_name});
  final bool? without_title;
  final bool? without_name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    Widget buildWallets() {
      if (walletsProvider.isEmpty) {
        return const EmptyData(iconColor: Colors.white);
      }
      return Column(
        children: [
          dummyHeight(20),
          ...List<Widget>.generate(walletsProvider.length,
              (i) => WalletCard(wallet: walletsProvider[i]))
        ],
      );
    }

    List<Widget> buildTitle() {
      const TEXT = [
        'Wallets',
        'All your wallet information.'
      ];

      return [
        kText(context, TEXT[0], KTStyle.title, KTSType.large,
            color: Colors.white),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.7,
          child: kText(context, TEXT[1], KTStyle.label,
              KTSType.medium,
              color: Colors.white),
        )
      ];
    }

    Widget buildContent() {
      return Padding(
        padding: const EdgeInsets.all(22.5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...buildTitle()],
                ),
              ],
            ),
            buildWallets(),
            dummyHeight(10),
            k_button(
              context,
              () {
                whenAddButtonPressed(context);
              },
              text: 'Add Wallet',
              mainColor: Colors.white.withAlpha(40),
            )
          ],
        ),
      );
    }

    return KCardPlus(context, buildContent(),
        color: BaseColor.primary.color,
        title: 'Balance',
        withoutTitle: true,
        icon: const Icon(
          FluentIcons.text_bullet_list_square_20_filled,
          color: Colors.white,
        ));
  }
}
