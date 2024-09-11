import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/drawer.dart';
import 'package:keuanganku/frontend/app/providers/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/home/home.dart';
import 'package:keuanganku/frontend/app/providers/expense_limiter.dart';
import 'package:keuanganku/frontend/app/providers/income_category_provider.dart';
import 'package:keuanganku/frontend/app/providers/wallet_provider.dart';
import 'package:keuanganku/frontend/utility/future.dart';
import 'package:keuanganku/main.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class KeuanganKuPro extends HookConsumerWidget {
  const KeuanganKuPro({super.key});

  Future<void> initData(BuildContext context, WidgetRef ref) async {
    // Initialize Global Data
    ref.watch(globalWalletsProvider.notifier).initData();
    ref.watch(globalIncomeCategoriesProvider.notifier).initData();
    ref.watch(globalExpenseCategoriesProvider.notifier).initData();
    ref.watch(globalExpenseLimiterNotifierProvider.notifier).initData();

    ///TODO: uncomment
    // Initialize Main Page Data
    // INITDATA_AnalysisPage(context, ref);
    INITDATA_HomePage(context, ref);
    // INITDATA_WalletPage(context, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      drawer: appDrawer(context),
      body: kFutureBuilder<void>(
        futureFunction: initData(context, ref),
        wxWhenError: (err) => AppError(error: err.toString()),
        wxWhenSuccess: (_) => const Homepage(),
        wxWhenWaiting: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
