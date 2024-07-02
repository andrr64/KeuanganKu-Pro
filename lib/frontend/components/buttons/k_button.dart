import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';

Widget k_button(BuildContext context, void Function() onPressed, {IconData? icon, String? text, Color? mainColor, Color? iconColor}){
  return FilledButton(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      backgroundColor: mainColor,
    ), 
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: const BorderRadius.all(Radius.circular(5))
          ),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Icon(icon, color: mainColor,),
          ),
        ),
        dummyWidth(5),
        Text(text?? 'Button', style: Theme.of(context).textTheme.titleSmall,)
      ],
    )
  );
}