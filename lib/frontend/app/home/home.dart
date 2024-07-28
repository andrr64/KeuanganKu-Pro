import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keuanganku/frontend/app/home/widgets/balance_card.dart';
import 'package:keuanganku/frontend/app/home/widgets/income_card.dart';
import 'package:keuanganku/frontend/components/enum/date_range.dart';
import 'package:keuanganku/frontend/components/utility/space_x.dart';
import 'package:keuanganku/frontend/components/utility/space_y.dart';

final _incomeCardDateRange = StateProvider<DateRange>((_) => DateRange.week);

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: vh(context, 2.5),
          horizontal: vw(context, 5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dummyHeight(10),
            const BalanceCard(),
            dummyHeight(25),
            IncomeCard(
              dateRangeProvider: _incomeCardDateRange,
            ),
          ],
        ),
      ),
    );
  }
}
