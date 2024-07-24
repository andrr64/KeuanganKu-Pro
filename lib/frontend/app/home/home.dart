import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:keuanganku/frontend/components/navbar/drawer.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/app/home/widgets/balance_card.dart';
import 'package:keuanganku/frontend/app/home/widgets/expense_card.dart';
import 'package:keuanganku/frontend/app/home/widgets/income_card.dart';
import 'package:keuanganku/frontend/utility/k_color.dart';

class PageData {
  IncomeCardData incomeCardData = IncomeCardData(dateRangeValue: DateRange.monthly);
  ExpenseCardData expenseCardData = ExpenseCardData(dateRangeValue: DateRange.monthly);
  BalanceCardData balanceCardData = BalanceCardData();
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  
  static PageData data = PageData();

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Widget content(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: vh(context, 2.5), horizontal: vw(context, 5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dummyHeight(10),
          BalanceCard(name: 'Andreas', balance: 12000000.00, data: Homepage.data.balanceCardData,),
          dummyHeight(25),
          IncomeCard(Homepage.data.incomeCardData),
          dummyHeight(25),
          ExpenseCard(Homepage.data.expenseCardData),
        ],
      ),
    );  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BackgroundColor.white.getColor(),
        title: kText(context, 'Home', KTStyle.title, KTSType.medium)
      ),
      drawer: drawer(context),
      backgroundColor: BackgroundColor.white.getColor(),
      body: SingleChildScrollView(
        child: content(context),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: BackgroundColor.white.getColor(),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Expense'),
        ],
      ),
    );
  }
}
