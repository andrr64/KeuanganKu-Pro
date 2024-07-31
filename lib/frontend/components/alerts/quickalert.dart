import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

Future<void> alertSuccess({required BuildContext context, String? title, String? text}) async {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    title: title ?? 'Success',
    text: text ?? 'Operation was successful.',
  );
}

Future<void> alertFailed({required BuildContext context, String? title, String? text}) async {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: title ?? 'Error',
    text: text ?? 'Something went wrong.',
  );
}