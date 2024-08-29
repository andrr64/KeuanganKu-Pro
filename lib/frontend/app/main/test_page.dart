import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TestPage extends HookConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void test()async {

    }

    return Center(
      child: ElevatedButton(onPressed: test, child: const Text('Test'),),
    );
  }
}
