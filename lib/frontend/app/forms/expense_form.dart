import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/components/alerts/quickalert.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/form/k_numfield.dart';
import 'package:keuanganku/frontend/components/form/k_textfield.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/datetime_format.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(DBModelExpense) callbackWhenDataSaved;
  final List<DBModelExpenseCategory> expenseCategories;
  final List<DBModelWallet> wallets;

  const ExpenseForm(
      {super.key,
      required this.callbackWhenDataSaved,
      required this.expenseCategories,
      required this.wallets});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController titleController;
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  late DBModelExpenseCategory categoryController;

  late DBModelWallet walletController;
  late DateTime dateController;
  late TextEditingController dateTextController;

  late TimeOfDay timeController;
  late TextEditingController timeTextController;


  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    amountController = TextEditingController();
    dateTextController = TextEditingController();
    descriptionController = TextEditingController();
    timeTextController = TextEditingController();
    walletController = widget.wallets[0];
    categoryController = widget.expenseCategories[0];
    whenDatePicked(DateTime.now());
    whenTimePicked(TimeOfDay.fromDateTime(dateController));
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    dateTextController.dispose();
    descriptionController.dispose();
    timeTextController.dispose();
    super.dispose();
  }

  // Events
  void handleSave(BuildContext context) async {
    if(_formKey.currentState!.validate()){
      final newExpense = DBModelExpense(
          title: titleController.text,
          amount: double.parse(amountController.text),
          description: titleController.text,
          wallet_id: walletController.id,
          category_id: categoryController.id,
          rate: 0,
          datetime: combineDateTimeAndTimeOfDay(dateController, timeController)
      );
      newExpense.insert().then((_){
        widget.callbackWhenDataSaved(newExpense); // update local.wallet total_expense
        alertSuccess(context: context).then((_) => closePage(context));
      });
    }
  }

  void handleClear() {
    titleController.clear();
    amountController.clear();
    descriptionController.clear();
    whenDatePicked(DateTime.now());
    whenTimePicked(TimeOfDay.fromDateTime(dateController));
  }

  void whenDatePicked(DateTime date) {
    dateController = date;
    dateTextController.text = dateFormat(date, 'dd/M/yyyy');
  }

  void whenTimePicked(TimeOfDay time) {
    timeController = time;
    timeTextController.text = formatTimeOfDay(time, is24HourFormat: true);
  }

  // Components
  List<Widget> fields(BuildContext context) {
    return [
      dummyHeight(22.5),
      kTextField(context, controller: titleController, title: 'Title',
          validator: (value) {
        if (value == null || value.isEmpty) {
          return "Title can't empty";
        }
        return null;
      }, icon: const Icon(Icons.title), maxLines: 1),
      dummyHeight(22.5),
      kNumField(context,
          controller: amountController,
          title: 'Amount',
          icon: const Icon(Icons.attach_money),
          maxVal: walletController.total_income! - walletController.total_expense!),
      dummyHeight(22.5),
      Row(
        children: [
          SizedBox(
            width: vw(context, 60),
            child: kDropdown<DBModelExpenseCategory>(
              context,
              label: 'Category',
              items: widget.expenseCategories,
              itemsAsString: widget.expenseCategories.map((e){
                return e.name!;
              }).toList(),
              value: categoryController,
              onChanged: (e) {
                if (e != null) categoryController = e;
              },
            ),
          ),
          dummyWidth(vw(context, 2.5)),
          k_button(context, () {}, text: 'Add', icon: Icons.add_box)
        ],
      ),
      dummyHeight(22.5),
      kDropdown<DBModelWallet>(
        context,
        label: 'Wallets',
        items: widget.wallets,
        itemsAsString: widget.wallets.map((e){
          return e.name!;
        }).toList(),
        value: walletController,
        onChanged: (e) {
          if (e != null) walletController = e;
        },
      ),
      dummyHeight(22.5),
      kTextField(context,
          title: 'Description (optional)',
          controller: descriptionController,
          icon: const Icon(Icons.description),
          maxLines: 2),
      dummyHeight(22.5),
      Row(
        children: [
          SizedBox(
            width: vw(context, 37.5),
            child: kTextField(context,
                title: 'Date',
                icon: const Icon(Icons.date_range),
                disable: true,
                controller: dateTextController, onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: dateController,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now())
                  .then((value) {
                if (value != null) whenDatePicked(value);
              });
            }),
          ),
          dummyWidth(vw(context, 2.5)),
          SizedBox(
            width: vw(context, 30),
            child: kTextField(context,
                title: 'Time',
                icon: const Icon(Icons.access_time_sharp),
                disable: true,
                controller: timeTextController, onTap: () {
              showTimePicker(context: context, initialTime: timeController)
                  .then((val) {
                if (val != null) whenTimePicked(val);
              });
            }),
          ),
        ],
      ),
      dummyHeight(22.5),
    ];
  }

  Widget form(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kText(context, 'Expense', KTStyle.title, KTSType.large),
          kText(context, 'Insert new expense data.', KTStyle.label,
              KTSType.medium),
          ...fields(context),
          Row(
            children: [
              k_button(context, text: 'Save', () => handleSave(context)),
              dummyWidth(10),
              k_button(
                  context,
                  mainColor: BaseColor.old_red.color,
                  text: 'Clear',
                  handleClear)
            ],
          )
        ],
      ),
    );
  }

  // Frontend
  Widget content(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: kText(context, 'Form', KTStyle.title, KTSType.medium),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(
          vertical: vh(context, 2.5),
          horizontal: vw(context, 5),
        ),
        child: form(context),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return content(context);
  }
}
