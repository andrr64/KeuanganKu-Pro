import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/helper/income.dart';
import 'package:keuanganku/backend/database/model/income.dart';
import 'package:keuanganku/backend/database/model/income_category.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/components/buttons/k_button.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/form/k_numfield.dart';
import 'package:keuanganku/frontend/components/form/k_textfield.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/datetime_format.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';
import 'package:keuanganku/main.dart';
import 'package:quickalert/quickalert.dart';

class IncomeForm extends StatefulWidget {
  final void Function(DBModelIncome data) callbackWhenDataSaved;
  final List<DBModelWallet> wallets;
  final List<DBModelIncomeCategory> incomeCategories;
  const IncomeForm({super.key,required this.wallets, required this.incomeCategories,  required this.callbackWhenDataSaved});

  @override
  State<IncomeForm> createState() => _IncomeFormState();
}

class _IncomeFormState extends State<IncomeForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late TextEditingController titleController;
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  late DBModelIncomeCategory categoryController;

  late DateTime dateController;
  late TextEditingController dateTextController;

  late TimeOfDay timeController;
  late TextEditingController timeTextController;

  late DBModelWallet walletController;

  late bool inited;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    amountController = TextEditingController();
    dateTextController = TextEditingController();
    descriptionController = TextEditingController();
    timeTextController = TextEditingController();
    walletController = widget.wallets[0];
    categoryController = widget.incomeCategories[0];
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
  void whenButtonSavePressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        // Verification
        if (double.tryParse(amountController.text) == null) {
          throw Exception('Invalid amount, try again.');
        }
        DBModelIncome income = DBModelIncome(
          title: titleController.text,
          amount: double.tryParse(amountController.text),
          description: descriptionController.text,
          wallet_id: 1,
          datetime: combineDateTimeAndTimeOfDay(dateController, timeController),
          category_id: categoryController.id,
        );
        DBHelperIncome().save(db: db.database, data: income).then((result) {
          if (result) {
            widget.callbackWhenDataSaved(income);
            QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: 'Data saved successfully',
                showConfirmBtn: true)
                .then((_) {
              Navigator.of(context).pop();
            });
          } else {
            throw Exception('Failed when save data');
          }
        });
      } catch (e) {
        QuickAlert.show(
            text: e.toString(),
            context: context,
            type: QuickAlertType.error,
            showConfirmBtn: true);
      }
    }
  }

  void whenButtonClearPressed() {
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
      kTextField(context,
          controller: titleController,
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
      kNumField(
          context,
          controller: amountController,
          title: 'Amount',
          icon: const Icon(Icons.attach_money),
          maxVal: 10000000000
      ),
      dummyHeight(22.5),
      Row(
        children: [
          SizedBox(
            width: vw(context, 60),
            child: kDropdown<DBModelIncomeCategory>(
              label: 'Category',
              context,
              items: widget.incomeCategories,
              itemsAsString: List<String>.generate(widget.incomeCategories.length, (index){
                return widget.incomeCategories[index].name!;
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
        label: 'Wallet',
        items: widget.wallets,
        itemsAsString: List<String>.generate(widget.wallets.length, (index){
          return widget.wallets[index].name!;
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
          kText(context, 'Income', KTStyle.title, KTSType.large),
          kText(context, 'Insert new income data.', KTStyle.label,
              KTSType.medium),
          ...fields(context),
          Row(
            children: [
              k_button(
                  context, text: 'Save', () => whenButtonSavePressed(context)),
              dummyWidth(10),
              k_button(
                  context,
                  mainColor: BaseColor.old_red.color,
                  text: 'Clear',
                  whenButtonClearPressed)
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