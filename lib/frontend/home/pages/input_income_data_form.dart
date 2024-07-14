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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KText(context, 'Input Income Data', KTextStyle.title,
            KTextStyleType.medium),
        k_button(
          context,
          () => Navigator.pop(context),
          mainColor: Colors.black87,
          icon: Icons.close,
          withoutBg: true,
          iconColor: Colors.white
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: vw(context, 100),
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: vh(context, 2.5), horizontal: vw(context, 5)),
          child: Column(
            children: [
              header(context),
            ],
          ),
        ));
  }
}
