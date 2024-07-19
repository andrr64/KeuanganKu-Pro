import 'package:flutter/material.dart';

Widget kDropdown<T>(
  BuildContext context, {
  required List<T> items,
  required T? value,
  required ValueChanged<T?> onChanged,
}) {
  TextStyle? tStyle = Theme.of(context).textTheme.displaySmall;

  List<DropdownMenuItem<T>> dropdownItems = items.map((T item) {
    return DropdownMenuItem<T>(
      value: item,
      child: Text(
        item.toString(),
        style: TextStyle(
            fontFamily: tStyle!.fontFamily,
            fontSize: tStyle.fontSize,
            fontWeight: tStyle.fontWeight),
      ), // You can customize the display of each item here
    );
  }).toList();

  return DropdownButtonFormField<T>(
    items: dropdownItems,
    decoration: InputDecoration(
        label: Text(
          'Category',
          style: TextStyle(
              fontFamily: tStyle!.fontFamily,
              fontWeight: tStyle.fontWeight,
              fontSize: tStyle.fontSize),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45, width: 2))),
    value: value,
    onChanged: onChanged,
  );
}
