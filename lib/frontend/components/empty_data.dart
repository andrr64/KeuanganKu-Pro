import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/colors/k_color.dart';

class EmptyData extends StatelessWidget {
  final IconData? iconData;
  final Color? iconColor;
  final double? verticalPadding;
  const EmptyData({super.key, this.iconData, this.iconColor, this.verticalPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding?? 64),
      child: Center(
          child: Column(
            children: [
              Icon(iconData?? FluentIcons.checkmark_12_regular, size: 64, color: iconColor?? FontColor.black.color,),
              dummyHeight(5),
              kText(context, 'Empty Data.', KTStyle.label, KTSType.large, color: iconColor?? FontColor.black.color,)
            ],
          )
      ),
    );
  }
}