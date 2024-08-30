import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/colors/k_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class EmptyWalletWarning extends StatefulWidget {
  const EmptyWalletWarning({super.key});

  @override
  State<EmptyWalletWarning> createState() => _EmptyWalletWarningState();
}

class _EmptyWalletWarningState extends State<EmptyWalletWarning> {
  List<Color> colors = generate3Color(BaseColor.old_red.color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kText(context, 'Wallet is Empty', KTStyle.title, KTSType.large),
            kText(context, 'Add wallet first', KTStyle.label, KTSType.medium),
            dummyHeight(5),
          ],
        ),
      ),
      bottomNavigationBar: OverflowBar(
        alignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black87
            ),
            onPressed: () => closePage(context), 
            child: const Text('Back')
          )
        ],
      ),
    );
  }
}