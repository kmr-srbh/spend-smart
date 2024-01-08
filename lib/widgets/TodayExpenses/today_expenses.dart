import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/models/expense.dart';

import 'package:spend_smart/widgets/data_manager.dart';
import 'package:spend_smart/widgets/TodayExpenses/today_expenses_list.dart';

class TodayExpenses extends StatelessWidget {
  TodayExpenses({super.key});

  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    final Box expenseBox = dataManager.expenseBox;
    final DateTime today = DateTime.now();
    final String boxKey = dataManager.createBoxKey(today);

    return ValueListenableBuilder(
      valueListenable: expenseBox.listenable(keys: [boxKey]),
      builder: (context, value, child) {
        int totalExpenses = List<Expense>.from(expenseBox.get(boxKey) ?? [])
            .fold(
                0, (previousValue, element) => previousValue + element.amount);
        return Container(
          child: totalExpenses == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/woolly-silver-safe-with-dollars-flying-out.png',
                        width: 240,
                      ),
                      const SizedBox(height: 36),
                      const Text(
                        'Seems like you are on\n a saving spree today',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        '₹ $totalExpenses',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TodayExpensesList(boxKey: boxKey),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
