import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/models/expense.dart';

import 'package:spend_smart/data_manager.dart';
import 'package:spend_smart/widgets/Today/today_expenses_list.dart';

class TodayExpenses extends StatelessWidget {
  TodayExpenses({super.key});

  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    final Box expenseBox = dataManager.expenseBox;
    final DateTime today = DateTime.now();
    final String boxKey = dataManager.boxKey(today);
    dataManager.createBoxIfAbsent(today);

    return ValueListenableBuilder(
      valueListenable: expenseBox.listenable(keys: [boxKey]),
      builder: (context, value, child) {
        int totalExpenses = List<Expense>.from(expenseBox.get(boxKey)).fold(
            0, (previousValue, element) => previousValue + element.amount);
        return Container(
          child: totalExpenses == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/casual-life-3d-cardboard-boxes.png',
                        width: 300,
                      ),
                      const SizedBox(height: 36),
                      const Text(
                        'No expenses.',
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
