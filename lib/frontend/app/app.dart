import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/drawer.dart';
import 'package:keuanganku/frontend/app/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/analysis/analysis.dart';
import 'package:keuanganku/frontend/app/main/analysis/analysis_provider.dart';
import 'package:keuanganku/frontend/app/main/home/home.dart';
import 'package:keuanganku/frontend/app/main/home/home_provider.dart';
import 'package:keuanganku/frontend/app/income_category_provider.dart';
import 'package:keuanganku/frontend/app/main/test_page.dart';
import 'package:keuanganku/frontend/app/wallet_provider.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';
import 'package:keuanganku/frontend/utility/keep_alive.dart';

final pageIndexProvider = StateProvider<int>((_) => 0);
final pageControllerProvider = StateProvider<PageController>((_) => PageController());
final mainPageScaffoldKeyProvider = StateProvider<GlobalKey<ScaffoldState>>((_) => GlobalKey<ScaffoldState>());
final pageNames = ["Home", "Wallets", "Analysis"];
final pages = <Widget>[
  const KeepAlivePage(child: Homepage()),
  const KeepAlivePage(child: Homepage()),
  const KeepAlivePage(child: AnalysisPage()),
];

class KeuanganKuPro extends HookConsumerWidget {
  const KeuanganKuPro({super.key});
  void whenBottomNavbarChanged(
      int value, WidgetRef ref, PageController pageController) {
    ref.read(pageIndexProvider.notifier).state = value;
    pageController.jumpToPage(value);
  }
  Color _iconColor(index, currenIndex) {
    if (index != currenIndex) return FontColor.black.color.withAlpha(150);
    return FontColor.black.color;
  }
  List<BottomNavigationBarItem> bottomNavigationBarItems(currentIndex) {
    return [
      BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _iconColor(0, currentIndex),
          ),
          label: pageNames[0]),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.wallet,
            color: _iconColor(1, currentIndex),
          ),
          label: pageNames[1]),
      BottomNavigationBarItem(
          icon: Icon(
            FluentIcons.data_usage_20_filled,
            color: _iconColor(2, currentIndex),
          ),
          label: pageNames[2]),
    ];
  }
  void initData(BuildContext context, WidgetRef ref) async{
    // Data
    ref.watch(globalWalletsProvider.notifier).initData();
    ref.watch(globalIncomeCategoriesProvider.notifier).initData();
    ref.watch(globalExpenseCategoriesProvider.notifier).initData();

    ref.watch(homepageProvider.notifier).initData();
    INITDATA_AnalysisPage(context, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var scaffoldKey = ref.watch(mainPageScaffoldKeyProvider);
    var pageIndex = ref.watch(pageIndexProvider);
    var pageController = ref.watch(pageControllerProvider);

    initData(context, ref);

    return Scaffold(
      appBar: AppBar(
        title: Text(pageNames[pageIndex]),
        backgroundColor: Colors.white,
      ),
      drawer: appDrawer(context),
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
        type: BottomNavigationBarType.fixed,
        selectedItemColor: FontColor.black.color,
        unselectedItemColor: FontColor.black.color.withAlpha(150),
        items: bottomNavigationBarItems(pageIndex),
      ),
    );
  }
}
