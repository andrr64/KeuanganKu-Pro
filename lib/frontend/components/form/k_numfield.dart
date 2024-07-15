import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget kNumField({
  required String title,
  Icon? icon,
  bool Function(String)? validator,
  void Function (String val)? onChange,
  void Function()? successCallback,
  void Function()? failCallback
}) {
  return TextFormField(
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        label: Text(title),
        prefixIcon: icon,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 2)
        ),
        enabledBorder: OutlineInputBorder(
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