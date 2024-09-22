import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/userdata.dart';
import 'package:keuanganku/backend/database/model/userdata.dart';
import 'package:keuanganku/enum/locale.dart';
import 'package:keuanganku/frontend/components/buttons/k_outlined_button.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/form/k_textfield.dart';
import 'package:keuanganku/frontend/components/spacer/v_space.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';

class UserdataForm extends StatefulWidget {
  const UserdataForm({super.key, required this.callback});
  final void Function() callback;

  @override
  State<UserdataForm> createState() => _UserdataFormState();
}

class _UserdataFormState extends State<UserdataForm> {

  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  CurrencyLocale localeController = CurrencyLocale.unitedStates;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void whenButtonNextPressed() async{
    if (formKey.currentState!.validate()){
      DBModelUserdata userdata = DBModelUserdata(id: 1, name: nameController.text, locale: localeController.idLocale);
      bool updated = await DBHelperUserdata().update(data: userdata);
      if (updated){
        widget.callback();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
            key: formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kText(context, 'Let me know about you.', KTStyle.title, KTSType.large),
            vspace_20,
            kTextField(
                context,
                title: 'How i should call you?',
                controller: nameController,
                icon: const Icon(Icons.account_circle),
                validator: (e){
                  if (e!.isEmpty){
                    return 'Can\'t empty';
                  }
                  return null;
                }
            ),
            vspace_20,
            kDropdown<CurrencyLocale>(
                context,
                items: CurrencyLocale.values,
                itemsAsString: CurrencyLocale.values.first.listOfCountryAndCurrencyCode,
                value: localeController,
                onChanged: (e){
                  if (e != null){
                    localeController = e;
                  }
                },
                label: 'What currency do you use?'
            ),
            vspace_20,
            Center(child: KOutlinedButton(onPressed: whenButtonNextPressed, text: 'Next'),),
          ],
        )),
      ),
    );
  }
}
