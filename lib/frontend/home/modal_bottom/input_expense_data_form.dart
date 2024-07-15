import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';

class InputExpenseDataForm extends StatefulWidget {
  const InputExpenseDataForm({super.key});

  @override
  State<InputExpenseDataForm> createState() => _InputExpenseDataFormState();
}

class _InputExpenseDataFormState extends State<InputExpenseDataForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: KText(context, 'New Expense', KTextStyle.title, KTextStyleType.medium)
      ),
    );
  }
}
