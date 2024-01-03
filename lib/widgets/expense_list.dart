import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/models/expense.dart';

import 'package:spend_smart/widgets/expense_card.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.onExpenseDeleted,
  });

  final void Function() onExpenseDeleted;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Hive.box('expenses').listenable(),
        builder: (context, expenses, child) {
          double toDouble(TimeOfDay time) => time.hour + time.minute / 60.0;
          final List<Expense> registeredExpenses =
              List<Expense>.from(expenses.values.toList());
          registeredExpenses.sort(
            (a, b) => toDouble(b.time).compareTo(toDouble(a.time)),
          );
          return ListView.builder(
            itemCount: registeredExpenses.length,
            itemBuilder: (buildContext, index) {
              final expense = registeredExpenses[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: ColoredBox(
                  color: Theme.of(context).colorScheme.error,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 24),
                      child: Icon(Icons.delete_rounded),
                    ),
                  ),
                ),
                onDismissed: (direction) async {
                  await expenses
                      .deleteAt(expenses.values.toList().indexOf(expense));
                  onExpenseDeleted();
                },
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Row(children: [
                          Icon(Icons.error_outline_rounded),
                          SizedBox(width: 8),
                          Text('Delete?')
                        ]),
                        content: const Text(
                            'Are you sure you want to delete this expense?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop(false);
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop(true);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onError,
                            ),
                            child: const Text('Yes, delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: ExpenseCard(expense: expense),
              );
            },
          );
        },
      );
}
