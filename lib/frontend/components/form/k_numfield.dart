import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _formatted = NumberFormat("#,###");

Widget kNumField(
  BuildContext context, {
  required String title,
  required TextEditingController controller,
  Icon? icon,
  bool Function(String)? validator,
  void Function(String val)? onChange,
  void Function()? successCallback,
  void Function()? failCallback,
  double minVal = 0,
  double? maxVal,
}) {
  TextStyle? tStyle = Theme.of(context).textTheme.displaySmall;
  String maxValue = _formatted.format((maxVal));
  return TextFormField(
    keyboardType: TextInputType.number,
    controller: controller,
    validator: (val){
      if  (maxVal != null){
        try {
          double value = double.parse(val!);
          if (value > maxVal) return 'Maximum value is $maxValue';
        } catch(e){
          return 'Input an number!';
        }
      }
      return null;
    },
    decoration: InputDecoration(
      label: Text(
        title,
        style: TextStyle(
            fontFamily: tStyle!.fontFamily,
            fontWeight: tStyle.fontWeight,
            fontSize: tStyle.fontSize),
      ),
      prefixIcon: icon,
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87, width: 2)),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 2)),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2)),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2)),
    ),
    onChanged: (val) {
      if (onChange != null) {
        onChange(val);
      }
    },
  );
}
