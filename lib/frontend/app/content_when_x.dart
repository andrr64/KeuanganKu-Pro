import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/colors/font_color.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';

Widget contentWhenError(BuildContext context, Object? error) {
  return Scaffold(
    appBar: AppBar(
      title: kText(context, 'Error', KTStyle.title, KTSType.medium),
    ),
    body: Center(
      child: SizedBox(
        width: vw(context, 80),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.warning, color: Colors.red, size:80,),
            kText(context,align: TextAlign.center, 'Something wrong...', KTStyle.title, KTSType.large),
            kText(context,align: TextAlign.center, '$error', KTStyle.body, KTSType.medium, overflow: TextOverflow.visible),
          ],
        ),
      )
    )
  );
}

Widget contentWhenWaiting(BuildContext context) {
  return const Scaffold(
    body: Center(
      child: CircularProgressIndicator(
        color: fontColor_black,
      ),
    ),
  );
}
