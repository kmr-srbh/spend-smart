import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/models/expense.dart';

import 'package:spend_smart/widgets/Overview/overview_expenses_list.dart';
import 'package:spend_smart/widgets/data_manager.dart';

class Overview extends StatelessWidget {
  Overview({super.key});

  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
      valueListenable: dataManager.expenseBox.listenable(),
      builder: (context, value, child) {
        List<List<Expense>> Overview = dataManager.expenseBox.values
            .map((element) => List<Expense>.from(element))
            .toList();
        List<Map<String, dynamic>> expensesData = [];
        for (List<Expense> expensesList in Overview) {
          if (expensesList.isNotEmpty) {
            expensesData.add({
              'date': expensesList[0].formattedDate,
              'totalTransactions': expensesList.length,
              'totalAmount': expensesList.fold(
                  0, (previousValue, element) => previousValue + element.amount)
            });
          } else {
            break;
          }
        }
        return expensesData.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/woolly-hand-with-mobile-phone.png',
                      width: 200,
                    ),
                    const SizedBox(height: 36),
                    const Text(
                      'All your past expenses\n will be shown here',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            : Column(children: [
                Expanded(
                    child: OverviewExpensesList(expensesData: expensesData)),
              ]);
      });
}
