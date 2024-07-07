import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum KTextStyle {
  display, body, label, title
}

enum KTextStyleType {
  small, medium, large
}

Text KText(BuildContext context, String text, KTextStyle style, KTextStyleType type) {
  TextStyle? textStyle;

  switch (style) {
    case KTextStyle.display:
      switch (type) {
        case KTextStyleType.small:
          textStyle = Theme.of(context).textTheme.displaySmall;
          break;
        case KTextStyleType.medium:
          textStyle = Theme.of(context).textTheme.displayMedium;
          break;
        case KTextStyleType.large:
          textStyle = Theme.of(context).textTheme.displayLarge;
          break;
      }
      break;
    case KTextStyle.body:
      switch (type) {
        case KTextStyleType.small:
          textStyle = Theme.of(context).textTheme.bodySmall;
          break;
        case KTextStyleType.medium:
          textStyle = Theme.of(context).textTheme.bodyMedium;
          break;
        case KTextStyleType.large:
          textStyle = Theme.of(context).textTheme.bodyLarge;
          break;
      }
      break;
    case KTextStyle.label:
      switch (type) {
        case KTextStyleType.small:
          textStyle = Theme.of(context).textTheme.labelSmall;
          break;
        case KTextStyleType.medium:
          textStyle = Theme.of(context).textTheme.labelMedium;
          break;
        case KTextStyleType.large:
          textStyle = Theme.of(context).textTheme.labelLarge;
          break;
      }
      break;
    case KTextStyle.title:
      switch (type) {
        case KTextStyleType.small:
          textStyle = Theme.of(context).textTheme.titleSmall;
          break;
        case KTextStyleType.medium:
          textStyle = Theme.of(context).textTheme.titleMedium;
          break;
        case KTextStyleType.large:
          textStyle = Theme.of(context).textTheme.titleLarge;
          break;
      }
      break;
  }
  return Text(text, style: textStyle);
}
