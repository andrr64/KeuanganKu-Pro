import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/themes/light_theme.dart';

enum KTStyle {
  display, body, label, title
}

enum KTSType {
  small, medium, large
}

TextStyle getTextStyle(BuildContext context, KTStyle style, KTSType type, Color color, {
  FontWeight? fontWeight
}){
  TextStyle? textStyle;
  switch (style) {
    case KTStyle.display:
      switch (type) {
        case KTSType.small:
          textStyle = Theme.of(context).textTheme.displaySmall;
          break;
        case KTSType.medium:
          textStyle = Theme.of(context).textTheme.displayMedium;
          break;
        case KTSType.large:
          textStyle = Theme.of(context).textTheme.displayLarge;
          break;
      }
      break;
    case KTStyle.body:
      switch (type) {
        case KTSType.small:
          textStyle = Theme.of(context).textTheme.bodySmall;
          break;
        case KTSType.medium:
          textStyle = Theme.of(context).textTheme.bodyMedium;
          break;
        case KTSType.large:
          textStyle = Theme.of(context).textTheme.bodyLarge;
          break;
      }
      break;
    case KTStyle.label:
      switch (type) {
        case KTSType.small:
          textStyle = Theme.of(context).textTheme.labelSmall;
          break;
        case KTSType.medium:
          textStyle = Theme.of(context).textTheme.labelMedium;
          break;
        case KTSType.large:
          textStyle = Theme.of(context).textTheme.labelLarge;
          break;
      }
      break;
    case KTStyle.title:
      switch (type) {
        case KTSType.small:
          textStyle = Theme.of(context).textTheme.titleSmall;
          break;
        case KTSType.medium:
          textStyle = Theme.of(context).textTheme.titleMedium;
          break;
        case KTSType.large:
          textStyle = Theme.of(context).textTheme.titleLarge;
          break;
      }
      break;
  }

  return TextStyle(
    fontSize: textStyle!.fontSize,
    fontFamily: textStyle.fontFamily,
    fontWeight: fontWeight?? textStyle.fontWeight,
    color: color
  );
}

Text kText(BuildContext context, String text, KTStyle style, KTSType type, {
  Color color = BLACK_FONT_COLOR,
  TextAlign? align,
  FontWeight? fontWeight
}){
  return Text(text, style: getTextStyle(context, style, type, color, fontWeight: fontWeight), textAlign: align,);
}