import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/expense_limiter.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/expense_limiter.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/enum/time_period.dart';
import 'package:keuanganku/frontend/app/k_page.dart';
import 'package:keuanganku/frontend/app/snackbar.dart';
import 'package:keuanganku/frontend/colors/base_color.dart';
import 'package:keuanganku/frontend/components/buttons/k_outlined_button.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/form/k_numfield.dart';
import 'package:keuanganku/frontend/components/spacer/v_space.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
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
  TimePeriod periodController = TimePeriod.month;
  late DBModelWallet walletController;
  late DBModelExpenseCategory expenseCategoryController;
  late List<DBModelWallet> walletDropDown;
  late List<DBModelExpenseCategory> expenseCategoryDropdown;

  @override
  void initState() {
    limitAmountController = TextEditingController();
    expenseCategoryDropdown = List.from(widget.expenseCategories);
    walletDropDown = List.from(widget.wallets);

    walletDropDown.add(DBModelWallet(id: 0, name: 'General'));

    expenseCategoryController = expenseCategoryDropdown[0];
    walletController = walletDropDown[0];
    super.initState();
  }

  @override
  void dispose() {
    limitAmountController.dispose();
    super.dispose();
  }

  void handleSave(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      DBModelExpenseLimiter newLimiter = DBModelExpenseLimiter(
          category: expenseCategoryController,
          wallet_id: walletController.id!,
          limit_amount: double.parse(limitAmountController.text),
          current_amount: 0,
          period_id: periodController.intVal);
      try {
        await DBHelperExpenseLimiter().insert(data: newLimiter);
        widget.callbackWhenDataSaved(newLimiter);
        ScaffoldMessenger.of(context)
            .showSnackBar(successSnackBar('Data successfully saved'));
        closePage(context);
      } catch (e) {
        ///TODO: when failed to save new expense limiter data
      }
    }
  }

  void handleClear() {
    limitAmountController.clear();
  }

  void handlePeriod(TimePeriod? val) {
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
    return [
      vspace_22_5,
      kNumField(context,
          title: 'Limit Amount',
          controller: limitAmountController,
          icon: const Icon(Icons.attach_money),
          maxVal: 10000000000),
      vspace_22_5,
      Row(
        children: [
          Expanded(
            child: kDropdown<DBModelWallet>(
              context,
              label: 'Wallet',
              items: walletDropDown,
              itemsAsString: walletDropDown.map((x) => x.name!).toList(),
              value: walletController,
              onChanged: handleWalletChanged,
            ),
          ),
          dummyWidth(10), // Memberi jarak antara kedua dropdown
          Expanded(
            child: kDropdown<TimePeriod>(
              context,
              label: 'Period',
              items: TimePeriod.values,
              itemsAsString: TimePeriod.values.map((e) => e.label).toList(),
              value: periodController,
              onChanged: handlePeriod,
            ),
          ),
        ],
      ),
      vspace_22_5,
      Row(
        children: [
          Expanded(
            flex: 5,
            child: kDropdown<DBModelExpenseCategory>(context,
                items: widget.expenseCategories,
                itemsAsString:
                    widget.expenseCategories.map((e) => e.name!).toList(),
                value: expenseCategoryController,
                onChanged: (e) =>
                    expenseCategoryController = e ?? expenseCategoryController,
                label: 'Categories to Limit'),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              flex: 2,
              child: KOutlinedButton(
                  onPressed: () {},
                  text: 'Add',
                  icon: const Icon(FluentIcons.add_16_filled)))
        ],
      ),
      vspace_22_5,
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
                    color: baseColor_dark_red,
                    text: 'Clear'),
              ],
            ),
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
