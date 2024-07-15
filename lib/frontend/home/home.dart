import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:keuanganku/frontend/components/navbar/drawer.dart';
import 'package:keuanganku/frontend/components/text/k_text.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/home/widgets/balance_card.dart';
import 'package:keuanganku/frontend/home/widgets/expense_card.dart';
import 'package:keuanganku/frontend/home/widgets/income_card.dart';

class PageData {
  IncomeCardData incomeCardData = IncomeCardData(dateRangeValue: DateRange.monthly);
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
          dummyHeight(15),
          const BalanceCard(name: 'Andreas', balance: 12000000.00),
          dummyHeight(30),
          IncomeCard(Homepage.data.incomeCardData),
          dummyHeight(30),
          const ExpenseCard(),
        ],
      ),
    );  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: KText(context, 'Home', KTextStyle.title, KTextStyleType.medium)
      ),
      drawer: drawer(context),
      body: SingleChildScrollView(
        child: content(context),
      ),
    );
  }
}
