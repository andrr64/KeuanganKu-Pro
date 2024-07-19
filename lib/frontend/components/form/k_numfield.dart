import 'package:flutter/material.dart';

Widget kNumField(BuildContext context, {
  required String title,
  required TextEditingController controller,
  Icon? icon,
  bool Function(String)? validator,
  void Function (String val)? onChange,
  void Function()? successCallback,
  void Function()? failCallback
}) {
  TextStyle? tStyle =  Theme.of(context).textTheme.displaySmall;
  return TextFormField(
    keyboardType: TextInputType.number,
    controller: controller,
    decoration: InputDecoration(
        label: Text(title, style: TextStyle(
            fontFamily: tStyle!.fontFamily,
            fontWeight: tStyle.fontWeight,
            fontSize: tStyle.fontSize
        )),
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