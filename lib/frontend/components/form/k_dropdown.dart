import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/colors/k_color.dart';

Widget kDropdown<T>(
  BuildContext context, {
  required List<T> items,
  required List<String> itemsAsString,
  required T? value,
  required ValueChanged<T?> onChanged,
      required label,
}) {
  TextStyle? tStyle = Theme.of(context).textTheme.bodyMedium;

  List<DropdownMenuItem<T>> dropdownItems = List.generate(items.length, (index) {
    return DropdownMenuItem<T>(
      value: items[index],
      child: Text(
        itemsAsString[index],
        style: TextStyle(
          fontFamily: tStyle!.fontFamily,
          fontSize: tStyle.fontSize,
          fontWeight: tStyle.fontWeight,
        ),
      ),
    );
  });

  return DropdownButtonFormField<T>(
    items: dropdownItems,
    decoration: InputDecoration(
        label: Text(
          label,
          style: TextStyle(
              fontFamily: tStyle!.fontFamily,
              fontWeight: tStyle.fontWeight,
              fontSize: tStyle.fontSize),
        ),
    ),
    value: value,
    onChanged: onChanged,
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    dropdownColor: BackgroundColor.white.color
  );
}
