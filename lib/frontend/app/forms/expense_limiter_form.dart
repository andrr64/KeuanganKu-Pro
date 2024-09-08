import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/expense_limiter.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/expense_limiter.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/enum/date_range.dart';
import 'package:keuanganku/frontend/app/k_page.dart';
import 'package:keuanganku/frontend/app/snackbar';
import 'package:keuanganku/frontend/colors/k_color.dart';
import 'package:keuanganku/frontend/components/buttons/kbutton_outlined.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/form/k_numfield.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class ExpenseLimiterForm extends StatefulWidget {
  const ExpenseLimiterForm(
      {super.key,
      required this.expenseCategories,
      required this.wallets,
      required this.callbackWhenDataSaved});

  final List<DBModelExpenseCategory> expenseCategories;
  final List<DBModelWallet> wallets;
  final void Function(DBModelExpenseLimiter) callbackWhenDataSaved;

  @override
  State<ExpenseLimiterForm> createState() => _ExpenseLimiterFormState();
}

class _ExpenseLimiterFormState extends State<ExpenseLimiterForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController limitAmountController;
  DateRange periodController = DateRange.month;
  late DBModelWallet walletController;
  late DBModelExpenseCategory expenseCategoryController;
  late List<DBModelWallet> walletDropDown;

  @override
  void initState() {
    limitAmountController = TextEditingController();
    walletDropDown = List.from(widget.wallets);
    walletDropDown.add(DBModelWallet(id: 0, name: 'General'));
    expenseCategoryController = widget.expenseCategories[0];
    walletController = walletDropDown[0];
    super.initState();
  }

  @override
  void dispose() {
    limitAmountController.dispose();
    super.dispose();
  }

  void handleSave(BuildContext context) async{
    if (_formKey.currentState!.validate()) {
      DBModelExpenseLimiter newLimiter = DBModelExpenseLimiter(
        category: expenseCategoryController,
        wallet_id: walletController.id!,
        limit_amount: double.parse(limitAmountController.text),
        current_amount: 0,
        period_id: periodController.intVal
      );
      try {
        await DBHelperExpenseLimiter().insert(data: newLimiter);
        widget.callbackWhenDataSaved(newLimiter);
        ScaffoldMessenger.of(context).showSnackBar(
          successSnackBar('Data successfully saved')
        );
        closePage(context);
      } catch (e){
        ///TODO: when failed to save new expense limiter data
      }
    }
  }

  void handleClear() {
    /// TODO: handle clear
  }
  void handlePeriod(DateRange? val) {
    if (val != null) {
      if (val != periodController) {
        periodController = val;
      }
    }
  }

  void handleWalletChanged(DBModelWallet? val) {
    if (val != null) {
      if (val != walletController) {
        walletController = val;
      }
    }
  }

  List<Widget> fields(BuildContext context) {
    final SPACE = dummyHeight(22.5);
    return [
      SPACE,
      kNumField(context,
          title: 'Limit Amount',
          controller: limitAmountController,
          icon: const Icon(Icons.attach_money),
          maxVal: 10000000000),
      SPACE,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: vw(context, 35),
            child: kDropdown<DateRange>(context,
                items: DateRange.values,
                itemsAsString:
                    DateRange.values.map((x) => x.dropdownString).toList(),
                value: periodController,
                onChanged: handlePeriod,
                label: 'Period'),
          ),
          SizedBox(
            width: vw(context, 50),
            child: kDropdown<DBModelWallet>(context,
                label: 'Wallet',
                items: walletDropDown,
                itemsAsString: walletDropDown.map((x) => x.name!).toList(),
                value: walletController,
                onChanged: handleWalletChanged,
              ),
          ),
        ],
      ),
      SPACE,
    ];
  }

  Widget form(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kText(context, 'Expense Limiter', KTStyle.title, KTSType.large),
            kText(context, 'Insert new expense limiter data.', KTStyle.label,
                KTSType.medium),
            ...fields(context),
            Row(
              children: [
                KOutlinedButton(
                    onPressed: () => handleSave(context),
                    color: const Color(0xff377550),
                    text: 'Save'),
                dummyWidth(10),
                KOutlinedButton(
                    onPressed: handleClear,
                    color: BaseColor.old_red.color,
                    text: 'Clear'),
              ],
            )
          ],
        ));
  }

  Widget content(BuildContext context) {
    return KPage(context, title: 'Add Expense Limiter', child: form(context));
  }

  @override
  Widget build(BuildContext context) {
    return content(context);
  }
}
