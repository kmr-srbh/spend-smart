import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/data_manager.dart';

import 'package:spend_smart/models/expense.dart';

import 'package:spend_smart/widgets/Overview/overview_chart.dart';
import 'package:spend_smart/widgets/Overview/overview_expenses_list.dart';


class Overview extends StatelessWidget {
  Overview({super.key});

  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: dataManager.expenseBox.listenable(),
        builder: (context, value, child) {
          List<List<Expense>> allExpenses = dataManager.expenseBox.values
              .map((element) => List<Expense>.from(element))
              .toList();
          List<Map<String, dynamic>> expensesData = [];
          for (List<Expense> expensesList in allExpenses) {
            if (expensesList[0].amount == 0) {
              expensesData.add({
                'date': expensesList[0].date,
                'totalTransactions': 0,
                'totalAmount': 0
              });
            } else {
              expensesData.add({
                'date': expensesList[0].date,
                'totalTransactions': expensesList.length,
                'totalAmount': expensesList.fold(0,
                    (previousValue, element) => previousValue + element.amount)
              });
            }
          }
          expensesData.sort((firstExpense, secondExpense) =>
              secondExpense['date'].compareTo(firstExpense['date']));
          return Column(children: [
            expensesData.length == 1 && expensesData[0]['totalAmount'] == 0
                ? const SizedBox()
                : OverviewChart(expensesData: expensesData),
            Expanded(child: OverviewExpensesList(expensesData: expensesData)),
          ]);
        },
      );
}
