import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/database_services.dart';
import 'package:keuanganku/frontend/app/error_page.dart';
import 'package:keuanganku/frontend/app/keuanganku.dart';
import 'package:keuanganku/frontend/app/main/home/home_provider.dart';
import 'package:keuanganku/frontend/app/main/introduction/intro.dart';
import 'package:keuanganku/frontend/app/providers/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/providers/expense_limiter.dart';
import 'package:keuanganku/frontend/app/providers/income_category_provider.dart';
import 'package:keuanganku/frontend/app/providers/userdata_provider.dart';
import 'package:keuanganku/frontend/app/providers/wallet_provider.dart';
import 'package:keuanganku/frontend/themes/light_theme.dart';
import 'package:keuanganku/frontend/utility/future.dart';

DatabaseServices db = DatabaseServices();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await db.openDb();
  } catch (err) {
    runApp(ErrorPage(error: err));
    return;
  }
  runApp(const ProviderScope(child: AppController()));
}


class AppController extends HookConsumerWidget {
  const AppController({super.key});

  Future<void> initData(BuildContext context, WidgetRef ref) async {
    // Initialize Global Data
    await ref.read(globalWalletsProvider.notifier).initData();
    await ref.read(globalIncomeCategoriesProvider.notifier).initData();
    await ref.read(globalExpenseCategoriesProvider.notifier).initData();
    await ref.read(globalExpenseLimiterNotifierProvider.notifier).initData();
    await ref.read(globalUserdataProvider.notifier).initData();

    // Initialize Page Data
    await ref.read(homepageProvider.notifier).initData();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'KeuanganKu Pro',
      home: kFutureBuilder<void>(
          futureFunction: initData(context, ref),
          wxWhenError: (err) => ErrorPage(error: err.toString()),
          wxWhenSuccess: (_) {
            if (ref.watch(globalUserdataProvider).invalid) {
              return IntroPage(callback: () {
                ref.read(globalUserdataProvider.notifier).initData();
              });
            } else {
              return const KeuanganKuPro();
            }
          },
          wxWhenWaiting: const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )),
      theme: light_theme,
    );
  }
}
