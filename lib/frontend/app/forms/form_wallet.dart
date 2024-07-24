import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/wallet.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/form/k_numfield.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';
import 'package:keuanganku/main.dart';
import 'package:quickalert/quickalert.dart';

import '../../components/form/k_textfield.dart';

class FormWallet extends StatefulWidget {
  const FormWallet({super.key, required this.callbackWhenDataSaved});

  final void Function() callbackWhenDataSaved;

  @override
  State<FormWallet> createState() => _FormWalletState();
}

class _FormWalletState extends State<FormWallet> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController walletName;
  late TextEditingController initialAmountController;
  late WalletType walletTypeController;

  @override
  void initState() {
    super.initState();
    walletTypeController = WalletType.wallet;
    walletName = TextEditingController();
    initialAmountController = TextEditingController();
    initialAmountController.text = '0';
  }

  @override
  void dispose() {
    walletName.dispose();
    initialAmountController.dispose();
    super.dispose();
  }

  // Events
  void whenButtonSavePressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      try {
        DBModelWallet data = DBModelWallet(
          name: walletName.text,
          type: walletTypeController.type
        );
        DBHelperWallet().save(db: db.database, data: data).then((result){
          if (result){
            QuickAlert.show(context: context, type: QuickAlertType.success, text: 'Data saved successfully').then((_){
              closePage(context);
            });
          } else {
            QuickAlert.show(context: context, type: QuickAlertType.error, text: 'Failed when save data');
          }
        });
      } catch (e){
        QuickAlert.show(context: context, type: QuickAlertType.error, text: '$e');
      }
    }
  }

  void whenButtonClearPressed() {
    walletName.clear();
  }

  // Components
  List<Widget> fields(BuildContext context){
    return [
      dummyHeight(22.5),
      kTextField(context,
          controller: walletName,
          title: 'Title',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Title can't empty";
            }
            return null;
          },
          icon: const Icon(Icons.title),
          maxLines: 1),
      dummyHeight(22.5),
      kNumField( context, icon: const Icon(Icons.attach_money), title: 'Initial Amount', controller: initialAmountController, maxVal: 10000000000),
      dummyHeight(22.5),
      SizedBox(
        width: vw(context, 60),
        child: kDropdown(
            context,
            items: WalletType.values,
            itemsAsString: WalletType.wallet.walletTypeValueAsString(),
            value: walletTypeController,
            onChanged: (val) {
              if (val != null && val != walletTypeController){
                walletTypeController = val;
              }
            }
        ),
      ),
      dummyHeight(22.5),
    ];
  }

  // Frontend
  Widget form(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kText(context, 'Wallet', KTStyle.title, KTSType.large),
          kText(context, 'Insert new wallet data.', KTStyle.label,KTSType.medium),

          ...fields(context),

          Row(
            children: [
              k_button(
                  context, text: 'Save', () => whenButtonSavePressed(context)),
              dummyWidth(10),
              k_button(
                  context,
                  mainColor: BaseColor.old_red.color,
                  text: 'Clear',whenButtonClearPressed)
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: kText(context, 'Form', KTStyle.title, KTSType.medium),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: vh(context, 2.5), horizontal: vw(context, 5)),
        child: form(context),
      ),
    );
  }

}