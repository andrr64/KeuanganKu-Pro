import 'package:flutter/material.dart';

Widget kDropdown<T>(BuildContext context,
    {required List<T> items,
    required List<String> itemsAsString,
    required T? value,
    required ValueChanged<T?> onChanged,
    required label,
    double borderWidth = 1.0,
    Color? foregroundColor,
    Color borderColor = Colors.black54,
    Color? backgroundColor,
    bool? withoutBorder,
    Color? dropdownTextColor}) {
  TextStyle? tStyle = Theme.of(context).textTheme.bodyMedium;

  List<DropdownMenuItem<T>> dropdownItems =
      List.generate(items.length, (index) {
    return DropdownMenuItem<T>(
      value: items[index],
      child: Text(
        itemsAsString[index],
        style: TextStyle(
            fontFamily: tStyle!.fontFamily,
            fontSize: tStyle.fontSize,
            fontWeight: tStyle.fontWeight,
            color: dropdownTextColor),
      ),
    );
  });

  return DropdownButtonFormField<T>(
      items: dropdownItems,
      decoration: InputDecoration(
        filled: backgroundColor != null,
        fillColor: backgroundColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: withoutBorder == true
              ? BorderSide.none
              : BorderSide(
                  width: borderWidth,
                  color: borderColor, // Warna border saat fokus
                ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: withoutBorder == true
              ? BorderSide.none
              : BorderSide(
                  width: borderWidth,
                  color: borderColor, // Warna border saat fokus
                ),
        ),
        label: Text(
          label,
          style: TextStyle(
              fontFamily: tStyle!.fontFamily,
              fontWeight: tStyle.fontWeight,
              fontSize: tStyle.fontSize,
              color: foregroundColor),
        ),
      ),
      value: value,
      iconEnabledColor: foregroundColor,
      onChanged: onChanged,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      dropdownColor: backgroundColor);
}
