import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';

Widget k_button(BuildContext context, void Function() onPressed, {bool withoutBg = false, IconData? icon, String? text, Color? mainColor, Color? iconColor}){

  List<Widget> isWithIcon(){
    if (icon != null){
      return [ Container(
        decoration: BoxDecoration(
            color: (withoutBg? Colors.transparent : iconColor),
            borderRadius: const BorderRadius.all(Radius.circular(5))
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Icon(icon, color: withoutBg? Colors.white : mainColor,),
        ),
      ), withoutBg? Container() : dummyWidth(5)];
    } else {
      return [Container()];
    }
  }

  Widget isWithText(){
    if (text != null){
      return kText(context, text, KTStyle.title, KTSType.small, color: Colors.white);
    }
    return Container();
  }

  return FilledButton(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      backgroundColor: mainColor,
    ), 
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...isWithIcon(),
        isWithText()
      ],
    )
  );
}