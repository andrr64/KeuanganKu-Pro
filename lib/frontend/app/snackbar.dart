import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, SnackBar snackbar){
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

SnackBar successSnackBar(String message) {
  return SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
  );
}

SnackBar warningSnackBar(String message) {
  return SnackBar(
    content: Text(message),
    backgroundColor: Colors.orange,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
  );
}

SnackBar errorSnackBar(String message) {
  return SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 3),
  );
}