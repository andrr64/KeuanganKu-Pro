import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';

List<Widget> kContainerHeading(BuildContext context, List<String> text) {
  return [
    kText(context, text[0], KTStyle.title, KTSType.large,
        fontWeight: FontWeight.w500, color: Colors.white),
    kText(context, text[1], KTStyle.label, KTSType.medium,
        color: Colors.white, fontWeight: FontWeight.w400)
  ];
}

Widget KContainer(BuildContext context,
    {required Widget child, Color backgroundColor = Colors.white}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        child,
      ],
    ),
  );
}
