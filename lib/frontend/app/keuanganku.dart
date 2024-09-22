import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/bottom_navigation_bar.dart';
import 'package:keuanganku/frontend/app/drawer.dart';
import 'package:keuanganku/frontend/app/main/wallet/wallet.dart';
import 'package:keuanganku/frontend/app/main/home/home.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();
final pageIndexProvider = StateProvider<int>((ref) => 0);
final pages = [
  const Homepage(),
  const WalletPage()
];
final pageNames = ['Home', 'Wallets', 'Analysis'];
final pageViewControllerProvider =
    StateProvider<PageController>((_) => PageController());

class KeuanganKuPro extends HookConsumerWidget {
  const KeuanganKuPro({super.key});

  void whenBottomBarPressed(int index, WidgetRef ref) {
    ref.read(pageIndexProvider.notifier).state = index;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: appDrawer(context),
        appBar: pageIndex == 0
            ? null
            : AppBar(
                centerTitle: true,
                title: Text(pageNames[pageIndex]),
              ),
        bottomNavigationBar: KBottomNavigationBar(
            index: pageIndex,
            callback: (val) => whenBottomBarPressed(val, ref)),
        body: pages[pageIndex]);
  }
}
