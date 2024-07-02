import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/components/navbar/drawer.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';
import 'package:keuanganku/frontend/home/components/balance_card.dart';
import 'package:keuanganku/frontend/home/components/income_card.dart';

Widget content(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: vh(context, 2.5), horizontal: vw(context, 5)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BalanceCard(name: 'Andreas', balance: 12000000.00),
        dummyHeight(27.5),
        const IncomeCard(),
      ],
    ),
  );
}
  
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: Theme.of(context).textTheme.titleMedium,),
      ),
      drawer: drawer(context),
      body: content(context),
    );
  }
}
