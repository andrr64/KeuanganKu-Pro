import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

void showSuccess({required BuildContext context, String? title, String? text}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    title: title ?? 'Success',
    text: text ?? 'Operation was successful.',
  );
}

void showFailed({required BuildContext context, String? title, String? text}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: title ?? 'Error',
    text: text ?? 'Something went wrong.',
  );
}