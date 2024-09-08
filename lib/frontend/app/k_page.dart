import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';

Widget KPage(BuildContext context, {
  required String title,
  required Widget child
}){
  return Scaffold(
    appBar: AppBar(
      title: kText(context, title, KTStyle.title, KTSType.medium),
      backgroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          vertical: vh(context, 2.5),
          horizontal: vw(context, 5),
        ),
        child: child,
      ),
  );
}