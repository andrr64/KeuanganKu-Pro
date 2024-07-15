import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';

class InputIncomeDataForm extends StatefulWidget {
  const InputIncomeDataForm({super.key});

  @override
  State<InputIncomeDataForm> createState() => _InputIncomeDataFormState();
}

class _InputIncomeDataFormState extends State<InputIncomeDataForm> {
  Widget header(BuildContext context) {
    return Row(

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: KText(context, 'New Income', KTextStyle.title, KTextStyleType.medium),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: vh(context, 2.5), horizontal: vw(context, 5)),
        child: Column(
          children: [
            header(context),
          ],
        ),
      ),
    );
  }
}
