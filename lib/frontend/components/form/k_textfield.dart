import 'package:flutter/material.dart';

Widget kTextField(BuildContext context,
    {required String title,
      TextEditingController? controller,
      Icon? icon,
      String? Function(String?)? validator,
      int? maxLines,
      bool disable = false,
      void Function(String val)? onChange,
      void Function()? successCallback,
      void Function()? onTap,
      void Function()? failCallback}) {
  TextStyle? tStyle = Theme.of(context).textTheme.displaySmall;

  return TextFormField(
    controller: controller,
    readOnly: disable,
    maxLines: maxLines,
    onTap: onTap,
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
    validator: (val) {
      if (validator != null) {
        String? validationResult = validator(val);
        if (validationResult != null) {
          if (failCallback != null) {
            failCallback();
          }
          return validationResult;
        } else {
          if (successCallback != null) {
            successCallback();
          }
        }
      }
      return null;
    },
    onChanged: (val) {
      if (onChange != null) {
        onChange(val);
      }
    },
  );
}
