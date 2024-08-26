import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

class EmptyData extends StatelessWidget {
  final IconData? iconData;
  const EmptyData({super.key, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Center(
          child: Column(
            children: [
              Icon(iconData?? Icons.sentiment_satisfied, size: 64, color: FontColor.black.color,),
              dummyHeight(5),
              kText(context, 'Empty Data.', KTStyle.label, KTSType.large)
            ],
          )
      ),
    );
  }
}