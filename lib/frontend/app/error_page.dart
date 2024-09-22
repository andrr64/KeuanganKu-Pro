import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/themes/light_theme.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.error});
  final Object error;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: kText(context, 'Error', KTStyle.title, KTSType.medium),
          ),
          body: Center(
              child: SizedBox(
                width: vw(context, 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning,
                      color: Colors.red,
                      size: 80,
                    ),
                    kText(
                        context,
                        align: TextAlign.center,
                        'Something wrong...',
                        KTStyle.title,
                        KTSType.large),
                    kText(
                        context,
                        align: TextAlign.center,
                        '$error',
                        KTStyle.body,
                        KTSType.medium,
                        overflow: TextOverflow.visible),
                  ],
                ),
              ))),
      theme: light_theme,
    );
  }
}
