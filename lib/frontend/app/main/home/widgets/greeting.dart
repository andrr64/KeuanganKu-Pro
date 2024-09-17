import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/colors/font_color.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key, required this.userName});

  final String userName;
  ///TODO: add requirements attribute

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CircleAvatar(),
        dummyWidth(22.5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, $userName',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: fontColor_black),
            ),
            kText(context, 'Welcome back!', KTStyle.title, KTSType.small,
                fontWeight: FontWeight.normal, color: fontColor_grey),
          ],
        ),
      ],
    );
  }
}
