import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:spend_smart/models/expense.dart';

import 'package:spend_smart/widgets/Today/today_expense_card.dart';
import 'package:spend_smart/widgets/data_manager.dart';

class TodayExpensesList extends StatelessWidget {
  TodayExpensesList({
    super.key,
    required this.boxKey,
  });

  final DataManager dataManager = DataManager();
  final String boxKey;

  @override
  Widget build(BuildContext context) {
    final Box expenseBox = dataManager.expenseBox;

    final List<Expense> expenses = List<Expense>.from(expenseBox.get(boxKey));
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (buildContext, index) {
        final Expense expense = expenses[index];
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
                  icon: const Icon(Icons.delete_forever_rounded),
                  title: const Text('Delete?'),
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
                      child: const Text('Yes'),
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
  }
}
