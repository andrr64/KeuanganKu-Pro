import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/backend/database/helper/expense.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/app/expense_category_provider.dart';
import 'package:keuanganku/frontend/app/main/analysis/analysis_provider.dart';

class TestPage extends HookConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseCategoriesNotifier = ref.watch(globalExpenseCategoriesProvider.notifier);

    void test()async {

    }

    return Center(
      child: ElevatedButton(onPressed: test, child: const Text('Test'),),
    );
  }
}
