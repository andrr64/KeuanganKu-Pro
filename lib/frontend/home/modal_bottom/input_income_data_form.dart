import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/form/k_numfield.dart';
import 'package:keuanganku/frontend/components/form/k_textfield.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';

class InputIncomeDataForm extends StatefulWidget {
  const InputIncomeDataForm({super.key});

  @override
  State<InputIncomeDataForm> createState() => _InputIncomeDataFormState();
}

class _InputIncomeDataFormState extends State<InputIncomeDataForm> {
  final _formKey = GlobalKey<FormState>();
  String title = '';

  Widget form(BuildContext context){
    return Form(
        key: _formKey,
        child: Column(
          children: [
            kTextField (title: 'Title', icon: const Icon(Icons.title)),
            dummyHeight(22.5),
            kNumField(title: 'Amount', icon: const Icon(Icons.attach_money))
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: KText(context, 'Form', KTextStyle.title, KTextStyleType.medium),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: vh(context, 2.5), horizontal: vw(context, 5)),
            child: form(context)
        ),
      )
    );
  }
}
