import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/database_services.dart';
import 'package:keuanganku/frontend/app/app.dart';
import 'package:keuanganku/frontend/app/content_when_x.dart';
import 'package:keuanganku/frontend/app/main/home/home.dart';
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
    runApp(AppError(error: err));
    return;
  }
  runApp(const ProviderScope(child: App()));
}

class AppError extends StatelessWidget {
  const AppError({super.key, required this.error});
  final Object error;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: contentWhenError(context, error),
      theme: light_theme,
    );
  }
}

class App extends HookConsumerWidget {
  const App({super.key});

  Future<void> initData(BuildContext context, WidgetRef ref) async {
    // Initialize Global Data
    ref.watch(globalWalletsProvider.notifier).initData();
    ref.watch(globalIncomeCategoriesProvider.notifier).initData();
    ref.watch(globalExpenseCategoriesProvider.notifier).initData();
    ref.watch(globalExpenseLimiterNotifierProvider.notifier).initData();
    await ref.watch(globalUserdataProvider.notifier).initData();

    ///TODO: uncomment
    // Initialize Main Page Data
    // INITDATA_AnalysisPage(context, ref);
    INITDATA_HomePage(context, ref);
    // INITDATA_WalletPage(context, ref);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'KeuanganKu Pro',
      home: kFutureBuilder<void>(
        futureFunction: initData(context, ref),
        wxWhenError: (err) => AppError(error: err.toString()),
        wxWhenSuccess: (_) {
          final userData = ref.watch(globalUserdataProvider);
          if (userData.invalid){
            return const IntroPage();
          } else {
            return const KeuanganKuPro();
          }
        },
        wxWhenWaiting: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      theme: light_theme,
    );
  }
}
