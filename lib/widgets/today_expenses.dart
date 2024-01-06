import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/models/expense.dart';
import 'package:spend_smart/widgets/add_expense_form.dart';
import 'package:spend_smart/widgets/data_manager.dart';

import 'package:spend_smart/widgets/expense_list.dart';

class TodayExpenses extends StatelessWidget {
  TodayExpenses({super.key});

  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    final Box expenseBox = dataManager.expenseBox;
    return ValueListenableBuilder(
      valueListenable: expenseBox.listenable(keys: [dataManager.boxKey]),
      builder: (context, value, child) {
        int totalExpenses =
            List<Expense>.from(expenseBox.get(dataManager.boxKey)).fold(
                0, (previousValue, element) => previousValue + element.amount);
        return Stack(
          children: [
            totalExpenses == 0
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
                        child: Text(
                          '₹ $totalExpenses',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ExpenseList(),
                      ),
                    ],
                  ),
            Positioned(
              bottom: 16,
              right: 16,
              child: FloatingActionButton.extended(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => const AlertDialog(
                      title: Text('Add expense'),
                      content: SingleChildScrollView(
                        child: AddExpenseForm(),
                      ),
                    ),
                  );
                },
                label: const Text('Add expense'),
                icon: const Icon(Icons.add_rounded),
              ),
            )
          ],
        );
      },
    );
  }
}
