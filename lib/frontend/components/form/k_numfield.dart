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
  required double maxVal
}) {
  TextStyle? tStyle = Theme.of(context).textTheme.bodyMedium;
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
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
      ),
    ),
    onChanged: (val) {
      if (onChange != null) {
        onChange(val);
      }
    },
  );
}
