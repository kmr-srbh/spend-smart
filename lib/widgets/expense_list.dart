import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/models/expense.dart';
import 'package:spend_smart/widgets/data_manager.dart';

import 'package:spend_smart/widgets/expense_card.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({
    super.key,
  });

  final DataManager dataManager = DataManager();

  @override
  Widget build(BuildContext context) {
    final Box expenseBox = dataManager.expenseBox;
    return ValueListenableBuilder(
      valueListenable: expenseBox.listenable(keys: [dataManager.boxKey]),
      builder: (context, expenses, child) {
        final List<Expense> allExpenses = List<Expense>.from(expenses.get(dataManager.boxKey));
        return ListView.builder(
          itemCount: dataManager.expenses.length,
          itemBuilder: (buildContext, index) {
            final Expense expense = allExpenses[index];
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: ColoredBox(
                color: Theme.of(context).colorScheme.error,
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Icon(
                      Icons.delete_rounded,
                      size: 36,
                    ),
                  ),
                ),
              ),
              onDismissed: (direction) {
                dataManager.remove(expense);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Expense deleted.'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        dataManager.add(expense);
                      },
                    ),
                  ),
                );
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
}
