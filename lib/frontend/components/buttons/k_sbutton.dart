import 'package:flutter/material.dart';

kSimpleButton(BuildContext context, {
  required String text,
  required void Function() onPressed,
  Color? fontColor
}) {
  TextStyle? tStyle = Theme.of(context).textTheme.labelMedium;

  return FilledButton(
      onPressed: onPressed,
      style: Theme.of(context).filledButtonTheme.style,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: tStyle!.fontFamily,
          fontWeight: tStyle.fontWeight,
          fontSize: tStyle.fontSize,
          color: fontColor
        ),
      )
  );
}