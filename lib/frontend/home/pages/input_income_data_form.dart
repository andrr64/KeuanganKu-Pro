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

  Widget form(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kText(context, 'Income', KTStyle.title, KTSType.large),
            kText(context, 'Insert new income data', KTStyle.label, KTSType.medium),
            dummyHeight(22.5),
            kTextField(title: 'Title', icon: const Icon(Icons.title)),
            dummyHeight(22.5),
            kNumField(title: 'Amount', icon: const Icon(Icons.attach_money)),
            dummyHeight(22.5),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Column(
                      children: [Text('Save', style: TextStyle(color: Colors.white),)],
                    )),
                dummyWidth(10),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Column(
                      children: [Text('Clear', style: TextStyle(color: Colors.white),)],
                    ))
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              kText(context, 'Form', KTStyle.title, KTSType.medium),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: vh(context, 2.5), horizontal: vw(context, 5)),
              child: form(context)),
        ));
  }
}
