import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/models/expense.dart';

import 'package:spend_smart/widgets/expense_list.dart';

Box expenseBox = Hive.box('expenses');

class TodayExpenses extends StatelessWidget {
  const TodayExpenses({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: expenseBox.listenable(),
        builder: (context, value, child) => Container(
          child: expenseBox.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/bonbon-brown-bear.png',
                        width: 240,
                      ),
                      const SizedBox(height: 48),
                      const Text(
                        'No expenses',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: ValueListenableBuilder(
                        valueListenable: expenseBox.listenable(),
                        builder: (context, value, child) => Text(
                          '₹ ${List<Expense>.from(value.values.toList()).fold(0, (previousValue, element) => previousValue + element.amount)}',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ExpenseList(
                        onExpenseDeleted: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Expense deleted.'),
                              action: SnackBarAction(label: 'Undo', onPressed: () {}),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      );
}
