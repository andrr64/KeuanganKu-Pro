import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/model/expense.dart';
import 'package:keuanganku/backend/database/model/expense_category.dart';
import 'package:keuanganku/backend/database/model/wallet.dart';
import 'package:keuanganku/frontend/app/forms/category_form.dart';
import 'package:keuanganku/frontend/app/main/analysis/analysis.dart';
import 'package:keuanganku/frontend/app/main/empty_wallet_warning.dart';
import 'package:keuanganku/frontend/app/snackbar.dart';
import 'package:keuanganku/frontend/colors/font_color.dart';
import 'package:keuanganku/frontend/components/buttons/k_outlined_button.dart';
import 'package:keuanganku/frontend/components/form/k_dropdown.dart';
import 'package:keuanganku/frontend/components/form/k_numfield.dart';
import 'package:keuanganku/frontend/components/form/k_textfield.dart';
import 'package:keuanganku/frontend/components/icon_rating.dart';
import 'package:keuanganku/frontend/components/spacer/v_space.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/utility/datetime_format.dart';
import 'package:keuanganku/frontend/colors/base_color.dart';
import 'package:keuanganku/frontend/utility/page.dart';

const expense_importants_text = [
  'absolutely unnecessary',
  'unnecessary',
  'moderate',
  'necessary',
  'absolutely necessary',
];

class ExpenseForm extends StatefulWidget {
  final void Function(DBModelExpense) callbackWhenSubmitNewExpense;
  final List<DBModelExpenseCategory> expenseCategories;
  final List<DBModelWallet> wallets;
  final void Function(DBModelExpenseCategory)
      callbackWhenSubmitNewExpenseCategory;

  const ExpenseForm(
      {super.key,
      required this.callbackWhenSubmitNewExpenseCategory,
      required this.callbackWhenSubmitNewExpense,
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
  int rating = 1;
  late DBModelWallet walletController;
  late DateTime dateController;
  late TextEditingController dateTextController;

  late TimeOfDay timeController;
  late TextEditingController timeTextController;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    amountController = TextEditingController();
    dateTextController = TextEditingController();
    descriptionController = TextEditingController();
    timeTextController = TextEditingController();
    if (widget.wallets.isNotEmpty) {
      walletController = widget.wallets[0];
    }
    if (widget.expenseCategories.isNotEmpty) {
      categoryController = widget.expenseCategories[0];
    }
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

  void whenButtonSavePressed(BuildContext context) {
    if (!loading) {
      loading = true;
      if (_formKey.currentState!.validate()) {
        try {
          final newExpense = DBModelExpense(
              title: titleController.text,
              amount: double.parse(amountController.text),
              description: titleController.text,
              wallet_id: walletController.id,
              category_id: categoryController.id,
              rate: rating,
              datetime:
                  combineDateTimeAndTimeOfDay(dateController, timeController));
          newExpense.insert().then((_) {
            widget.callbackWhenSubmitNewExpense(
                newExpense); // update local.wallet total_expense
            REFRESH_AnalysisPage(context);
            closePage(context);
            showSnackbar(context, successSnackBar('Data saved'));
          });
        } catch (e) {
          showSnackbar(context, successSnackBar('Error: $e'));
        }
      }
      loading = false;
    }
  }

  void whenButtonClearPressed() {
    titleController.clear();
    amountController.clear();
    descriptionController.clear();
    whenDatePicked(DateTime.now());
    whenTimePicked(TimeOfDay.fromDateTime(dateController));
  }

  void whenButtonAddCategoryPressed(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 200.0, // Batas tinggi maksimal
                  maxWidth: vw(dialogContext, 80)),
              child: categoryForm(key, dialogContext,
                  controller: nameController, callbackWhenSubmit: () async {
                if (key.currentState!.validate()) {
                  if (!loading) {
                    loading = true;
                    DBModelExpenseCategory newCategory =
                        DBModelExpenseCategory(name: nameController.text);
                    closePage(dialogContext);
                    try {
                      await newCategory.insert();
                      widget.callbackWhenSubmitNewExpenseCategory(newCategory);
                      widget.expenseCategories.add(newCategory);
                      showSnackbar(context, successSnackBar('Data saved'));
                      setState(() {});
                    } catch (e) {
                      showSnackbar(context, errorSnackBar('Error: $e'));
                    }
                    loading = false;
                  }
                }
              }),
            ),
          );
        });
  }

  void whenDatePicked(DateTime date) {
    dateController = date;
    dateTextController.text = dateFormat(date, 'dd/M/yyyy');
  }

  void whenTimePicked(TimeOfDay time) {
    timeController = time;
    timeTextController.text = formatTimeOfDay(time, is24HourFormat: true);
  }

  List<Widget> fields(BuildContext context) {
    return [
      vspace_22_5,
      kTextField(context, controller: titleController, title: 'Title',
          validator: (value) {
        if (value == null || value.isEmpty) {
          return "Title can't empty";
        }
        return null;
      }, icon: const Icon(Icons.title), maxLines: 1),
      vspace_22_5,
      kNumField(context,
          controller: amountController,
          title: 'Amount',
          icon: const Icon(Icons.attach_money),
          maxVal:
              walletController.total_income! - walletController.total_expense!),
      vspace_22_5,
      Row(
        children: [
          SizedBox(
            width: vw(context, 60),
            child: kDropdown<DBModelExpenseCategory>(
              context,
              label: 'Category',
              items: widget.expenseCategories,
              itemsAsString: widget.expenseCategories.map((e) {
                return e.name!;
              }).toList(),
              value: categoryController,
              onChanged: (e) {
                if (e != null) categoryController = e;
              },
            ),
          ),
          dummyWidth(vw(context, 2.5)),
          //TODO: handle when user want to add new category
          KOutlinedButton(
              onPressed: () {
                whenButtonAddCategoryPressed(context);
              },
              text: 'Add',
              icon: const Icon(Icons.add)),
        ],
      ),
      vspace_22_5,
      kDropdown<DBModelWallet>(
        context,
        label: 'Wallets',
        items: widget.wallets,
        itemsAsString: widget.wallets.map((e) {
          return e.name!;
        }).toList(),
        value: walletController,
        onChanged: (e) {
          walletController = e ?? walletController;
        },
      ),
      vspace_22_5,
      kTextField(context,
          title: 'Description (optional)',
          controller: descriptionController,
          icon: const Icon(Icons.description),
          maxLines: 2),
      vspace_22_5,
      Row(
        children: [
          SizedBox(
            width: vw(context, 50),
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
            width: vw(context, 32.5),
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
      vspace_15,
      kText(context, 'How important is this expense?', KTStyle.title,
          KTSType.medium),
      vspace_15,
      Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(width: 0.75, color: Colors.black54)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 5,
                  child: IconRatingBar5(
                      icon: Icons.circle,
                      colors: const [
                        Colors.red,
                        Colors.orange,
                        Colors.yellow,
                        Colors.lightGreen,
                        Colors.green
                      ],
                      rating: rating,
                      callback: (e) {
                        if (e != rating) {
                          rating = e;
                          setState(() {});
                        }
                      })),
              Expanded(
                  flex: 7,
                  child: kText(
                      context,
                      'It\'s ${expense_importants_text[rating - 1]}',
                      KTStyle.label,
                      KTSType.large))
            ],
          ),
        ),
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
          kText(context, 'Expense', KTStyle.title, KTSType.large),
          kText(context, 'Insert new expense data.', KTStyle.label,
              KTSType.medium),
          ...fields(context),
          Row(
            children: [
              KOutlinedButton(
                  onPressed: () => whenButtonSavePressed(context),
                  color: const Color(0xff377550),
                  text: 'Save'),
              dummyWidth(10),
              KOutlinedButton(
                  onPressed: whenButtonClearPressed,
                  color: baseColor_dark_red,
                  text: 'Clear'),
            ],
          )
        ],
      ),
    );
  }

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

  Widget buildWhenListOrCategoryIsEmpty(BuildContext context) {
    return const EmptyWalletWarning();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.wallets.isEmpty || widget.expenseCategories.isEmpty) {
      return buildWhenListOrCategoryIsEmpty(context);
    }
    return content(context);
  }
}
