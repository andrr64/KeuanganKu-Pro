import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/home/home.dart';
import 'package:keuanganku/frontend/app/home/home_provider.dart';
import 'package:keuanganku/frontend/app/income_category_provider.dart';
import 'package:keuanganku/frontend/app/wallet_provider.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

final pageIndexProvider = StateProvider<int>((_) => 0);
final pageControllerProvider = StateProvider<PageController>((_) => PageController());
final mainPageScaffoldKeyProvider = StateProvider<GlobalKey<ScaffoldState>>((_) => GlobalKey<ScaffoldState>());
final pageNames = ["Home", "Wallet"];
final pagesProvider = StateProvider<List<Widget>>((ref) {
  return [
    const Homepage(),
    const Homepage(),
  ];
});

class KeuanganKuPro extends HookConsumerWidget {
  const KeuanganKuPro({super.key});

  void whenBottomNavbarChanged(int value, WidgetRef ref, PageController pageController) {
    ref.read(pageIndexProvider.notifier).state = value;
    pageController.jumpToPage(value);
  }

  List<BottomNavigationBarItem> bottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(icon: const Icon(Icons.home), label: pageNames[0]),
      BottomNavigationBarItem(icon: const Icon(Icons.wallet), label: pageNames[1])
    ];
  }

  void initData(WidgetRef ref){
    ref.watch(globalWalletsProvider.notifier).initData();
    ref.watch(globalIncomeCategoriesProvider.notifier).initData();
    ref.watch(globalExpenseCategoriesProvider.notifier).initData();
    ref.watch(homepageProvider.notifier).initData();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var scaffoldKey = ref.watch(mainPageScaffoldKeyProvider);
    var pageIndex = ref.watch(pageIndexProvider);
    var pageController = ref.watch(pageControllerProvider);
    var pages = ref.watch(pagesProvider);

    initData(ref);

    return Scaffold(
      appBar: AppBar(
        title: Text(pageNames[pageIndex]),
        backgroundColor: BackgroundColor.white.getColor(),
      ),
      key: scaffoldKey,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) =>
            ref.read(pageIndexProvider.notifier).state = index,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) => whenBottomNavbarChanged(value, ref, pageController),
        backgroundColor: Colors.white,
        items: bottomNavigationBarItems(),
      ),
    );
  }
}
