import 'package:flutter/material.dart';

class KDropdownItem<T> {
  final Map<String, T> item;
  KDropdownItem(this.item);

  List<DropdownMenuItem<T>> getDropdownMenuItems() {
    return this.item.entries.map((entry) {
      return DropdownMenuItem<T>(
        value: entry.value,
        child: Text(entry.key),
      );
    }).toList();
  }

  List<DropdownMenuEntry<T>> getDropdownMenuEntries() {
    return this.item.entries.map((data) {
      return DropdownMenuEntry<T>(value: data.value, label: data.key);
    }).toList();
  }
}

class KDropdown<T> {
  final KDropdownItem<T> data;
  KDropdown(this.data);

  Widget dropdownButton(T value, void Function(T?) callback,
      {required IconThemeData icon_theme,
      required Color dropdown_bg_color,
      TextStyle? text_style}) {
    return DropdownButton(
        value: value,
        icon: Icon(
          Icons.arrow_drop_down_rounded,
          size: icon_theme.size,
          color: icon_theme.color,
        ),
        style: text_style,
        dropdownColor: dropdown_bg_color,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        items: this.data.getDropdownMenuItems(),
        onChanged: callback);
  }
}
