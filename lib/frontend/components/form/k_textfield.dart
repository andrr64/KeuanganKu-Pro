import 'package:flutter/material.dart';

Widget kTextField(
  {
    required String title,
    Icon? icon,
    bool Function(String)? validator,
    void Function (String val)? onChange,
    void Function()? successCallback,
    void Function()? failCallback
  }){
  return TextFormField(
    decoration: InputDecoration(
      label: Text(title),
      prefixIcon: icon,
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black87, width: 2)
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45, width: 2)
      )
    ),
    onChanged: (val){
      if (onChange != null){
        onChange(val);
      }
    },
  );
}