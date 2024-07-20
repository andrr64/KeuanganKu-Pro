import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/buttons/k_sbutton.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
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

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  List<String> kategori = ['Bensin', 'Makan dan Minum'];

  List<Widget> fields(BuildContext context) {
    return [
      dummyHeight(22.5),
      kTextField(
          context,
          controller: titleController,
          title: 'Title',
          icon: const Icon(Icons.title)),
      dummyHeight(22.5),
      kNumField(
          context,
          controller: amountController,
          title: 'Amount',
          icon: const Icon(Icons.attach_money)),
      dummyHeight(22.5),
      SizedBox(
        width: vw(context, 75),
        child: kDropdown<String>(context,
            items: kategori, value: kategori[0], onChanged: (e) {}),
      ),
      dummyHeight(22.5),
    ];
  }

  List<Widget> formInfo(BuildContext context) {
    return [
      kText(context, 'Income', KTStyle.title, KTSType.large),
      kText(context, 'Insert new income data.', KTStyle.label, KTSType.medium),
    ];
  }

  Row buttons(BuildContext context) {
    return Row(
      children: [
        kSimpleButton(context, text: 'Save', onPressed: () {}),
        dummyWidth(10),
        kSimpleButton(context, text: 'Clear', onPressed: () {})
      ],
    );
  }

  Widget form(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...formInfo(context),
            ...fields(context),
            buttons(context)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: kText(context, 'Form', KTStyle.title, KTSType.medium),
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
