import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/bottom_nav_bar.dart';
import 'package:keuanganku/frontend/app/drawer.dart';
import 'package:keuanganku/frontend/app/keep_alive.dart';
import 'package:keuanganku/frontend/app/main/wallet/wallet.dart';
import 'package:keuanganku/frontend/app/main/home/home.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();
final pageIndexProvider = StateProvider<int>((ref) => 0);
final pages = [
  const KeepAlivePage(child: Homepage()),
  const KeepAlivePage(child: WalletPage())
];
final pageViewControllerProvider =
    StateProvider<PageController>((_) => PageController());

class KeuanganKuPro extends HookConsumerWidget {
  const KeuanganKuPro({super.key});

  void whenBottomBarPressed(int index, WidgetRef ref) {
    ref.read(pageIndexProvider.notifier).state = index;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        drawer: appDrawer(context),
        bottomNavigationBar: KBottomNavigationBar(
            index: ref.watch(pageIndexProvider),
            callback: (val) => whenBottomBarPressed(val, ref)),
        body: pages[ref.watch(pageIndexProvider)]);
  }
}
