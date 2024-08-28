import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/form/k_numfield.dart';
import 'package:keuanganku/frontend/components/form/k_textfield.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';
import 'package:quickalert/quickalert.dart';

class WalletForm extends StatefulWidget {
  final void Function(DBModelWallet wallet) callbackWhenDataSaved;

  const WalletForm({super.key, required this.callbackWhenDataSaved});

  @override
  State<StatefulWidget> createState() => _WalletFormState();
}

class _WalletFormState extends State<WalletForm> {
  final _formKey = GlobalKey<FormState>();
  WalletType _walletType = WalletType.wallet;
  late TextEditingController _walletNameController;
  late TextEditingController _initialAmountController;

  @override
  void initState() {
    super.initState();
    _walletNameController = TextEditingController();
    _initialAmountController = TextEditingController();
  }

  @override
  void dispose() {
    _walletNameController.dispose();
    _initialAmountController.dispose();
    super.dispose();
  }

  void handleSave(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final initAmount = double.parse(_initialAmountController.text);
      final newWallet = DBModelWallet(
        name: _walletNameController.text,
        type: _walletType.type,
        total_income: initAmount,
      );
      newWallet.insert().then((_){
        final newIncome = DBModelIncome(
          wallet_id: newWallet.id,
          title: 'Wallet Init',
          amount: initAmount,
          category_id: 1,
          description: 'Wallet Initialization',
          datetime: DateTime.now().toIso8601String()
        );
        newIncome.insert().then((_)async {
          widget.callbackWhenDataSaved(newWallet);
          QuickAlert.show(context: context, type: QuickAlertType.success).then((_) => closePage(context));
        });
      });
    }
  }

  void handleClear() {
    _walletNameController.clear();
    _initialAmountController.clear();
  }

  List<Widget> _buildFormFields(BuildContext context) {
    return [
      dummyHeight(22.5),
      kTextField(
        context,
        controller: _walletNameController,
        title: 'Title',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Title can't be empty";
          }
          return null;
        },
        icon: const Icon(Icons.title),
        maxLines: 1,
      ),
      dummyHeight(22.5),
      kNumField(
        context,
        icon: const Icon(Icons.attach_money),
        title: 'Initial Amount',
        controller: _initialAmountController,
        maxVal: 10000000000,
      ),
      dummyHeight(22.5),
      SizedBox(
        width: vw(context, 60),
        child: kDropdown<WalletType>(
          context,
          label: 'Type',
          items: WalletType.values,
          itemsAsString: WalletType.wallet.walletTypeValueAsString(),
          value: _walletType,
          onChanged: (val) {
            if (val != null && val != _walletType) {
              setState(() {
                _walletType = val;
              });
            }
          },
        ),
      ),
      dummyHeight(22.5),
    ];
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kText(context, 'Wallet', KTStyle.title, KTSType.large),
          kText(context, 'Insert new wallet data.', KTStyle.label,
              KTSType.medium),
          ..._buildFormFields(context),
          Row(
            children: [
              k_button(
                context,
                text: 'Save',
                () => handleSave(context),
              ),
              dummyWidth(10),
              k_button(
                context,
                mainColor: BaseColor.old_red.color,
                text: 'Clear',
                handleClear,
              ),
            ],
          ),
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
        padding: EdgeInsets.symmetric(
            vertical: vh(context, 2.5), horizontal: vw(context, 5)),
        child: _buildForm(context),
      ),
    );
  }
}
