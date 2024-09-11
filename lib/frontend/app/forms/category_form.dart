import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/colors/base_color.dart';
import 'package:keuanganku/frontend/components/buttons/k_outlined_button.dart';
import 'package:keuanganku/frontend/components/form/k_textfield.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/page.dart';

Form categoryForm(GlobalKey<FormState> key, BuildContext context, {
  required TextEditingController controller,
  required void Function() callbackWhenSubmit
}){
  List<Widget> fields(BuildContext context){
    final SPACE = dummyHeight(22.5);
    return [
      SPACE,
      kTextField(context,
          controller: controller,
          title: 'Category Name',
          maxLines: 1,
          validator: (val){
          print('asd');
            if (val == null || val.isEmpty){
              return 'Input a name!';
            }
            return null;
          }
      ),
      SPACE
    ];
  }

  return Form(
      key: key,
      child: Column(
        children: [
          kText(context, 'New Category', KTStyle.title, KTSType.large),
          ...fields(context),
          Row(
            children: [
              KOutlinedButton(
                  onPressed: callbackWhenSubmit,
                  color: const Color(0xff377550),
                  text: 'Save'),
              dummyWidth(10),
              KOutlinedButton(
                  onPressed: () => closePage(context),
                  color: baseColor_dark_red,
                  text: 'Cancel'),
            ],
          )
        ],
      )
  );
}