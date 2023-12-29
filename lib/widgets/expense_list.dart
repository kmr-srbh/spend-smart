import 'package:flutter/material.dart';

import 'package:spend_smart/models/expense.dart';
import 'package:spend_smart/widgets/expense_card.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.removeExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (buildContext, index) => Dismissible(
          key: ValueKey(expenses[index]),
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
          onDismissed: (direction) {
            removeExpense(expenses[index]);
          },
          confirmDismiss: (direction) async {
            return await showDialog(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  title: const Text(
                      'Are you sure you want to delete this expense?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop(true);
                      },
                      child: const Text('Yes, delete'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop(false);
                      },
                      child: const Text('No'),
                    )
                  ],
                );
              },
            );
          },
          child: ExpenseCard(expense: expenses[index]),
        ),
      );
}
